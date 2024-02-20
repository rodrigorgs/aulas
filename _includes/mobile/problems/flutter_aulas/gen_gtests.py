import os

directory = "lib"
prefix = "g_"

# Sample input: see file g_alo_flutter.dart

def generate_draft_file(filename):
    with open(f"lib/{filename}.dart", "r") as f:
        lines = f.readlines()
        draft_app_lines = []
        inside_draft_app = False
        for line in lines:
            if "draftApp() {" in line:
                inside_draft_app = True
            elif line.strip() == "}":
                inside_draft_app = False
            elif inside_draft_app:
                draft_app_lines.append(line)
    with open(f"draft/{filename}__draft.dart", "w") as f:
        f.write('''\
import 'package:flutter/material.dart';

void main() {
  runApp(buildApp());
}

Widget buildApp() {
''')
        f.write("".join(draft_app_lines))
        f.write("}")

def generate_test_file(filename):
    with open(f"test/{filename}_test.dart", "w") as f:
        f.write('''\
// Generated with gen_gtests.py. Do not edit!
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../lib/''' + filename + '''.dart';

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
        find.byWidget(root), matchesGoldenFile("goldens/''' +  filename + '''01.png"));
  });

  testWidgets('Test 300x500',
      (WidgetTester tester) async {
    await tester.setScreenSize(width: 300, height: 500);
    final root = buildApp();
    await tester.pumpWidget(root);

    await expectLater(
        find.byWidget(root), matchesGoldenFile("goldens/''' +  filename + '''02.png"));
  });
}
''')

def generate_goldens(filename):
    os.system(f"flutter test --update-goldens test/{filename}_test.dart")

if __name__ == "__main__":
    files = [file.replace('.dart', '') for file in os.listdir(directory) if file.startswith(prefix) and not '__draft' in file]

    for filename in files:
        print(filename)
        generate_test_file(filename)
        generate_draft_file(filename)
        generate_goldens(filename)
