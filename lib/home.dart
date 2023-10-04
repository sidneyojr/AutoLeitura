import 'package:autoleitura/login.dart';

import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('AUTO LEITURA'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Seja Bem-Vindo ao sistema de Auto Leitura"),
            SizedBox(height: 25),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Login()));
                },
                child: const Text('Próxima Página')),
            // Container(
            //   color: Colors.lightBlueAccent,
            //   width: 300,
            //   height: 200,
            // ),
            // Container(
            //   color: Colors.amber,
            //   width: 300,
            //   height: 200,
            // ),
            // Container(
            //   color: Colors.blueGrey,
            //   width: 300,
            //   height: 200,
            // ),
          ],
        ),
      ),
    );
  }
}
