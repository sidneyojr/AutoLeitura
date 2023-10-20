import 'package:flutter/material.dart';
import 'package:autoleitura/conta.dart';

class Leitura extends StatefulWidget {
  final String codigo;

  Leitura({required this.codigo});

  @override
  _LeituraState createState() => _LeituraState();
}

class _LeituraState extends State<Leitura> {
  final leituraController = TextEditingController();
  late String nomeMes;

  @override
  void initState() {
    super.initState();
    nomeMes = _obterNomeMes(DateTime.now().month);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AUTOLEITURA'),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Coloque aqui a leitura do mês de $nomeMes',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              TextField(
                controller: leituraController,
                decoration: InputDecoration(labelText: 'Leitura do Mês'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _mostrarDialog(
                      context, widget.codigo, leituraController.text);
                },
                child: Text('Enviar Leitura'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _mostrarDialog(BuildContext context, String codigo, String leitura) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmação de Leitura'),
          content: Text(
            'Está correto sua leitura?\n\nValor da Leitura: ${double.parse(leitura)}',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Fecha o dialog
                _navegarParaConta(context, codigo, leitura);
              },
              child: Text('Sim'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Não'),
            ),
          ],
        );
      },
    );
  }

  void _navegarParaConta(BuildContext context, String codigo, String leitura) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return Conta(
            codigo: codigo,
            leitura: double.parse(leitura),
          );
        },
      ),
    );
  }

  String _obterNomeMes(int numeroMes) {
    const nomesMes = [
      'Janeiro',
      'Fevereiro',
      'Março',
      'Abril',
      'Maio',
      'Junho',
      'Julho',
      'Agosto',
      'Setembro',
      'Outubro',
      'Novembro',
      'Dezembro'
    ];
    return nomesMes[numeroMes - 1];
  }
}
