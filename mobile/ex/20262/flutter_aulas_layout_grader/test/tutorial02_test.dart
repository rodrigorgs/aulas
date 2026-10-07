import 'package:flutter_aulas/tutorial02.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

void main() {
  group('O app tutorial02', () {
    testWidgets('contém o texto "Oi!"', (WidgetTester tester) async {
      await tester.pumpWidget(criaApp());
      final finder = find.text('Oi!');
      expect(finder, findsOneWidget);
    });

    testWidgets('possui texto centralizado', (WidgetTester tester) async {
      await tester.pumpWidget(criaApp());
      final textFinder = find.text('Oi!');

      final pos = tester.getCenter(textFinder);
      final size = tester.getSize(textFinder);

      expect(pos.dx, 400,
          reason: 'O texto deve estar centralizado horizontalmente');
      expect(pos.dy, 300,
          reason: 'O texto deve estar centralizado verticalmente');
      expect(size.width, closeTo(42, 20),
          reason: 'A largura do texto deve ser aproximadamente 42 pixels');
      expect(size.height, closeTo(14, 10),
          reason: 'A altura do texto ser aproximadamente 14 pixels');
    });

    testWidgets('possui container centralizado', (WidgetTester tester) async {
      await tester.pumpWidget(criaApp());
      final containerFinder = find.byType(Container);

      final pos = tester.getCenter(containerFinder);
      final size = tester.getSize(containerFinder);

      expect(pos.dx, 400,
          reason: 'O container deve estar centralizado horizontalmente');
      expect(pos.dy, 300,
          reason: 'O container deve estar centralizado verticalmente');
      expect(size.width, closeTo(74, 20),
          reason: 'A largura do container deve ser aproximadamente 74 pixels');
      expect(size.height, closeTo(46, 10),
          reason: 'A altura do container ser aproximadamente 46 pixels');
    });

    testWidgets('possui container verde', (WidgetTester tester) async {
      await tester.pumpWidget(criaApp());
      final containerFinder = find.byType(Container);
      final container = tester.widget<Container>(containerFinder);

      expect(container.color, Colors.green,
          reason: 'A cor do container deve ser verde');
    });
  });
}
