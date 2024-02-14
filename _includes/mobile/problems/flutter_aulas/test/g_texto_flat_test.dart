// Generated with gen_gtests.py. Do not edit!
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../lib/g_texto_flat.dart';

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
  testWidgets('Test 400x200',
      (WidgetTester tester) async {
    await tester.setScreenSize(width: 400, height: 200);
    final root = buildApp();
    await tester.pumpWidget(root);

    await expectLater(
        find.byWidget(root), matchesGoldenFile("goldens/g_texto_flat01.png"));
  });

  testWidgets('Test 300x500',
      (WidgetTester tester) async {
    await tester.setScreenSize(width: 300, height: 500);
    final root = buildApp();
    await tester.pumpWidget(root);

    await expectLater(
        find.byWidget(root), matchesGoldenFile("goldens/g_texto_flat02.png"));
  });
}
