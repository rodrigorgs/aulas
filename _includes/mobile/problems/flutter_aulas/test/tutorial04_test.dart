import 'package:flutter_aulas/tutorial04.dart';
import 'package:flutter_test/flutter_test.dart';
// import 'package:flutter/material.dart';

void main() {
  group('O app tutorial03', () {
    testWidgets('contém o texto "Entrar"', (WidgetTester tester) async {
      await tester.pumpWidget(criaApp());
      final finder = find.text('Entrar');
      expect(finder, findsOneWidget);
    });

    testWidgets('contém o texto "Cadastrar-se"', (WidgetTester tester) async {
      await tester.pumpWidget(criaApp());
      final finder = find.text('Cadastrar-se');
      expect(finder, findsOneWidget);
    });

    testWidgets('contém widgets centralizados verticalmente"',
        (WidgetTester tester) async {
      await tester.pumpWidget(criaApp());
      final pos1 = tester.getCenter(find.text('Entrar'));
      expect(pos1.dy, closeTo(300.0, 1));
      final pos2 = tester.getCenter(find.text('Cadastrar-se'));
      expect(pos2.dy, closeTo(300.0, 1));
    });

    testWidgets('possui posição e dimensionamento corretos para "Entrar"',
        (WidgetTester tester) async {
      await tester.pumpWidget(criaApp());
      final finder = find.text('Entrar');
      final pos = tester.getCenter(finder);
      final size = tester.getSize(finder);
      // print('Pos ${pos.dx}');
      // print('Size ${tester.getSize(finder).width}');

      expect(pos.dx, closeTo(240.3, 10));
      expect(size.width, closeTo(38.57, 8));
    });

    testWidgets('possui posição e dimensionamento corretos para "Cadastrar-se"',
        (WidgetTester tester) async {
      await tester.pumpWidget(criaApp());
      final finder = find.text('Cadastrar-se');
      final pos = tester.getCenter(finder);
      final size = tester.getSize(finder);
      // print('Pos ${pos.dx}');
      // print('Size ${tester.getSize(finder).width}');

      expect(pos.dx, closeTo(537.8, 10));
      expect(size.width, closeTo(82.3, 8));
    });

    // testWidgets('possui cabeçalho no topo"', (WidgetTester tester) async {
    //   await tester.pumpWidget(criaApp());
    //   final finder = find.text('Entrar');
    //   final pos = tester.getCenter(finder);
    //   expect(pos.dy, closeTo(10.0, 10));
    // });

    // testWidgets('possui Cadastrar-se embaixo"', (WidgetTester tester) async {
    //   await tester.pumpWidget(criaApp());
    //   final finder = find.text('Cadastrar-se');
    //   final pos = tester.getCenter(finder);
    //   expect(pos.dy, closeTo(590.0, 10));
    // });
  });
}
