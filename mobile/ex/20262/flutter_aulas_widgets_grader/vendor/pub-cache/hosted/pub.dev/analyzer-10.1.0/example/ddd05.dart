import 'package:analyzer/file_system/overlay_file_system.dart';
import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:analyzer/src/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/src/dart/analysis/byte_store.dart';

void main() async {
  {
    var byteStore = MemoryByteStore();

    var resourceProvider = OverlayResourceProvider(
      PhysicalResourceProvider.INSTANCE,
    );

    var analysisOptionsPath =
        '/Users/scheglov/Source/Dart/analysis_options.yaml';
    resourceProvider.setOverlay(
      analysisOptionsPath,
      content: r'''
analyzer:
  enable-experiment:
    - declaring-constructors
    - augmentations
    - enhanced-parts
''',
      modificationStamp: -1,
    );

    var collection = AnalysisContextCollectionImpl(
      resourceProvider: resourceProvider,
      includedPaths: ['/Users/scheglov/tmp/2025/2025-10-27/essential_lints'],
      byteStore: byteStore,
      optionsFile: analysisOptionsPath,
      withFineDependencies: true,
    );

    var timer = Stopwatch()..start();
    for (var analysisContext in collection.contexts) {
      print(analysisContext.contextRoot.root.path);
      var analysisSession = analysisContext.currentSession;
      for (var path in analysisContext.contextRoot.analyzedFiles()) {
        if (path.endsWith('.dart')) {
          print(path);
          await analysisSession.getUnitElement(path);
        }
      }
    }
    print('[time: ${timer.elapsedMilliseconds} ms]');

    await collection.dispose();
  }
}
