import 'package:blog_mobile/api/auth/auth_service.dart';

class LoginController {
  late Map<String, dynamic>? _body;
  late String _userName;
  late String _password;
  late String? _error;
  bool _sucessLogin = false;

  LoginController(){
    _userName = '';
    _password = '';
  }

  Future<void> login() async{
    _body = await AuthService.login(_userName, _password);
    if(_body != null){
      _sucessLogin = _body!['sucess'];
      if(!_sucessLogin){
        try {
          _error = _body!['error'] ?? 'An error occurred';
        } catch (e) {
          _error = 'An error occurred: $e';
        }
      }
    }
  }

  set setUserName(String userName){
    _userName = userName;
  }

  set setPassword(String password){
    _password = password;
  }

  bool get getSucessLogin{
    return _sucessLogin;
  }

  String? get getError{
    return _error;
  }

  Future<void> controlLogin(String userName, String password) async{
    setUserName = userName;
    setPassword = password;
    await login();
  }
}