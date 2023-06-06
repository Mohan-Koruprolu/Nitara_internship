import 'package:flutter/material.dart';
import 'package:recipie_app/homepage.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Recipie search",
            style: TextStyle(letterSpacing: 1.5, wordSpacing: 2),
          ),
        ),
        body: Center(
          child: Homepage(),
        ),
      ),
    );
  }
}
