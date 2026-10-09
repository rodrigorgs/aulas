import 'package:analyzer/file_system/overlay_file_system.dart';
import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:analyzer/src/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/src/dart/analysis/byte_store.dart';
import 'package:collection/collection.dart';
import 'package:linter/src/rules.dart';

void main() async {
  var resourceProvider = OverlayResourceProvider(
    PhysicalResourceProvider.INSTANCE,
  );

  registerLintRules();

  const iterationCount = 10;
  var allIterationTime = 0;

  var byteStore = MemoryByteStore();
  for (var i = 0; i < iterationCount; i++) {
    var collection = AnalysisContextCollectionImpl(
      sdkPath: '/Users/scheglov/Applications/dart-sdk',
      resourceProvider: resourceProvider,
      includedPaths: ['/Users/scheglov/Source/Dart/sdk.git/sdk/pkg/analyzer'],
      byteStore: byteStore,
      withFineDependencies: true,
    );

    var timer = Stopwatch()..start();

    for (var analysisContext in collection.contexts) {
      // print(analysisContext.contextRoot.root.path);
      var analysisSession = analysisContext.currentSession;
      for (var path in analysisContext.contextRoot.analyzedFiles().sorted()) {
        if (path.endsWith('.dart')) {
          // await analysisSession.getResolvedLibrary(path);
          await analysisSession.getUnitElement(path);
        }
      }
    }

    print('[time: ${timer.elapsedMilliseconds} ms]');
    allIterationTime += timer.elapsedMilliseconds;

    await collection.dispose();
  }

  print('Average iteration time: ${allIterationTime / iterationCount} ms');
}
