import 'package:flutter_aulas/tutorial03.dart';
import 'package:flutter_test/flutter_test.dart';
// import 'package:flutter/material.dart';

void main() {
  group('O app tutorial03', () {
    testWidgets('contém o texto "Cabeçalho da tela"',
        (WidgetTester tester) async {
      await tester.pumpWidget(criaApp());
      final finder = find.text('Cabeçalho da tela');
      expect(finder, findsOneWidget);
    });

    testWidgets('contém o texto "Rodapé"', (WidgetTester tester) async {
      await tester.pumpWidget(criaApp());
      final finder = find.text('Rodapé');
      expect(finder, findsOneWidget);
    });

    testWidgets('possui cabeçalho centralizado horizontalmente"',
        (WidgetTester tester) async {
      await tester.pumpWidget(criaApp());
      final finder = find.text('Cabeçalho da tela');
      final pos = tester.getCenter(finder);
      expect(pos.dx, closeTo(400.0, 1));
    });

    testWidgets('possui rodapé centralizado horizontalmente"',
        (WidgetTester tester) async {
      await tester.pumpWidget(criaApp());
      final finder = find.text('Rodapé');
      final pos = tester.getCenter(finder);
      expect(pos.dx, closeTo(400.0, 1));
    });

    testWidgets('possui cabeçalho no topo"', (WidgetTester tester) async {
      await tester.pumpWidget(criaApp());
      final finder = find.text('Cabeçalho da tela');
      final pos = tester.getCenter(finder);
      expect(pos.dy, closeTo(10.0, 10));
    });

    testWidgets('possui rodapé embaixo"', (WidgetTester tester) async {
      await tester.pumpWidget(criaApp());
      final finder = find.text('Rodapé');
      final pos = tester.getCenter(finder);
      expect(pos.dy, closeTo(590.0, 10));
    });
  });
}
