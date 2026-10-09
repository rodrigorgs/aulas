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
        // '/Users/scheglov/dart/macro_benchmark/generated/json-manual/package_under_test',
        '/Users/scheglov/dart/macro_benchmark/generated/json-macro/package_under_test',
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
            await analysisSession.getUnitElement(path);
            // await analysisSession.getResolvedUnit(path);

            // var ur = (await analysisSession.getUnitElement(path)) as UnitElementResult;
            // var library = ur.element.library as LibraryElementImpl;
            // print(library.augmentations.single.macroGenerated!.code);
          }
        }
      }
      print('[time: ${timer.elapsedMilliseconds} ms]');
    }

    {
      var buffer = StringBuffer();
      collection.scheduler.accumulatedPerformance.write(buffer: buffer);
      print(buffer);
      collection.scheduler.accumulatedPerformance = OperationPerformanceImpl(
        '<scheduler>',
      );
    }

    // {
    //   var buffer = StringBuffer();
    //   md5Operation.write(buffer: buffer);
    //   print(buffer);
    //   md5Operation = OperationPerformanceImpl('md5-root');
    // }

    await collection.dispose();
  }
}
