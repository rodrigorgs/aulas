import 'dart:developer' as developer;
import 'dart:io' as io;
import 'dart:typed_data';

import 'package:analyzer/file_system/overlay_file_system.dart';
import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:analyzer/src/dart/analysis/analysis_context_collection.dart';
import 'package:heap_snapshot/analysis.dart';
import 'package:heap_snapshot/format.dart';
import 'package:vm_service/vm_service.dart';

Future<void> main() async {
  timer.start();

  var resourceProvider = OverlayResourceProvider(
    PhysicalResourceProvider.INSTANCE,
  );

  var analyzerPath = '/Users/scheglov/Source/Dart/sdk.git/sdk/pkg/analyzer';
  var filePath = '$analyzerPath/lib/src/dart/element/element.dart';

  var collection = AnalysisContextCollectionImpl(
    resourceProvider: resourceProvider,
    includedPaths: [analyzerPath],
    withFineDependencies: true,
  );

  var analysisDriver = collection.contextFor(filePath).driver;
  analysisDriver.priorityFiles = [filePath];

  timer.reset();
  await analysisDriver.getResolvedUnit(filePath);
  print('[+${timer.elapsedMilliseconds} ms] Get resolved unit');

  var bytes = _getHeapSnapshot();

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
    print('reachableObjects');
    print('  count: ${measure.count}');
    print('  size: ${formatBytes(measure.size)}');
  }

  // It is interesting to see all reachable objects.
  {
    print('Reachable objects');
    var objects = analysis.reachableObjects;
    analysis.printObjectStats(objects, maxLines: 100);
  }

  {
    print('\n\n');
    print('Tokens');
    var classSet = analysis.classByPredicate((e) {
      return e.name.endsWith('Token') || e.name.endsWith('TokenImpl');
    });
    var objects = analysis.filterByClassId(analysis.reachableObjects, classSet);
    analysis.printObjectStats(objects, maxLines: 100);

    print('\n\n');
    print('Tokens retainers');
    analysis.printRetainers(objects, maxEntries: 10);
  }
}

final Stopwatch timer = Stopwatch();

Future pumpEventQueue([int times = 5000]) {
  if (times == 0) return Future.value();
  return Future.delayed(Duration.zero, () => pumpEventQueue(times - 1));
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

  // ignore: unused_element
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
