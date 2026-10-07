import 'package:flutter_aulas/tutorial01.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('tutorial01', () {
    testWidgets('Contém texto "Oi!"', (WidgetTester tester) async {
      await tester.pumpWidget(criaApp());
      final finder = find.text('Oi!');
      expect(finder, findsOneWidget);
    });

    testWidgets('O texto está centralizado', (WidgetTester tester) async {
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
  });
}
