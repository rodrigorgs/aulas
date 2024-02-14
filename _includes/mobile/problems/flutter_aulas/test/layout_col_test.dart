import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../lib/layout_col.dart';

extension SetScreenSize on WidgetTester {
  Future<void> setScreenSize(
      {double width = 540,
      double height = 960,
      double pixelDensity = 1}) async {
    final size = Size(width, height);
    await this.binding.setSurfaceSize(size);
    this.binding.window.physicalSizeTestValue = size;
    this.binding.window.devicePixelRatioTestValue = pixelDensity;
  }
}

void main() {
  testWidgets('LayoutCol widget has expected children',
      (WidgetTester tester) async {
    await tester.setScreenSize(width: 540, height: 960);
    await tester.pumpWidget(meuApp());

    await expectLater(
        find.byType(Column), matchesGoldenFile("goldens/layout_col01.png"));
  });

  testWidgets('LayoutCol widget has expected children',
      (WidgetTester tester) async {
    await tester.setScreenSize(width: 200, height: 200);
    await tester.pumpWidget(meuApp());

    await expectLater(
        find.byType(Column), matchesGoldenFile("goldens/layout_col02.png"));
  });
}
