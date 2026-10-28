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
            ),
            Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => const SecondPage())
                    );
                  },
                  child: Text("Open page", style: TextStyle(fontSize: 22)),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Second page")),
        body: Center(
          child: Text("Null page", style: TextStyle(fontSize: 22)),
        )
    );
  }
}