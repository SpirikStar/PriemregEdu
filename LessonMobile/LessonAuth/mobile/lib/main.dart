import 'package:flutter/material.dart';

import 'package:mobile/screens/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Войти',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: const Color.fromRGBO(88, 88, 246, 1)),
      ),
      home: Login(), // ! Добавить проверку на существующие сессии
    );
  }
}
