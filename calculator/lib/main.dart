import "package:flutter/material.dart";
import 'calculatorui.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Calculator"),
        ),
        body: Calculatorpage(),
      ),
    );
  }
}
