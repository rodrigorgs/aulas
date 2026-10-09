import 'dart:developer' as developer;
import 'dart:io' as io;
import 'dart:typed_data';

import 'package:analyzer/file_system/overlay_file_system.dart';
import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:analyzer/src/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/src/dart/analysis/byte_store.dart';
import 'package:analyzer/src/dart/analysis/driver_event.dart';
import 'package:analyzer/src/dart/analysis/performance_logger.dart';
import 'package:analyzer/src/dart/analysis/results.dart';
import 'package:heap_snapshot/analysis.dart';
import 'package:heap_snapshot/format.dart';
import 'package:linter/src/rules.dart';
import 'package:vm_service/vm_service.dart';

void main() async {
  var resourceProvider = OverlayResourceProvider(
    PhysicalResourceProvider.INSTANCE,
  );

  registerLintRules();

  var byteStore = NullByteStore();

  var packageRootPath = '/Users/scheglov/dart/admin-portal';
  var libPath = '$packageRootPath/lib';

  // var builder = PackageConfigFileBuilder()
  //   ..add(
  //     name: 'test',
  //     rootPath: packageRootPath,
  //   );
  //
  // resourceProvider.setOverlay(
  //   '$packageRootPath/.dart_tool/package_config.json',
  //   content: builder.toContent(
  //     toUriStr: (path) {
  //       var pathContext = resourceProvider.pathContext;
  //       return pathContext.toUri(path).toString();
  //     },
  //   ),
  //   modificationStamp: 0,
  // );

  var modelPath = '$libPath/data/models/group_model.dart';
  var modelCode = resourceProvider.getFile(modelPath).readAsStringSync();

  var collection = AnalysisContextCollectionImpl(
    resourceProvider: resourceProvider,
    // includedPaths: [libPath],
    includedPaths: [
      '/Users/scheglov/dart/admin-portal/lib/data/models/group_model.dart',
      '/Users/scheglov/dart/admin-portal/lib/utils/formatting.dart',
      '/Users/scheglov/dart/admin-portal/lib/redux/company/company_selectors.dart',
    ],
    byteStore: byteStore,
    performanceLog: PerformanceLog(io.stdout),
    drainStreams: false,
    withFineDependencies: true,
  );

  var analysisContext = collection.contextFor(modelPath);
  for (var path in analysisContext.contextRoot.analyzedFiles()) {
    if (path.endsWith('.dart')) {
      analysisContext.driver.addFile(path);
    }
  }

  analysisContext.driver.scheduler.events.listen((event) {
    switch (event) {
      case AnalyzeFile analyzeFile:
        print('[events][analyzeFile][file: ${analyzeFile.file}]');
      case ResolvedUnitResultImpl unitResult:
        print('[events][resolvedUnit][file: ${unitResult.file}]');
        print('  [events][errors: ${unitResult.errors}]');
      default:
        print('[events][event: $event]');
    }
  });

  await collection.scheduler.waitForIdle();
  await pumpEventQueue();
  print('\n' * 2);
  print('[S] Now idle');
  print('-' * 64);

  {
    var heapBytes = _getHeapSnapshot();
    _analyzeSnapshot(heapBytes);
  }
  print('\n' * 2);
  print('[S] Printed heap analysis');
  print('-' * 64);

  resourceProvider.setOverlay(
    modelPath,
    content: modelCode.replaceAll(
      'bool get hasCurrency =>',
      'bool get hasCurrency2 =>',
    ),
    modificationStamp: 1,
  );
  analysisContext.changeFile(modelPath);
  print('[S] hasCurrency -> hasCurrency2');
  print('\n' * 2);
  await collection.scheduler.waitForIdle();
  await pumpEventQueue();
  print('\n' * 2);
  print('[S] Now idle');
  print('-' * 64);

  resourceProvider.setOverlay(
    modelPath,
    content: modelCode.replaceAll(
      'bool get hasCurrency2 =>',
      'bool get hasCurrency =>',
    ),
    modificationStamp: 2,
  );
  analysisContext.changeFile(modelPath);
  print('[S] hasCurrency2 -> hasCurrency');
  print('\n' * 2);
  await collection.scheduler.waitForIdle();
  await pumpEventQueue();
  print('\n' * 2);
  print('[S] Now idle');
  print('-' * 64);

  resourceProvider.setOverlay(
    modelPath,
    content: modelCode.replaceAll(
      'bool get hasCurrency =>',
      'bool get hasCurrency2 =>',
    ),
    modificationStamp: 3,
  );
  analysisContext.changeFile(modelPath);
  print('[S] hasCurrency -> hasCurrency2');
  print('\n' * 2);
  await collection.scheduler.waitForIdle();
  await pumpEventQueue();
  print('\n' * 2);
  print('[S] Now idle');
  print('-' * 64);

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
  // {
  //   var measure = analysis.measureObjects(analysis.reachableObjects);
  //   allResults.add(
  //     BenchmarkResultCompound(name: 'reachableObjects', children: [
  //       BenchmarkResultCount(
  //         name: 'count',
  //         value: measure.count,
  //       ),
  //       BenchmarkResultBytes(
  //         name: 'size',
  //         value: measure.size,
  //       ),
  //     ]),
  //   );
  // }

  // It is interesting to see all reachable objects.
  {
    print('Reachable objects');
    var objects = analysis.reachableObjects;
    analysis.printObjectStats(objects, maxLines: 100);
  }

  // {
  //   print('\n\n');
  //   print('Tokens');
  //   print('Instances of: _GrowableList');
  //   final objectList = analysis.filter(analysis.reachableObjects, (object) {
  //     return object.klass.libraryUri == Uri.parse('dart:core') &&
  //         object.klass.name == '_GrowableList';
  //     // return analysis.variableLengthOf(object) == 0;
  //   });
  //
  //   // final objectList = analysis.filterByClassPatterns(
  //   //   analysis.reachableObjects,
  //   //   ['_GrowableList'],
  //   // );
  //   final stats = analysis.generateObjectStats(objectList);
  //   print(formatHeapStats(stats, maxLines: 20));
  //   print('');
  //
  //   const maxEntries = 10;
  //   final paths = analysis.retainingPathsOf(objectList, 10);
  //   for (int i = 0; i < paths.length; ++i) {
  //     if (maxEntries != -1 && i >= maxEntries) break;
  //     final path = paths[i];
  //     print('There are ${path.count} retaining paths of');
  //     print(formatRetainingPath(analysis.graph, paths[i]));
  //     print('');
  //   }
  // }

  // timer.reset();
  //
  // allResults.add(
  //   _doUniqueUriStr(analysis),
  // );
  //
  // allResults.add(
  //   _doInterfaceType(analysis),
  // );
  //
  // allResults.add(
  //   _doLinkedData(analysis),
  // );
  //
  // print('[+${timer.elapsedMilliseconds} ms] Compute benchmark results');
  // print('');
  //
  // return allResults;
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

extension on Analysis {
  // IntSet classByPredicate(bool Function(HeapSnapshotClass) predicate) {
  //   var allClasses = graph.classes;
  //   var classSet = SpecializedIntSet(allClasses.length);
  //   for (var class_ in allClasses) {
  //     if (predicate(class_)) {
  //       classSet.add(class_.classId);
  //     }
  //   }
  //   return classSet;
  // }

  // IntSet filterByClass(
  //   IntSet objectIds, {
  //   required Uri libraryUri,
  //   required String name,
  // }) {
  //   var cid = graph.classes.singleWhere((class_) {
  //     return class_.libraryUri == libraryUri && class_.name == name;
  //   }).classId;
  //   return filter(objectIds, (object) => object.classId == cid);
  // }

  // _ObjectSetMeasure measureObjects(IntSet objectIds) {
  //   var stats = generateObjectStats(objectIds);
  //   var totalSize = 0;
  //   var totalCount = 0;
  //   for (var class_ in stats.classes) {
  //     totalCount += stats.counts[class_.classId];
  //     totalSize += stats.sizes[class_.classId];
  //   }
  //   return _ObjectSetMeasure(count: totalCount, size: totalSize);
  // }

  void printObjectStats(IntSet objectIds, {int maxLines = 20}) {
    var stats = generateObjectStats(objectIds);
    print(formatHeapStats(stats, maxLines: maxLines));
    print('');
  }

  // ignore: unused_element
  void printRetainers(IntSet objectIds, {int maxEntries = 3}) {
    var paths = retainingPathsOf(objectIds, 20);
    for (int i = 0; i < paths.length; ++i) {
      if (i >= maxEntries) break;
      var path = paths[i];
      print('There are ${path.count} retaining paths of');
      print(formatRetainingPath(graph, paths[i]));
      print('');
    }
  }
}

// class _ObjectSetMeasure {
//   final int count;
//   final int size;
//
//   _ObjectSetMeasure({required this.count, required this.size});
// }
