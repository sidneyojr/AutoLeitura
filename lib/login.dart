import 'package:flutter/material.dart';
import 'package:autoleitura2/leitura.dart';

class Login extends StatelessWidget {
  final codigoUsuarioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AUTO LEITURA - LOGIN'),
        backgroundColor: Color.fromARGB(255, 0, 5, 8),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Coloque seu código aqui',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: codigoUsuarioController,
                decoration: InputDecoration(
                  labelText: 'Código Único de Usuário',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  _mostrarDialog(context, codigoUsuarioController.text);
                },
                child: Text('Enviar para Validação'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _mostrarDialog(BuildContext context, String codigo) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confira seu código'),
          content: Text(
              'Seu código é: $codigo\nConfira se seu código é este mesmo.'),
          actions: [
            TextButton(
              onPressed: () {
                _navegarParaLeitura(context, codigo);
              },
              child: Text('Validar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Corrigir'),
            ),
          ],
        );
      },
    );
  }

  void _navegarParaLeitura(BuildContext context, String codigo) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return Leitura(
            codigo: codigo,
            leituraAtual: 0.0, // Coloque os valores desejados
            leituraAnterior: 0.0, // Coloque os valores desejados
            valorCalculado: 0.0, // Coloque os valores desejados
            leitura: 0.0, // Coloque os valores desejados
          );
        },
      ),
    );
  }
}
