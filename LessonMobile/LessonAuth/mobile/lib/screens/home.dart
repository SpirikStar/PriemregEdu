import 'package:flutter/material.dart';
import 'package:mobile/models/user.dart';
import 'package:mobile/services/auth.dart';

class Home extends StatelessWidget {
  const Home({super.key, required auth, required user});

  // final AuthService auth;
  // final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('Личный кабинет')));
  }
}
