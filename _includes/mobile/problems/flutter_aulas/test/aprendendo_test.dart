import '../lib/aprendendo.dart';
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
