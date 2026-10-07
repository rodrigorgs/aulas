import 'package:flutter_aulas/tutorial05.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

void main() {
  group('O app tutorial03', () {
    testWidgets('contém o texto "Entrar"', (WidgetTester tester) async {
      await tester.pumpWidget(criaApp());
      final container = find.byType(Container).first;
      final icon = find.byIcon(Icons.favorite);
      final text = find.text('Like');

      expect(tester.getCenter(container).dx, closeTo(400, 1));
      expect(tester.getCenter(container).dy, closeTo(300, 1));
      expect(tester.getSize(container).width, closeTo(97.2, 5));
      expect(tester.getSize(container).height, closeTo(61, 5));

      expect(tester.getCenter(icon).dx, closeTo(377.4, 10));
      expect(tester.getCenter(icon).dy, closeTo(300, 10));
      expect(tester.getSize(icon).width, closeTo(20, 5));
      expect(tester.getSize(icon).height, closeTo(20, 5));

      expect(tester.getCenter(text).dx, closeTo(414, 10));
      expect(tester.getCenter(text).dy, closeTo(300, 10));
      expect(tester.getSize(text).width, closeTo(37.2, 5));
      expect(tester.getSize(text).height, closeTo(29, 5));
    });
  });
}
