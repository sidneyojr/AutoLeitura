//visualizar conta
import 'package:flutter/material.dart';
import 'package:autoleitura/home.dart';

// main
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}