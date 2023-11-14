import 'package:autoleitura2/conta.dart';
import 'package:autoleitura2/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:autoleitura2/login.dart';
import 'package:autoleitura2/leitura.dart';
import 'dart:async';

void main() {
  testWidgets('Teste Home', (WidgetTester tester) async {
    // Construir nossa tela Home e acionar um frame.
    await tester.pumpWidget(MaterialApp(home: Home()));

    // Aguardar a árvore de widgets se estabilizar.
    await tester.pumpAndSettle();

    // Verificar se o texto de boas-vindas está presente.
    expect(
        find.text('Seja Bem-Vindo ao sistema de Auto Leitura'), findsOneWidget);

    // Localizar o botão pelo texto.
    final buttonFinder = find.text('Clique para inserir seu código');
    expect(buttonFinder, findsOneWidget);

    // Tocar no botão.
    await tester.tap(buttonFinder);

    // Aguardar a árvore de widgets se estabilizar.
    await tester.pumpAndSettle();

    // Verificar se a tela de login está presente.
    expect(find.byType(Login), findsOneWidget);
  });

  testWidgets('Teste de Login', (WidgetTester tester) async {
    // Construir nossa tela Login e acionar um frame.
    await tester.pumpWidget(MaterialApp(home: Login()));

    // Aguardar a árvore de widgets se estabilizar.
    await tester.pumpAndSettle();

    // Verificar se o texto de boas-vindas está presente.
    expect(find.text('Coloque seu código aqui'), findsOneWidget);

    // Preencher o campo de código com '1234'.
    await tester.enterText(find.byType(TextFormField), '1234');

    // Verificar se o botão está presente.
    expect(find.text('Enviar para Validação'), findsOneWidget);

    // Tocar no botão.
    await tester.tap(find.text('Enviar para Validação'));

    // Aguardar a árvore de widgets se estabilizar.
    await tester.pumpAndSettle();

    // Verificar se o diálogo está presente.
    expect(find.text('Confira seu código'), findsOneWidget);

    // Tocar no botão 'Validar' no diálogo.
    await tester.tap(find.text('Validar'));

    // Aguardar a árvore de widgets se estabilizar.
    await tester.pumpAndSettle();

    // Verificar se a tela de leitura está presente.
    expect(find.byType(Leitura), findsOneWidget);
  });

  testWidgets('Teste de Leitura', (WidgetTester tester) async {
    // Obtém o nome do mês atual
    final nomeMesAtual = _obterNomeMes(DateTime.now().month);

    // Construir nossa tela Leitura e acionar um frame.
    await tester.pumpWidget(
      MaterialApp(
        home: Leitura(
          codigo: '1234',
          leituraAtual: 100.0,
          leituraAnterior: 10.0,
          valorCalculado: 90.0,
          leitura: 0,
        ),
      ),
    );

    // Aguardar a árvore de widgets se estabilizar.
    await tester.pumpAndSettle();

    // Verificar se o texto de boas-vindas está presente.
    expect(
      find.text('Coloque aqui a leitura do mês de $nomeMesAtual'),
      findsOneWidget,
    );

    // Preencher o campo de leitura.
    await tester.enterText(find.byType(TextField), '100');

    // Verificar se o botão está presente.
    expect(find.text('Enviar Leitura'), findsOneWidget);

    // Tocar no botão "Enviar Leitura".
    await tester.tap(find.text('Enviar Leitura'));

    // Aguardar a árvore de widgets se estabilizar.
    await tester.pumpAndSettle();

    // Verificar se o diálogo está presente.
    expect(find.text('Confirmação de Leitura'), findsOneWidget);

    // Tocar no botão "Sim" no diálogo.
    await tester.tap(find.text('Sim'));

    // Aguardar a árvore de widgets se estabilizar.
    await tester.pumpAndSettle();

    // Não devemos encontrar a tela de Conta diretamente aqui, pois há uma transição para a tela de Conta.
    // Podemos verificar se a tela de Conta foi chamada após a tela de Leitura.
    // Uma maneira de fazer isso seria verificar se a rota corrente é a tela de Conta.
    expect(find.byType(Conta), findsOneWidget);
    expect(find.byType(Leitura), findsNothing);
  });

  testWidgets('Teste de Conta', (WidgetTester tester) async {
    // Construir nossa tela Conta e acionar um frame.
    await tester
        .pumpWidget(MaterialApp(home: Conta(codigo: '1234', leitura: 150.0)));

    // Aguardar a árvore de widgets se estabilizar.
    await tester.pumpAndSettle();

    // Verificar se o texto está presente.
    expect(find.text('Calculando conta'), findsOneWidget);

    // Encontrar a instância do AnimatedBuilder.
    final animatedBuilder =
        tester.widgetList(find.byType(AnimatedBuilder)).first;

    // Acessar o listenable dentro do AnimatedBuilder.
    final listenable = (animatedBuilder as AnimatedBuilder).listenable;

    // Verificar se o listenable é do tipo ValueNotifier<bool>.
    if (listenable is ValueNotifier<bool>) {
      // Criar um Completer para aguardar a conclusão da animação.
      final completer = Completer<void>();

      // Adicionar um ouvinte ao ValueNotifier para completar o Completer quando a animação terminar.
      listenable.addListener(() {
        if (listenable.value == true) {
          completer.complete();
        }
      });

      // Aguardar até que a animação esteja concluída.
      await completer.future;
    } else {
      // Se o listenable não for do tipo esperado, você pode tratar isso de acordo com sua lógica.
      // Por exemplo, lançar uma exceção ou imprimir uma mensagem de erro.
      print('Erro: O listenable não é do tipo ValueNotifier<bool>.');
    }

    // Verificar se o botão "Exibir Detalhes" está presente.
    expect(find.text('Exibir Detalhes'), findsOneWidget);

    // Tocar no botão "Exibir Detalhes".
    await tester.tap(find.text('Exibir Detalhes'));

    // Aguardar a árvore de widgets se estabilizar.
    await tester.pumpAndSettle();

    // Verificar se o diálogo de detalhes está presente.
    expect(find.text('Detalhes da Conta'), findsOneWidget);

    // Tocar no botão "Cancelar" no diálogo de detalhes.
    await tester.tap(find.text('Cancelar'));

    // Aguardar a árvore de widgets se estabilizar.
    await tester.pumpAndSettle();

    // Verificar se o diálogo foi fechado.
    expect(find.text('Detalhes da Conta'), findsNothing);
  });
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
