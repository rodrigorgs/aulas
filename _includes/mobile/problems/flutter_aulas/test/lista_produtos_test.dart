import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../lib/lista_produtos.dart';

void main() {
  group('ListaCompras', () {
    testWidgets('Deve exibir a lista de produtos', (WidgetTester tester) async {
      final produtos = [
        Produto("Arroz", 10.0),
        Produto("Feijão", 5.0),
        Produto("Macarrão", 3.0),
        Produto("Carne", 20.0),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ListaCompras(produtos: produtos),
          ),
        ),
      );

      expect(find.text('Arroz'), findsOneWidget);
      expect(find.text('Feijão'), findsOneWidget);
      expect(find.text('Macarrão'), findsOneWidget);
      expect(find.text('Carne'), findsOneWidget);
    });

    testWidgets('Deve exibir o preço de cada produto',
        (WidgetTester tester) async {
      final produtos = [
        Produto("Arroz", 10.0),
        Produto("Feijão", 5.0),
        Produto("Macarrão", 3.0),
        Produto("Carne", 20.0),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ListaCompras(produtos: produtos),
          ),
        ),
      );

      print('${produtos[0].preco} reais');
      expect(find.text('10.0 reais'), findsOneWidget);
      expect(find.text('5.0 reais'), findsOneWidget);
      expect(find.text('3.0 reais'), findsOneWidget);
      expect(find.text('20.0 reais'), findsOneWidget);
    });
  });
}
