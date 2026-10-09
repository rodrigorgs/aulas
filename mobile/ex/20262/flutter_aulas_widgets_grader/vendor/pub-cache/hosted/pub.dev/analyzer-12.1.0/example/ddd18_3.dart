import 'package:analyzer/file_system/overlay_file_system.dart';
import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:analyzer/src/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/src/dart/analysis/byte_store.dart';
import 'package:analyzer/src/dart/analysis/file_content_cache.dart';
import 'package:analyzer/src/util/performance/operation_performance.dart';
import 'package:linter/src/rules.dart';

void main() async {
  registerLintRules();

  var resourceProvider = OverlayResourceProvider(
    PhysicalResourceProvider.INSTANCE,
  );

  for (var i = 0; i < 10000; i++) {
    var collection = AnalysisContextCollectionImpl(
      resourceProvider: resourceProvider,
      sdkPath: '/Users/scheglov/Applications/dart-sdk',
      includedPaths: [
        '/Users/scheglov/Source/Dart/sdk.git/sdk/pkg/analyzer',
        // '/Users/scheglov/Source/Dart/sdk.git/sdk/pkg/analysis_server',
        // '/Users/scheglov/Source/Dart/sdk.git/sdk/pkg/linter',
      ],
      byteStore: MemoryByteStore(),
      fileContentCache: FileContentCache(resourceProvider),
      // performanceLog: PerformanceLog(io.stdout),
      withFineDependencies: true,
    );

    for (var analysisContext in collection.contexts) {
      for (var path in analysisContext.contextRoot.analyzedFiles()) {
        if (path.endsWith('.dart')) {
          analysisContext.driver.addFile(path);
        }
      }
    }

    await collection.scheduler.waitForIdle();
    await pumpEventQueue();
    print('\n' * 2);
    print('[S] Now idle');
    print('-' * 64);

    {
      print('\n' * 2);
      var buffer = StringBuffer();
      collection.scheduler.accumulatedPerformance.write(buffer: buffer);
      print(buffer);
      collection.scheduler.accumulatedPerformance = OperationPerformanceImpl(
        '<scheduler>',
      );
    }

    await collection.dispose();
    await Future.delayed(const Duration(seconds: 1), () => 0);
  }
}

final Stopwatch timer = Stopwatch()..start();

Future pumpEventQueue([int times = 5000]) {
  if (times == 0) return Future.value();
  return Future.delayed(Duration.zero, () => pumpEventQueue(times - 1));
}
