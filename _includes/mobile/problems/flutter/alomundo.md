## Alo mundo

<textarea class="code lang-flutter">
import 'package:flutter/material.dart';

void main() {
  runApp(criaApp());
}

Text criaApp() {
  return const Text(
    'Aprendendo Flutter!',
    textDirection: TextDirection.ltr,
  );
}
</textarea>

<div class="testcode">
import 'package:flutter_aulas/alomundo.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('alomundo', () {
    testWidgets('Contém texto "Aprendendo Flutter!"',
        (WidgetTester tester) async {
      await tester.pumpWidget(criaApp());
      final finder = find.text('Aprendendo Flutter!');
      expect(finder, findsOneWidget);
    });
  });
}
</div>