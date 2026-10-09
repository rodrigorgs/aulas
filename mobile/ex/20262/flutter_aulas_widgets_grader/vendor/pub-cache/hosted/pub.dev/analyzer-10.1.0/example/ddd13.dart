import 'dart:io' as io;

import 'package:analyzer/file_system/overlay_file_system.dart';
import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:analyzer/src/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/src/dart/analysis/byte_store.dart';
import 'package:analyzer/src/dart/analysis/performance_logger.dart';
import 'package:linter/src/rules.dart';

void main() async {
  var resourceProvider = OverlayResourceProvider(
    PhysicalResourceProvider.INSTANCE,
  );

  registerLintRules();

  var byteStore = MemoryByteStore();

  for (var i = 0; i < 1; i++) {
    var libPath = '/Users/scheglov/dart/admin-portal/lib';
    var collection = AnalysisContextCollectionImpl(
      resourceProvider: resourceProvider,
      includedPaths: [libPath],
      byteStore: byteStore,
      performanceLog: PerformanceLog(io.stdout),
      withFineDependencies: true,
    );

    var path = '$libPath/data/models/entities.dart';
    var file = resourceProvider.getFile(path);
    var baseContent = file.readAsStringSync();

    var analysisContext = collection.contextFor(path);

    {
      await analysisContext.applyPendingFileChanges();
      var analysisSession = analysisContext.currentSession;

      var timer = Stopwatch()..start();
      await analysisSession.getResolvedLibrary(path);
      timer.stop();

      await Future<Null>.delayed(const Duration(milliseconds: 100));
      print('[Initial analysis][time: ${timer.elapsedMilliseconds} ms]');
    }

    {
      var newContent = baseContent.replaceAll(
        "String str = '';",
        "String str = 'X';",
      );
      resourceProvider.setOverlay(
        path,
        content: newContent,
        modificationStamp: 1,
      );
      analysisContext.changeFile(path);

      await analysisContext.applyPendingFileChanges();
      var analysisSession = analysisContext.currentSession;

      var timer = Stopwatch()..start();
      await analysisSession.getResolvedLibrary(path);
      timer.stop();

      await Future<Null>.delayed(const Duration(milliseconds: 100));
      print('[Change method body][time: ${timer.elapsedMilliseconds} ms]');
    }

    {
      var newContent = baseContent.replaceAll(
        "String present(String activeLabel",
        "String present2(String activeLabel",
      );
      resourceProvider.setOverlay(
        path,
        content: newContent,
        modificationStamp: 2,
      );
      analysisContext.changeFile(path);

      await analysisContext.applyPendingFileChanges();
      var analysisSession = analysisContext.currentSession;

      var timer = Stopwatch()..start();
      await analysisSession.getResolvedLibrary(path);
      timer.stop();

      await Future<Null>.delayed(const Duration(milliseconds: 100));
      print('[Change method name][time: ${timer.elapsedMilliseconds} ms]');
    }

    await collection.dispose();
  }
}
