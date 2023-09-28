import '../lib/cumprimento.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('cumprimento', () {
    testWidgets('Cumprimento pode ser customizado 1/2',
        (WidgetTester tester) async {
      await tester.pumpWidget(const Cumprimento(nome: 'Fulano'));
      final finder = find.text('Olá, Fulano!');
      expect(finder, findsOneWidget);
    });
    testWidgets('Cumprimento pode ser customizado 2/2',
        (WidgetTester tester) async {
      await tester.pumpWidget(const Cumprimento(nome: 'Sicrana'));
      final finder = find.text('Olá, Sicrana!');
      expect(finder, findsOneWidget);
    });
  });
}
