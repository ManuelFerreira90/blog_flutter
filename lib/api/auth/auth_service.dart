import 'dart:convert';
import 'dart:io';

import 'package:blog_mobile/api/endpoints.dart';
import 'package:blog_mobile/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AuthService {
  static Future<Map<String, dynamic>> login(
      String userName, String password) async {
    try {
      var url = Uri.https(Endpoints.urlApi, Endpoints.authLogin);
      Map<String, dynamic> body = {
        'username': userName.trim(),
        'password': password.trim(),
        'expiresInMins': 60,
      };

      var jsonBody = jsonEncode(body);

      final response = await http.post(url,
          body: jsonBody, headers: {'Content-Type': 'application/json'});

      Map<String, dynamic> responseBody = jsonDecode(response.body);

      if (response.statusCode == 200) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token', responseBody['token']);

        return {
          'sucess': true,
        };
      } else {
        return {
          'sucess': false,
          'error': responseBody['message'],
        };
      }
    } catch (error) {
      if (error is HttpException) {
        return {
          'sucess': false,
          'error': 'Network error: ${error.message}',
        };
      } else if (error is FormatException) {
        return {
          'sucess': false,
          'error': 'JSON parsing error: ${error.message}',
        };
      } else {
        return {
          'sucess': false,
          'error': 'Unexpected error: $error',
        };
      }
    }
  }

  static Future<User?> currentAuthUser() async {
    try {
      var url = Uri.https(Endpoints.urlApi, Endpoints.authMe);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token != null) {
        final response =
            await http.get(url, headers: {'Authorization': 'Bearer $token'});
        if (response.statusCode == 200) {
          Map<String, dynamic> user = jsonDecode(response.body);

          return User(
              user['id'],
              user['firstName'],
              user['lastName'],
              user['email'],
              user['userName'],
              user['birthDate'],
              user['image'],
              user['country'],
              user['phone']);
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (error) {
      if (error is HttpException) {
        return null;
      } else if (error is FormatException) {
        return null;
      } else {
        return null;
      }
    }
  }

  static Future<Map<String, dynamic>> register(
      String userName, String phone, String email, String password) async {
    try {
      var url = Uri.https(Endpoints.urlApi, Endpoints.addUser);
      Map<String, dynamic> body = {
        'username': userName.trim(),
        'phone': phone.trim(),
        'email': email.trim(),
        'password': password.trim(),
      };

      var jsonBody = jsonEncode(body);

      final response = await http.post(url,
          body: jsonBody, headers: {'Content-Type': 'application/json'});
      var responseBody = jsonDecode(response.body);
      if (response.statusCode == 201) {
        return {'sucess': true, 'user': responseBody};
      } else {
        return {'sucess': false, 'error': '${responseBody['message']}'};
      }
    } catch (error) {
      if (error is HttpException) {
        return {
          'sucess': false,
          'error': 'Network error: ${error.message}',
        };
      } else if (error is FormatException) {
        return {
          'sucess': false,
          'error': 'JSON parsing error: ${error.message}',
        };
      } else {
        return {
          'sucess': false,
          'error': 'Unexpected error: $error',
        };
      }
    }
  }
}
