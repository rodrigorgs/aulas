import 'package:analyzer/file_system/overlay_file_system.dart';
import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:analyzer/src/dart/analysis/analysis_context_collection.dart';

import 'file:/Users/scheglov/Source/Dart/sdk.git/sdk/pkg/analysis_server/tool/code_completion/benchmark/sliding_statistics.dart';

Future<void> main() async {
  var statistics = SlidingStatistics(100);

  while (true) {
    var resourceProvider = OverlayResourceProvider(
      PhysicalResourceProvider.INSTANCE,
    );

    var collection = AnalysisContextCollectionImpl(
      resourceProvider: resourceProvider,
      includedPaths: [
        // '/Users/scheglov/Source/Dart/sdk.git/sdk/pkg/analysis_server/lib',
        // '/Users/scheglov/Source/Dart/sdk.git/sdk/pkg/_fe_analyzer_shared/lib/src/parser',
        '/Users/scheglov/Source/Dart/sdk.git/sdk/pkg/_fe_analyzer_shared/lib/src/exhaustiveness',
      ],
      withFineDependencies: true,
    );

    var timer = Stopwatch()..start();
    for (var analysisContext in collection.contexts) {
      // print(analysisContext.contextRoot.root.path);
      var analysisSession = analysisContext.currentSession;
      for (var path in analysisContext.contextRoot.analyzedFiles()) {
        if (path.endsWith('.dart')) {
          // print('  $path');
          await analysisSession.getResolvedUnit(path);
        }
      }
    }

    var responseTime = timer.elapsedMilliseconds;
    statistics.add(responseTime);
    if (statistics.isReady) {
      print(
        '[${DateTime.now().millisecondsSinceEpoch}]'
        '[time: $responseTime ms][mean: ${statistics.mean.toStringAsFixed(1)}]'
        '[stdDev: ${statistics.standardDeviation.toStringAsFixed(3)}]'
        '[min: ${statistics.min.toStringAsFixed(1)}]'
        '[max: ${statistics.max.toStringAsFixed(1)}]',
      );
    } else {
      print('[time: $responseTime ms]');
    }
  }
}
