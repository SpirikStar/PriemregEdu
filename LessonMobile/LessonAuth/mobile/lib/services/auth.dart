import 'package:flutter/foundation.dart';
import 'package:mobile/models/user.dart';

class AuthService extends ChangeNotifier {
  User? _currentUser;
  User? get currentUser => _currentUser;
  bool get isLoggedIn => _currentUser != null;

  String? login(String login, String password) {
    final normalized = login.trim();

    if (normalized.isEmpty || password.isEmpty) {
      return 'Введите логин и пароль';
    }

    if (normalized != 'admin' || password != 'admin') {
      return 'Неверный логин или пароль';
    }
    _currentUser = User(login: normalized, password: password);
    notifyListeners();

    return null;
  }
}
