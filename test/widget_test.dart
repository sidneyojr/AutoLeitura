import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:autoleitura/home.dart';
import 'package:autoleitura/login.dart';

void main() {
  testWidgets('Clique no botão para ir para a tela de login',
      (WidgetTester tester) async {
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
}
