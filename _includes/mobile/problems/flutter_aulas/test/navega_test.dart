import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../lib/navega.dart';

void main() {
  testWidgets('Tela de início possui os widgets esperados',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: Inicio()));

    // Verify the initial state of the Inicio widget
    expect(find.text('Início'), findsOneWidget);
    expect(find.text('Azul'), findsOneWidget);
    expect(find.text('Vermelho'), findsOneWidget);
  });
  testWidgets('Toca no botão Azul', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: Inicio()));

    // Tap on the "Azul" button and verify the navigation to Detalhe widget
    await tester.tap(find.text('Azul'));
    await tester.pumpAndSettle();
    expect(find.text('Detalhe'), findsOneWidget);
    expect(find.text('Azul'), findsOneWidget);
    expect(find.text('Vermelho'), findsNothing);
  });
  testWidgets('Toca no botão Vermelho', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: Inicio()));

    // Tap on the "Vermelho" button and verify the navigation to Detalhe widget
    await tester.tap(find.text('Vermelho'));
    await tester.pumpAndSettle();
    expect(find.text('Detalhe'), findsOneWidget);
    expect(find.text('Vermelho'), findsOneWidget);
    expect(find.text('Azul'), findsNothing);
  });

  testWidgets('Verifica botão de voltar', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: Inicio()));
    await tester.tap(find.text('Vermelho'));

    final NavigatorState navigator = tester.state(find.byType(Navigator));
    navigator.pop();
    await tester.pumpAndSettle();

    // Verify that we navigated back to the Inicio widget
    expect(find.text('Início'), findsOneWidget);
    expect(find.text('Azul'), findsOneWidget);
    expect(find.text('Vermelho'), findsOneWidget);
  });
}
