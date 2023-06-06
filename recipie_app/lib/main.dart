import 'package:flutter/material.dart';
import 'package:recipie_app/homepage.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Homepage(),
        ),
      ),
    );
  }
}
