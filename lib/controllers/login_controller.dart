import 'package:blog_mobile/api/auth_service.dart';

class LoginController {
  late Map<String, dynamic> _body;
  String _error = '';
  bool _sucessLogin = false;

  LoginController();

  Future<void> _login(String userName, String password) async {
    _body = await AuthService.login(userName, password);
    _sucessLogin = _body['sucess'];
    if (!_sucessLogin) {
      _error = _body['error'] ?? 'An error occurred';
    }
  }

  bool get getSucessLogin {
    return _sucessLogin;
  }

  String get getError {
    return _error;
  }

  Future<void> controlLogin(String userName, String password) async {
    await _login(userName, password);
  }
}
