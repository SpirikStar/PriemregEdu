import 'package:flutter/material.dart';
import 'package:mobile/screens/home.dart';

import 'package:mobile/screens/login.dart';
import 'package:mobile/services/auth.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Войти',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: const Color.fromRGBO(88, 88, 246, 1)),
      ),
      home: ListenableBuilder(
        listenable: _auth,
        builder: (context, _) {
          final user = _auth.currentUser;
          if (user == null) {
            return Login(auth: _auth);
          }
          return Home(auth: _auth, user: user);
        },
      ),
    );
  }
}
// TODO: Для пароля добавить "Скрыто".
// TODO: Реализовать кнопку "Выйти из ЛК"
// TODO: В ЛК добавить приветствие 
// TODO: Кнопку "Войти" сделать ширину как input
// TODO: BorderRadius сделать единым для всех