import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_aulas/listview01.dart';

void main() {
  testWidgets('MyApp mostra lista correta', (WidgetTester tester) async {
    exemploItens.removeWhere((x) => true);
    exemploItens.addAll(['qwerty', 'asdf']);

    await tester.pumpWidget(MyApp());

    expect(find.text('qwerty'), findsOneWidget);
    expect(find.text('asdf'), findsOneWidget);
    expect(find.text('Item 1'), findsNothing);
  });

  testWidgets('ItemListView mostra lista correta', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: ItemListView(itens: ['abc', 'def']),
      ),
    ));

    expect(find.text('abc'), findsOneWidget);
    expect(find.text('def'), findsOneWidget);
    expect(find.text('Item 1'), findsNothing);
  });
}
