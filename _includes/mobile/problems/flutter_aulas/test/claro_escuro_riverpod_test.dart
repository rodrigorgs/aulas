// BEGIN: 6d7f5f8c8f2d
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_aulas/claro_escuro_riverpod.dart';

void verificaModo({required bool modoEscuro, required WidgetTester tester}) {
  expect(tester.widget<Container>(find.byType(Container)).color,
      equals(modoEscuro ? Colors.black : Colors.white));

  final textWidgets = tester.widgetList<Text>(find.byType(Text));
  for (final textWidget in textWidgets) {
    expect(textWidget.style?.color,
        equals(modoEscuro ? Colors.white : Colors.black));
  }

  expect(find.text('Modo Claro'), modoEscuro ? findsNothing : findsOneWidget);
  expect(find.text('Modo Escuro'), modoEscuro ? findsOneWidget : findsNothing);
}

void main() {
  testWidgets('Possui um texto e um botão', (WidgetTester tester) async {
    await tester.pumpWidget(ProviderScope(
      child: MaterialApp(
        home: Scaffold(body: Inicio()),
      ),
    ));

    expect(find.text('Modo Claro'), findsOneWidget);
    expect(find.byType(OutlinedButton), findsOneWidget);
  });

  testWidgets('Verifica cor do MeuTexto quando está no modo escuro',
      (tester) async {
    await tester.pumpWidget(ProviderScope(
      overrides: [modoEscuroProvider.overrideWith((ref) => true)],
      child: MaterialApp(
        home: Scaffold(body: MeuTexto('Teste')),
      ),
    ));

    expect(tester.widget<Text>(find.byType(Text)).style?.color,
        equals(Colors.white));
  });
  testWidgets('Verifica cor do MeuTexto quando está no modo claro',
      (tester) async {
    await tester.pumpWidget(ProviderScope(
      overrides: [modoEscuroProvider.overrideWith((ref) => false)],
      child: MaterialApp(
        home: Scaffold(body: MeuTexto('Teste')),
      ),
    ));

    expect(tester.widget<Text>(find.byType(Text)).style?.color,
        equals(Colors.black));
  });
  testWidgets('Verifica cor do BotaoTrocarModo quando está no modo escuro',
      (tester) async {
    await tester.pumpWidget(ProviderScope(
      overrides: [modoEscuroProvider.overrideWith((ref) => true)],
      child: MaterialApp(
        home: Scaffold(body: BotaoTrocarModo()),
      ),
    ));

    expect(tester.widget<Text>(find.byType(Text)).style?.color,
        equals(Colors.white));
  });
  testWidgets('Verifica cor do BotaoTrocarModo quando está no modo claro',
      (tester) async {
    await tester.pumpWidget(ProviderScope(
      overrides: [modoEscuroProvider.overrideWith((ref) => false)],
      child: MaterialApp(
        home: Scaffold(body: BotaoTrocarModo()),
      ),
    ));

    expect(tester.widget<Text>(find.byType(Text)).style?.color,
        equals(Colors.black));
  });

  testWidgets('Verifica modo claro', (WidgetTester tester) async {
    await tester.pumpWidget(ProviderScope(
      child: MaterialApp(
        home: Scaffold(body: Inicio()),
      ),
    ));

    verificaModo(modoEscuro: false, tester: tester);
  });

  testWidgets('Verifica modo escuro', (WidgetTester tester) async {
    await tester.pumpWidget(ProviderScope(
      overrides: [modoEscuroProvider.overrideWith((ref) => true)],
      child: MaterialApp(
        home: Scaffold(body: Inicio()),
      ),
    ));

    verificaModo(modoEscuro: true, tester: tester);
  });

  testWidgets('Verifica troca de modo', (WidgetTester tester) async {
    await tester.pumpWidget(ProviderScope(
      child: MaterialApp(
        home: Scaffold(body: Inicio()),
      ),
    ));

    verificaModo(modoEscuro: false, tester: tester);
    await tester.tap(find.byType(OutlinedButton));
    await tester.pump();
    verificaModo(modoEscuro: true, tester: tester);
    await tester.tap(find.byType(OutlinedButton));
    await tester.pump();
    verificaModo(modoEscuro: false, tester: tester);
  });
}
// END: 6d7f5f8c8f2d