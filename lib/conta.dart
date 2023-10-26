import 'package:flutter/material.dart';
import 'package:autoleitura/exibirdetalhes.dart';

class Conta extends StatefulWidget {
  final String codigo;
  final double leitura;

  const Conta({required this.codigo, required this.leitura});

  @override
  _ContaState createState() => _ContaState();
}

class _ContaState extends State<Conta> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  double leituraAnterior = 0.0;
  late double valorCalculado;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 10),
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _controller.repeat();
    // Simular o cálculo da conta, você pode substituir por lógica real aqui
    _calcularConta();
  }

  void _calcularConta() async {
    // Simulação de um processo demorado
    await Future.delayed(
        Duration(seconds: 5)); // Simulação de cálculo de 5 segundos
    // Quando o cálculo estiver concluído, interrompe a animação
    _controller.stop();

    // Realize o cálculo do valor considerando a leitura anterior
    valorCalculado = (widget.leitura - leituraAnterior) *
        1.15; // Multiplicado pelo valor do metro cúbico
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AUTOLEITURA - CONTA'),
        backgroundColor: Color.fromARGB(255, 0, 5, 8),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Calculando conta',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(10, (index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4.0),
                        child: Container(
                          width: 3,
                          height: 3,
                          color: Colors.blue,
                        ),
                      );
                    }),
                  );
                },
              ),
              SizedBox(height: 20),
              Text(
                'Código: ${widget.codigo}',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              Text(
                'Leitura Recebida: ${widget.leitura.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _exibirDetalhes(context);
                },
                child: Text('Exibir Detalhes'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _exibirDetalhes(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Detalhes da Conta'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Leitura Atual: ${widget.leitura.toStringAsFixed(2)}'),
              Text('Leitura Anterior: ${leituraAnterior.toStringAsFixed(2)}'),
              Text('Valor do Metro Cúbico: R\$ 1.15'),
              Text('Valor Calculado: R\$ ${valorCalculado.toStringAsFixed(2)}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Fecha o diálogo
              },
              child: Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                _aceitarConta(context);
              },
              child: Text('Aceitar Conta'),
            ),
          ],
        );
      },
    );
  }

  void _aceitarConta(BuildContext context) {
    // Lógica para aceitar a conta
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ExibirDetalhes(
          usuario: Usuario(codigo: widget.codigo, nome: 'João Carlos'),
          leitura: Leitura(
              leituraAtual: widget.leitura,
              leituraAnterior: leituraAnterior,
              valorCalculado: valorCalculado),
          mesAtual: 'Outubro', // Substitua pelo mês atual
        ),
      ),
    );
  }
}
