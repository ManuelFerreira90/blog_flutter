import 'package:blog_mobile/api/auth/auth_service.dart';
import 'package:blog_mobile/models/user.dart';

class CheckController{
  bool _isLogged = false;
  User? _user;

  CheckController(){
    _checkUser();
  }

  Future<void> _checkUser() async{
    _user = await AuthService.currentAuthUser();
    _isLogged = _user != null;
  }

  bool get isLogged{
    return _isLogged;
  }

  User? get user{
    return _user;
  }

}