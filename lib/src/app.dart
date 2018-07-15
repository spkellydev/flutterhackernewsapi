import 'package:flutter/material.dart';
import 'screens/home.dart';

class App extends StatelessWidget {
  Widget build() {
    return MaterialApp(
      title: 'Hacker News API',
      builder: Home(),
    );
  }
}
