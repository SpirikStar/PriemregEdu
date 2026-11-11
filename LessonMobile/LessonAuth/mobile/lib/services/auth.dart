import 'package:flutter/foundation.dart';

class AuthService extends ChangeNotifier {
  String? login(String login, String password) {
    final normalized = login.trim();

    if (normalized.isEmpty || password.isEmpty) {
      return 'Введите логин и пароль';
    }
  }
}
