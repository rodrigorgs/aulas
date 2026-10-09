import 'package:analyzer/file_system/overlay_file_system.dart';
import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:analyzer/src/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/src/dart/analysis/byte_store.dart';
import 'package:analyzer/src/util/performance/operation_performance.dart';
import 'package:collection/collection.dart';
import 'package:linter/src/rules.dart';

void main() async {
  var resourceProvider = OverlayResourceProvider(
    PhysicalResourceProvider.INSTANCE,
  );

  registerLintRules();

  var byteStore = MemoryByteStore();
  for (var i = 0; i < 10; i++) {
    var collection = AnalysisContextCollectionImpl(
      sdkPath: '/Users/scheglov/Applications/dart-sdk',
      resourceProvider: resourceProvider,
      includedPaths: [
        '/Users/scheglov/Source/Dart/sdk.git/sdk/pkg/analyzer',
        // '/Users/scheglov/tmp/2026/2026-03-12/build_benchmark/built_value_forwards_3000',
      ],
      byteStore: byteStore,
      withFineDependencies: true,
    );

    var timer = Stopwatch()..start();

    for (var analysisContext in collection.contexts) {
      var analysisSession = analysisContext.currentSession;
      for (var path in analysisContext.contextRoot.analyzedFiles().sorted()) {
        if (path.endsWith('.dart')) {
          await analysisSession.getUnitElement(path);
        }
      }
    }

    print('[time: ${timer.elapsedMilliseconds} ms]');

    timer.reset();
    for (var analysisContext in collection.contexts) {
      for (var path in analysisContext.contextRoot.analyzedFiles().sorted()) {
        if (path.endsWith('.dart')) {
          // analysisContext.changeFile('/Users/scheglov/tmp/2026/2026-03-12/build_benchmark/built_value_forwards_5000/lib/lib3000.dart');
          analysisContext.changeFile(
            '/Users/scheglov/Source/Dart/sdk.git/sdk/pkg/analyzer/test/src/dart/resolution/await_expression_test.dart',
          );
          await analysisContext.applyPendingFileChanges();
          var analysisSession = analysisContext.currentSession;
          await analysisSession.getUnitElement(path);
        }
      }
    }
    print('[time2: ${timer.elapsedMilliseconds} ms]');

    {
      var buffer = StringBuffer();
      collection.scheduler.accumulatedPerformance.write(buffer: buffer);
      print(buffer);
      collection.scheduler.accumulatedPerformance = OperationPerformanceImpl(
        '<scheduler>',
      );
    }

    await collection.dispose();
  }
}
