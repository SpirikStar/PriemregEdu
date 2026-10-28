import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: "Dns market", home: const HomeScreen());
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final List<Widget> _page = [
    Center(child: Text('Главная', style: TextStyle(fontSize: 28))),
    Center(child: Text('Каталог', style: TextStyle(fontSize: 28))),
    Center(child: Text('Поиск', style: TextStyle(fontSize: 28))),
    Center(child: Text('Корзина', style: TextStyle(fontSize: 28))),
    Center(child: Text('Профиль', style: TextStyle(fontSize: 28))),
  ];
  void _onTabTapped(int index) { 
    setState(() {
      _currentIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(245, 247, 250, 255),
      appBar: AppBar(
        title: Text(
          'Dns market',
          style: TextStyle(fontWeight: FontWeight(600), color: Colors.orange),
        ),
        backgroundColor: Colors.white,
      ),
      body: _page[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        onTap: _onTabTapped,
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Главная'),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view),
            label: 'Каталог',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Поиск'),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: 'Корзина',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: 'Профиль',
          ),
        ],
      ),
    );
  }
}
