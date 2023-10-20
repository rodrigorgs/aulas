import 'package:flutter/material.dart';
import 'package:flutter_aulas/monte_seu_hamburguer.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TelaMontagem', () {
    testWidgets('deve exibir os itens', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
          home: Scaffold(
        body: TelaMontagem(itens: [
          Item('Pão', 2.0),
          Item('Alface', 1.0),
          Item('Tomate', 2.0),
        ]),
      )));

      expect(find.text('Pão'), findsOneWidget);
      expect(find.text('Alface'), findsOneWidget);
      expect(find.text('Tomate'), findsOneWidget);
    });

    testWidgets('deve atualizar o total ao selecionar um item',
        (WidgetTester tester) async {
      final itens = [
        Item('Pão', 2.0),
        Item('Alface', 1.0),
        Item('Tomate', 2.0),
      ];
      await tester.pumpWidget(
          MaterialApp(home: Scaffold(body: TelaMontagem(itens: itens))));

      expect(find.text('Total: 0.0 reais'), findsOneWidget);

      await tester.tap(find.byType(Checkbox).first);
      await tester.pump();

      expect(find.text('Total: 2.0 reais'), findsOneWidget);
    });

    testWidgets('deve atualizar o total ao desmarcar um item',
        (WidgetTester tester) async {
      final itens = [
        Item('Pão', 2.0),
        Item('Alface', 1.0),
        Item('Tomate', 2.0),
      ];
      await tester.pumpWidget(
          MaterialApp(home: Scaffold(body: TelaMontagem(itens: itens))));

      expect(find.text('Total: 0.0 reais'), findsOneWidget);

      await tester.tap(find.byType(Checkbox).first);
      await tester.pump();

      expect(find.text('Total: 2.0 reais'), findsOneWidget);

      await tester.tap(find.byType(Checkbox).first);
      await tester.pump();

      expect(find.text('Total: 0.0 reais'), findsOneWidget);
    });

    testWidgets('deve exibir o total correto ao selecionar vários itens',
        (WidgetTester tester) async {
      final itens = [
        Item('Pão', 2.0),
        Item('Alface', 1.0),
        Item('Tomate', 2.0),
      ];
      await tester.pumpWidget(
          MaterialApp(home: Scaffold(body: TelaMontagem(itens: itens))));

      expect(find.text('Total: 0.0 reais'), findsOneWidget);

      await tester.tap(find.byType(Checkbox).first);
      await tester.pump();

      expect(find.text('Total: 2.0 reais'), findsOneWidget);

      await tester.tap(find.byType(Checkbox).at(1));
      await tester.pump();

      expect(find.text('Total: 3.0 reais'), findsOneWidget);

      await tester.tap(find.byType(Checkbox).at(2));
      await tester.pump();

      expect(find.text('Total: 5.0 reais'), findsOneWidget);
    });
  });
}
