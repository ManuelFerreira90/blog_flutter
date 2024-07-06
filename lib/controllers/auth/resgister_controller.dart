import 'package:blog_mobile/api/auth/auth_service.dart';
import 'package:blog_mobile/models/user.dart';

class ResgisterController {
  late Map<String, dynamic> _body;
  late User? _user;
  String _error = '';
  bool _sucessRegister = false;

  ResgisterController();

  Future<void> register(
      String userName, String phone, String email, String password) async {
    _body = await AuthService.register(userName, phone, email, password);
    _sucessRegister = _body['sucess'];
    if (!_sucessRegister) {
      _error = _body['error'] ?? 'An error occurred';
    } else {
      _user = User(_body['user']['id'], null, null, _body['user']['email'],
          _body['user']['username'], null, null, _body['user']['phone']);
    }
  }

  Future<void> controlRegister(
      String userName, String phone, String email, String password) async {
    await register(userName, phone, email, password);
  }

  bool get getSucessRegister {
    return _sucessRegister;
  }

  String get getError {
    return _error;
  }

  User? get getUser {
    return _user;
  }
}
