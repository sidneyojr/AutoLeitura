import 'package:autoleitura/autoleiturascreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const AutoLeitura());
}

class AutoLeitura extends StatelessWidget {
  const AutoLeitura({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Teste API',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.black,
      ),
      home: const AutoLeituraScreen(),
    );
  }
}
