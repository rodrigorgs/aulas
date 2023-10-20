import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_aulas/on_off.dart';

void main() {
  testWidgets('BotaoOnOff deve iniciar como Off', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Scaffold(body: BotaoOnOff())));
    expect(find.text('Off'), findsOneWidget);
    expect(find.text('On'), findsNothing);
  });

  testWidgets('BotaoOnOff deve alternar entre On e Off',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Scaffold(body: BotaoOnOff())));
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();
    expect(find.text('On'), findsOneWidget);
    expect(find.text('Off'), findsNothing);
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();
    expect(find.text('Off'), findsOneWidget);
    expect(find.text('On'), findsNothing);
  });
}
