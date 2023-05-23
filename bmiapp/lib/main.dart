import 'package:flutter/material.dart';
import 'pageinfo.dart';

void main(List<String> args) {
  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(80),
            child: Container(
              child: Pageinfo(),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          'https://wallpapercave.com/wp/wp8665558.jpg'),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
            ),
          ),
        ),
      ),
    );
  }
}
