import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/file_system/overlay_file_system.dart';
import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:analyzer/src/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/src/dart/analysis/byte_store.dart';
import 'package:analyzer/src/util/performance/operation_performance.dart';

void main() async {
  while (true) {
    var byteStore = MemoryByteStore();

    var resourceProvider = OverlayResourceProvider(
      PhysicalResourceProvider.INSTANCE,
    );

    var collection = AnalysisContextCollectionImpl(
      resourceProvider: resourceProvider,
      includedPaths: [
        // '/Users/scheglov/Source/Dart/sdk.git/sdk/pkg/analyzer',
        // '/Users/scheglov/Source/flutter/packages/flutter_tools',
        // '/Users/scheglov/dart/20231112/augment_example',
        // '/Users/scheglov/dart/test/bin/test.dart',
        // '/Users/scheglov/Source/Dart/sdk.git/sdk/tests/language/macros/large_library_cycle',
        // '/Users/scheglov/Source/Dart/sdk.git/sdk/tests/co19/src/LanguageFeatures/Augmentation-libraries/applying_augmentation_library_A03_t02.dart',
        '/Users/scheglov/tmp/2024-04-28/built_value.dart/benchmark_large_library_cycle/macro/lib/value0.dart',
      ],
      byteStore: byteStore,
      withFineDependencies: true,
    );

    {
      var timer = Stopwatch()..start();
      for (var analysisContext in collection.contexts) {
        print(analysisContext.contextRoot.root.path);
        var analysisSession = analysisContext.currentSession;
        for (var path in analysisContext.contextRoot.analyzedFiles()) {
          if (path.endsWith('.dart')) {
            // print('  $path');
            var libResult = await analysisSession.getResolvedLibrary(path);
            if (libResult is ResolvedLibraryResult) {
              // for (final unitResult in libResult.units) {
              //   // print('    ${unitResult.path}');
              //   // print('      errors: ${unitResult.errors}');
              //   // print('---');
              //   // print(unitResult.content);
              //   // print('---');
              // }
            }
          }
        }
      }
      print('[time: ${timer.elapsedMilliseconds} ms]');
    }

    // {
    //   var path =
    //       '/Users/scheglov/tmp/2024-04-28/built_value.dart/benchmark_large_library_cycle/macro/lib/value0.dart';
    //   var ori = resourceProvider.getFile(path).readAsStringSync();
    //   resourceProvider.setOverlay(
    //     path,
    //     content: '$ori\n\n void foo() {}',
    //     modificationStamp: -1,
    //   );
    //
    //   for (var analysisContext in collection.contexts) {
    //     analysisContext.changeFile(path);
    //     await analysisContext.applyPendingFileChanges();
    //   }
    //
    //   var timer = Stopwatch()..start();
    //   for (var analysisContext in collection.contexts) {
    //     print(analysisContext.contextRoot.root.path);
    //     var analysisSession = analysisContext.currentSession;
    //     for (var path in analysisContext.contextRoot.analyzedFiles()) {
    //       if (path.endsWith('.dart')) {
    //         // print('  $path');
    //         var libResult = await analysisSession.getResolvedLibrary(path);
    //         if (libResult is ResolvedLibraryResult) {
    //           // for (final unitResult in libResult.units) {
    //           //   // print('    ${unitResult.path}');
    //           //   // print('      errors: ${unitResult.errors}');
    //           //   // print('---');
    //           //   // print(unitResult.content);
    //           //   // print('---');
    //           // }
    //         }
    //       }
    //     }
    //   }
    //   print('[time2: ${timer.elapsedMilliseconds} ms]');
    // }

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
