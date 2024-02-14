import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../lib/g_like.dart';

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
    await tester.setScreenSize(width: 200, height: 100);
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: BotaoLike(),
          ),
        ),
      ),
    );

    await expectLater(
        find.byType(BotaoLike), matchesGoldenFile("goldens/layout_like01.png"));
  });
}
