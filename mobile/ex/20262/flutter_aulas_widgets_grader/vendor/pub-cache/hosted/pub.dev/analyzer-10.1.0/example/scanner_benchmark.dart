import 'dart:typed_data';

import 'package:_fe_analyzer_shared/src/scanner/scanner.dart' as fasta;

import 'file:/Users/scheglov/Source/Dart/sdk.git/sdk/pkg/analysis_server/tool/code_completion/benchmark/sliding_statistics.dart';

void main() {
  var contents0 = r'''
void main() {
  print(12345);
}
''';

  var contents = contents0 * 3125 * 10;

  // var contentBytes = Uint8List.fromList(contents.codeUnits);
  var contentBytes = Uint8List(contents.length + 1);
  contentBytes.setRange(0, contents.length, contents.codeUnits);

  var statistics = SlidingStatistics(100);

  while (true) {
    print('[length0: ${contents0.length}]');
    print('[length: ${contents.length}]');
    var timer = Stopwatch()..start();
    _doScan(contents, contentBytes);
    timer.stop();

    var responseTime = timer.elapsedMicroseconds;
    statistics.add(responseTime);
    if (statistics.isReady) {
      print(
        '[${DateTime.now().millisecondsSinceEpoch}]'
        '[time: $responseTime mcs][mean: ${statistics.mean.toStringAsFixed(1)}]'
        '[stdDev: ${statistics.standardDeviation.toStringAsFixed(3)}]'
        '[min: ${statistics.min.toStringAsFixed(1)}]'
        '[max: ${statistics.max.toStringAsFixed(1)}]',
      );
    } else {
      print('[time: $responseTime mcs]');
    }
  }
}

void _doScan(String contents, Uint8List contentBytes) {
  fasta.scan(
    contentBytes,
    configuration: fasta.ScannerConfiguration(
      enableTripleShift: true,
      forAugmentationLibrary: true,
    ),
    includeComments: true,
    languageVersionChanged: (scanner, languageVersion) {},
  );

  // fasta.ScannerResult result = fasta.scanString(
  //   contents,
  //   configuration: fasta.ScannerConfiguration(
  //     enableExtensionMethods: true,
  //     enableTripleShift: true,
  //     enableNonNullable: true,
  //     forAugmentationLibrary: true,
  //   ),
  //   includeComments: true,
  //   languageVersionChanged: (scanner, languageVersion) {},
  // );

  // var errorListener = RecordingErrorListener();
  // var scanner = Scanner.fasta(
  //   _Source(),
  //   errorListener,
  //   contents: contents,
  // );
  // var featureSet = FeatureSet.latestLanguageVersion();
  // scanner.configureFeatures(
  //   featureSetForOverriding: featureSet,
  //   featureSet: featureSet,
  // );
  // var first = scanner.tokenize();

  // for (Token? token = first; token != null; token = token.next) {
  //   print('[offset: ${token.offset}][kind: ${token.kind}][${token.lexeme}]');
  //   if (token.isEof) {
  //     break;
  //   }
  // }
}

// void _doScan(String contents) {
//   var errorListener = RecordingErrorListener();
//
//   var scanner = Scanner.fasta(
//     _Source(),
//     errorListener,
//     contents: contents,
//   );
//   var featureSet = FeatureSet.latestLanguageVersion();
//   scanner.configureFeatures(
//     featureSetForOverriding: featureSet,
//     featureSet: featureSet,
//   );
//
//   var first = scanner.tokenize();
//
//   // for (Token? token = first; token != null; token = token.next) {
//   //   print('[offset: ${token.offset}][kind: ${token.kind}][${token.lexeme}]');
//   //   if (token.isEof) {
//   //     break;
//   //   }
//   // }
// }

// class _Source implements Source {
//   @override
//   dynamic noSuchMethod(Invocation invocation) {
//     return super.noSuchMethod(invocation);
//   }
// }
