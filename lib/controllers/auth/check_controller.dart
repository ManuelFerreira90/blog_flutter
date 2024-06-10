import 'dart:async';

import 'package:blog_mobile/api/auth/auth_service.dart';
import 'package:blog_mobile/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckController {
  bool _isLogged = false;
  User? _user;

  CheckController();

  Future<void> _checkUser(String token) async {
    _user = await AuthService.currentAuthUser(token);
    _isLogged = _user != null;
  }

  Future<void> controlCheckUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token != null) {
      await _checkUser(token);
    } else {
      _user = null;
    }
  }

  bool get isLogged {
    return _isLogged;
  }

  User? get user {
    return _user;
  }
}
