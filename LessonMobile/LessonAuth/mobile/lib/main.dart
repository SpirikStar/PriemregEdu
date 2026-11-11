import 'package:flutter/material.dart';

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
      home: Login(auth: _auth), // ! Добавить проверку на существующие сессии
    );
  }
}
