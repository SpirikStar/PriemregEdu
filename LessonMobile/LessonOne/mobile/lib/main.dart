import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('width and height - size.'),
                Image.asset(
                  'assets/images/image-1.png',
                  width: 80,
                  height: 80,
                ),
                SizedBox(height: 24),
                Text('BoxFit.contain - full photo'),
                Image.asset(
                  'assets/images/image-1.png',
                  width: 200,
                  height: 120,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: 24),
                Text('BoxFit.cover - cover photo'),
                Image.asset(
                  'assets/images/image-1.png',
                  width: 200,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ]
            ),
          )
        ),
      ),
    );
  }
}