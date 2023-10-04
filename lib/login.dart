// home
import 'package:autoleitura/conta.dart';
import 'package:flutter/material.dart';
//import 'package:autoleitura/main.dart';

class Login extends StatelessWidget {
  final cpfController = TextEditingController();
  final monthController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LOGIN / Informe o CPF e o Mês'),
        centerTitle: true, //centralizar o titulo do appbar
      ),
      body: Padding(
        padding: EdgeInsets.all(100),
        child: Column(
          children: [
            TextField(
              controller: cpfController,
              decoration: InputDecoration(labelText: 'CPF'),
            ),
            TextField(
              controller: monthController,
              decoration: InputDecoration(labelText: 'Mês'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Aqui você pode direcionar para a tela de exibição da conta
                // Se formos apresentar, seria bom apagar essa parte do codigo
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Conta(
                      cpf: cpfController.text,
                      month: monthController.text,
                    ),
                  ),
                );
              },
              child: Text('Visualizar Conta'),
            ),
          ],
        ),
      ),
    );
  }
}
