import 'dart:developer' as developer;
import 'dart:io' as io;
import 'dart:typed_data';

import 'package:analyzer/file_system/overlay_file_system.dart';
import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:analyzer/src/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/src/dart/analysis/file_byte_store.dart';
import 'package:analyzer/src/dart/analysis/file_content_cache.dart';
import 'package:analyzer/src/util/performance/operation_performance.dart';
import 'package:heap_snapshot/analysis.dart';
import 'package:heap_snapshot/format.dart';
import 'package:linter/src/rules.dart';
import 'package:vm_service/vm_service.dart';

void main() async {
  var resourceProvider = OverlayResourceProvider(
    PhysicalResourceProvider.INSTANCE,
  );

  // withFineDependencies = true;
  registerLintRules();

  // var byteStore = MemoryByteStore();

  var cacheDir = io.Directory('/Users/scheglov/tmp/2025/2025-09-24/cache');
  cacheDir.deleteSync(recursive: true);
  cacheDir.createSync();
  var byteStore = FileByteStore(cacheDir.path);

  // var byteStore = MemoryCachingByteStore(
  //   FileByteStore('/Users/scheglov/tmp/2025/2025-02-21/cache'),
  //   1024 * 1024 * 128,
  // );

  var packageRootPath = '/Users/scheglov/Source/Dart/sdk.git/sdk/pkg/analyzer';
  var libPath = '$packageRootPath/lib';

  var targetPath = '$libPath/src/fine/library_manifest.dart';
  print(targetPath);
  var targetCode = resourceProvider.getFile(targetPath).readAsStringSync();

  var collection = AnalysisContextCollectionImpl(
    resourceProvider: resourceProvider,
    sdkPath: '/Users/scheglov/Applications/dart-sdk',
    includedPaths: [
      // '/Users/scheglov/Source/Dart/sdk.git/sdk/pkg/analyzer/lib/src/dart/ast',
      // '/Users/scheglov/Source/Dart/sdk.git/sdk/pkg/analyzer/lib/src/summary2',
      '/Users/scheglov/Source/Dart/sdk.git/sdk/pkg/analyzer',
      // '/Users/scheglov/Source/Dart/sdk.git/sdk/pkg/analysis_server',
      // '/Users/scheglov/Source/Dart/sdk.git/sdk/pkg/linter',
      // '/Users/scheglov/Source/Dart/sdk.git/sdk/pkg/analysis_server_plugin',
      // '/Users/scheglov/Source/Dart/sdk.git/sdk/pkg/analyzer_cli',
    ],
    byteStore: byteStore,
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

  // for (var analysisContext in collection.contexts) {
  //   var session = analysisContext.currentSession as AnalysisSessionImpl;
  //   session.clearHierarchies();
  // }

  _analyzeSnapshot(_getHeapSnapshot());

  // await Future.delayed(const Duration(seconds: 15), () => 0,);

  resourceProvider.setOverlay(
    targetPath,
    content: targetCode.replaceAll('computeManifests({', 'computeManifests2({'),
    modificationStamp: 1,
  );
  for (var analysisContext in collection.contexts) {
    analysisContext.changeFile(targetPath);
  }

  print('[S] computeManifests() -> computeManifests2()');
  print('\n' * 2);

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

  print('[S] Disposing...');
  await collection.dispose();
}

final Stopwatch timer = Stopwatch();

Future pumpEventQueue([int times = 5000]) {
  if (times == 0) return Future.value();
  return Future.delayed(Duration.zero, () => pumpEventQueue(times - 1));
}

void _analyzeSnapshot(Uint8List bytes) {
  timer.reset();
  var graph = HeapSnapshotGraph.fromChunks([
    bytes.buffer.asByteData(bytes.offsetInBytes, bytes.length),
  ]);
  print('[+${timer.elapsedMilliseconds} ms] Create HeapSnapshotGraph');

  var analysis = Analysis(graph);

  // Computing reachable objects takes some time.
  timer.reset();
  analysis.reachableObjects;
  print('[+${timer.elapsedMilliseconds} ms] Compute reachable objects');
  print('');
  {
    var measure = analysis.measureObjects(analysis.reachableObjects);
    print(
      '[reachableObjects]'
          '[count: ${measure.count}][bytes: ${formatBytes(measure.size)}]',
    );
  }

  // It is interesting to see all reachable objects.
      {
    print('Reachable objects');
    var objects = analysis.reachableObjects;
    analysis.printObjectStats(objects, maxLines: 100);
  }

  {
    print('');
    print('');
    print('LibraryManifest, transitive');
    var libraryManifests = analysis.filterByClass(
      analysis.reachableObjects,
      libraryUri: Uri.parse('package:analyzer/src/fine/library_manifest.dart'),
      name: 'LibraryManifest',
    );
    var objects = analysis.transitiveGraph(libraryManifests);
    analysis.printObjectStats(objects, maxLines: 25);
    analysis.printRetainers(libraryManifests);
  }

  {
    print('');
    print('');
    print('RequirementsManifest, transitive');
    var requirementsManifests = analysis.filterByClass(
      analysis.reachableObjects,
      libraryUri: Uri.parse('package:analyzer/src/fine/requirements.dart'),
      name: 'RequirementsManifest',
    );
    var objects = analysis.transitiveGraph(requirementsManifests);
    analysis.printObjectStats(objects, maxLines: 25);
    analysis.printRetainers(requirementsManifests);
  }

  {
    print('');
    print('');
    print('ManifestItemIdList, transitive');
    var requirementsManifests = analysis.filterByClass(
      analysis.reachableObjects,
      libraryUri: Uri.parse('package:analyzer/src/fine/manifest_id.dart'),
      name: 'ManifestItemIdList',
    );
    var objects = analysis.transitiveGraph(requirementsManifests);
    analysis.printObjectStats(objects, maxLines: 25);

    // analysis.printRetainers(
    //   analysis.filterByClass(
    //     objects,
    //     libraryUri: Uri.parse('dart:core'),
    //     name: '_GrowableList',
    //   ),
    // );
  }

  {
    print('');
    print('');
    print('MemoryByteStore, transitive');
    var targetObjects = analysis.filterByClass(
      analysis.reachableObjects,
      libraryUri: Uri.parse(
        'package:analyzer/src/dart/analysis/byte_store.dart',
      ),
      name: 'MemoryByteStore',
    );
    var objects = analysis.transitiveGraph(targetObjects);
    analysis.printObjectStats(objects, maxLines: 25);
  }

  // {
  //   print('');
  //   print('');
  //   print('LinkedBundleProvider, transitive');
  //   var targetObjects = analysis.filterByClass(
  //     analysis.reachableObjects,
  //     libraryUri: Uri.parse(
  //       'package:analyzer/src/dart/analysis/library_context.dart',
  //     ),
  //     name: 'LinkedBundleProvider',
  //   );
  //   var objects = analysis.transitiveGraph(targetObjects);
  //   analysis.printObjectStats(objects, maxLines: 50);
  // }

  // {
  //   print('');
  //   print('');
  //   print('_List from dart:core');
  //   var objects = analysis.filterByClass(
  //     analysis.reachableObjects,
  //     libraryUri: Uri.parse('dart:core'),
  //     name: '_List',
  //   );
  //   analysis.printRetainers(objects, maxEntries: 5);
  // }

      {
    print('');
    print('');
    print('_Uint8List from dart:typed_data');
    var objects = analysis.filterByClass(
      analysis.reachableObjects,
      libraryUri: Uri.parse('dart:typed_data'),
      name: '_Uint8List',
    );
    analysis.printObjectStats(objects, maxLines: 25);
    analysis.printRetainers(objects, maxEntries: 5);
  }

  timer.reset();

  print('[+${timer.elapsedMilliseconds} ms] Compute benchmark results');
  print('');
}

Uint8List _getHeapSnapshot() {
  timer.reset();
  var tmpDir = io.Directory.systemTemp.createTempSync('analyzer_heap');
  try {
    var snapshotFile = io.File('${tmpDir.path}/0.heap_snapshot');
    developer.NativeRuntime.writeHeapSnapshotToFile(snapshotFile.path);
    print('[+${timer.elapsedMilliseconds} ms] Write heap snapshot');

    timer.reset();
    var bytes = snapshotFile.readAsBytesSync();
    print(
      '[+${timer.elapsedMilliseconds} ms] '
          'Read heap snapshot, ${bytes.length ~/ (1024 * 1024)} MB',
    );
    return bytes;
  } finally {
    tmpDir.deleteSync(recursive: true);
  }
}

class _ObjectSetMeasure {
  final int count;
  final int size;

  _ObjectSetMeasure({required this.count, required this.size});
}

extension on Analysis {
  // ignore: unused_element
  IntSet classByPredicate(bool Function(HeapSnapshotClass) predicate) {
    var allClasses = graph.classes;
    var classSet = SpecializedIntSet(allClasses.length);
    for (var class_ in allClasses) {
      if (predicate(class_)) {
        classSet.add(class_.classId);
      }
    }
    return classSet;
  }

  IntSet filterByClass(
      IntSet objectIds, {
        required Uri libraryUri,
        required String name,
      }) {
    var cid = graph.classes.singleWhere((class_) {
      return class_.libraryUri == libraryUri && class_.name == name;
    }).classId;
    return filter(objectIds, (object) => object.classId == cid);
  }

  _ObjectSetMeasure measureObjects(IntSet objectIds) {
    var stats = generateObjectStats(objectIds);
    var totalSize = 0;
    var totalCount = 0;
    for (var class_ in stats.classes) {
      totalCount += stats.counts[class_.classId];
      totalSize += stats.sizes[class_.classId];
    }
    return _ObjectSetMeasure(count: totalCount, size: totalSize);
  }

  void printObjectStats(IntSet objectIds, {int maxLines = 20}) {
    var stats = generateObjectStats(objectIds);
    print(formatHeapStats(stats, maxLines: maxLines));
    print('');
  }

  // ign ore: unused_element
  void printRetainers(IntSet objectIds, {int maxEntries = 3}) {
    var paths = <DedupedUint32List, IntSet>{};
    for (var oId in objectIds) {
      var pathList = retainingPathsOf(IntSet()..add(oId), 20);
      if (pathList.isNotEmpty) {
        var path = pathList.first;
        paths.putIfAbsent(path, () => IntSet()).add(oId);
      }
    }

    var sortedPaths = paths.keys.toList()
      ..sort((a, b) => paths[b]!.length - paths[a]!.length);

    for (int i = 0; i < sortedPaths.length; ++i) {
      if (i >= maxEntries) break;
      var path = sortedPaths[i];
      var objects = paths[path]!;
      var measure = measureObjects(objects);
      print(
        'There are ${objects.length} retaining paths of, '
            'size: ${formatBytes(measure.size)}',
      );
      print(formatRetainingPath(graph, path));
      print('');
    }
  }
}
