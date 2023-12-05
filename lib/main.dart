import 'package:autoleitura/autoleiturascreen.dart';
import 'package:flutter/material.dart';

// DotEnv dotenv = DotEnv() is automatically called during import.
// If you want to load multiple dotenv files or name your dotenv object differently, you can do the following and import the singleton into the relavant files:
// DotEnv another_dotenv = DotEnv()

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
