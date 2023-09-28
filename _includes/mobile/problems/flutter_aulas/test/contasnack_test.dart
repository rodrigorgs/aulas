import 'package:flutter/material.dart';
import '../lib/contasnack.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('cumprimento', () {
    pumpContador(WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: Builder(builder: (BuildContext context) {
            return Contador();
          }),
        ),
      ));
    }

    testWidgets('Todos os botões estão presentes', (WidgetTester tester) async {
      await pumpContador(tester);
      expect(find.text('+1'), findsOneWidget);
      expect(find.text('+5'), findsOneWidget);
      expect(find.text('+25'), findsOneWidget);
    });
    testWidgets('+1 mostra snackbar', (WidgetTester tester) async {
      await pumpContador(tester);
      final finder = find.text('+1');
      expect(finder, findsOneWidget);
      await tester.tap(finder);
      await tester.pumpAndSettle();
      expect(find.text('Contador: 1'), findsOneWidget);
    });
    testWidgets('Contador faz soma correta 1/2', (WidgetTester tester) async {
      await pumpContador(tester);
      await tester.tap(find.text('+1'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('+5'));
      await tester.pumpAndSettle();
      expect(find.text('Contador: 6'), findsOneWidget);
    });
    testWidgets('Contador faz soma correta 2/2', (WidgetTester tester) async {
      await pumpContador(tester);
      await tester.tap(find.text('+1'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('+1'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('+5'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('+25'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('+25'));
      await tester.pumpAndSettle();

      expect(find.text('Contador: 57'), findsOneWidget);
    });
  });
}
