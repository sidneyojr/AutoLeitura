// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:autoleitura/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:autoleitura/main.dart';
//import 'package:autoleitura/login.dart';

void main() {
  testWidgets('Auto Leitura', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify that our counter starts at 0.
    expect(
        find.text('Seja Bem-Vindo ao sistema de Auto Leitura'), findsOneWidget);

    // Tap the "Clique aqui para inserir seu código" button.
    // Find the button by its key or text.
    final buttonFinder = find.widgetWithText(
        ElevatedButton, 'Clique aqui para inserir seu código');
    expect(buttonFinder, findsOneWidget);

    // Tap the button to trigger the action.
    await tester.tap(buttonFinder);

    // Wait for the widget tree to settle.
    await tester.pumpAndSettle();

    // Verify that we are on the login screen.
    expect(find.byType(Login), findsOneWidget);
    // Tap the '+' icon and trigger a frame.
    //await tester.tap(find.byIcon(Icons.add));
    //await tester.pump();

    // Verify that our counter has incremented.
    //expect(find.text('0'), findsNothing);
    //expect(find.text('1'), findsOneWidget);
  });
}
