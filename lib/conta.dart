//visualizar conta
import 'package:flutter/material.dart';

class Conta extends StatelessWidget {
  final String cpf;
  final String month;

  Conta({required this.cpf, required this.month});

  @override
  Widget build(BuildContext context) {
    // Aqui você pode buscar a conta com base no CPF e no mês e exibi-la nesta tela.
    // Por enquanto, apenas exibimos os valores inseridos.
    return Scaffold(
      appBar: AppBar(
        title: Text('Conta a Pagar'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('CPF: $cpf'),
            Text('Mês: $month'),
            // Exiba os detalhes da conta aqui
          ],
        ),
      ),
    );
  }
}
