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
        appBar: AppBar(title: Text("Information")),
        body: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                print("WEll 1!");
              },
              child: Text("Send", style: TextStyle(fontSize: 22)),
            ),
            ElevatedButton.icon(
              onPressed: () {
                print("WEll 2!");
              }, 
              label: Text("Send icon", style: TextStyle(fontSize: 22)),
              icon: Icon(Icons.ac_unit_outlined),
            )
          ],
        ),
      ),
    );
  }
}
