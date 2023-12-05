import 'package:autoleitura/autoleiturascreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  // Carregar as configurações do arquivo .env
  await dotenv.load(fileName: ".env/.env");

  runApp(const AutoLeituraApp());
}

class AutoLeituraApp extends StatelessWidget {
  const AutoLeituraApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Auto Leitura',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.black,
      ),
      home: const AutoLeituraScreen(),
    );
  }
}
