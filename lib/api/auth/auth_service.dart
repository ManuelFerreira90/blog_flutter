import 'dart:convert';
import 'dart:io';

import 'package:blog_mobile/api/endpoints.dart';
import 'package:blog_mobile/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AuthService {
  static void login(String userName, String password) async {
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

      if (response.statusCode == 200) {
        Map<String, dynamic> user = jsonDecode(response.body);

        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token', user['token']);
      } else {
        print('error: status code ${response.statusCode}');
      }
    } catch (error) {
      if (error is HttpException) {
        print('Network error: ${error.message}');
      } else if (error is FormatException) {
        print('JSON parsing error: ${error.message}');
      } else {
        print('Unexpected error: $error');
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
              user['firstName'],
              user['lastName'],
              user['email'],
              user['userName'],
              user['birthDate'],
              user['image'],
              user['country'],
              user['phone']);
        } else {
          print('error: status code ${response.statusCode}');
          return null;
        }
      } else {
        print('sem token');
        return null;
      }
    } catch (error) {
      if (error is HttpException) {
        print('Network error: ${error.message}');
      } else if (error is FormatException) {
        print('JSON parsing error: ${error.message}');
      } else {
        print('Unexpected error: $error');
      }
      return null;
    }
  }
}
