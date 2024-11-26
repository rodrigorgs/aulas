import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_aulas/listview02.dart';

void main() {
  testWidgets('ListView displays all items', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp(
      fetchItens: () {
        return Future.value(['aaaaa', 'bbbbb']);
      },
    ));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text('aaaaa'), findsNothing);
    expect(find.text('Item 1'), findsNothing);

    await Duration(seconds: 1, milliseconds: 500);
    await tester.pumpAndSettle();

    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.text('aaaaa'), findsOneWidget);
    expect(find.text('Item 1'), findsNothing);
  });
}
