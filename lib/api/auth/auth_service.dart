import 'dart:convert';
import 'dart:io';

import 'package:blog_mobile/api/endpoints.dart';
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
        throw HttpException('error: status code ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('error: $error');
    }
  }
}
