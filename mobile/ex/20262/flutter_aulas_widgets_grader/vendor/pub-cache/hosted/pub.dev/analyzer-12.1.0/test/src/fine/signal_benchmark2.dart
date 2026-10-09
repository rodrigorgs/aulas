// // Copyright (c) 2025, the Dart project authors. Please see the AUTHORS file
// // for details. All rights reserved. Use of this source code is governed by a
// // BSD-style license that can be found in the LICENSE file.
//
// import 'dart:developer' as developer;
// import 'dart:io' as io;
// import 'dart:math';
// import 'dart:typed_data';
//
// import 'package:analyzer/src/fine/signal.dart';
// import 'package:analyzer_utilities/testing/tree_string_sink.dart';
// import 'package:heap_snapshot/analysis.dart';
// import 'package:heap_snapshot/format.dart';
// import 'package:vm_service/vm_service.dart';
//
// main() {
//   const onLevelCount = 10;
//   const levelCount = 6;
//
//   var signalEventListener = _PrintSignalEventListener();
//   var context = SignalContext(
//     // tracer: signalEventListener,
//   );
//
//   var startSignal = ExternalSignal(context: context, initialValue: 1);
//
//   var signals = <Signal<int>>[startSignal];
//   var previousLevel = <Signal<int>>[startSignal];
//   for (var level = 0; level < levelCount; level++) {
//     var newLevel = <Signal<int>>[];
//     for (var parent in previousLevel) {
//       for (var i = 0; i < onLevelCount; i++) {
//         var signal = AddOneSignal(context: context, inputSignal: parent);
//         newLevel.add(signal);
//       }
//     }
//     signals.addAll(newLevel);
//     previousLevel = newLevel;
//   }
//
//   print('[Signals total: ${signals.length}]');
//   print('[Signals leafs: ${previousLevel.length}]');
//   var sumSignal = SumSignal(context: context, signals: previousLevel);
//
//   {
//     var heapBytes = _getHeapSnapshot();
//     _analyzeSnapshot(heapBytes);
//   }
//
//   var sumRead = sumSignal.observe((_) {
//     print('[sumRead][dirty]');
//   });
//
//   for (var i = 0; i < 10; i++) {
//     // print('');
//     // print('');
//     // print('-' * 40);
//
//     timer.reset();
//     // print('[observe: ${sumRead.value}]');
//     sumRead.value;
//     print('[+${timer.elapsedMicroseconds} mcs] Computed sum');
//     // print('');
//
//     // print('');
//     // print(getSignalText(sumSignal));
//     // print('');
//
//     timer.reset();
//     startSignal.setValue(i);
//     // startSignal.subscriptions[0].consumer.invalidate();
//     print('+${timer.elapsedMicroseconds} mcs] Invalidated');
//     // print('');
//
//     // print('');
//     // print(getSignalText(sumSignal));
//     // print('[observe2: ${sumRead.value}]');
//     // print('');
//   }
//
//   signals.length;
// }
//
// final Map<DirtyValueState, String> idMapDirtyState = Map.identity();
//
// final Map<HasValueState, String> idMapHasValueState = Map.identity();
//
// final Map<Signal, int> idMapSignal = Map.identity();
//
// var random = Random();
//
// final Stopwatch timer = Stopwatch()..start();
//
// void assertSignalText(Signal signal, String expected) {
//   var actual = getSignalText(signal);
//   if (actual != expected) {
//     print('-------- Actual --------');
//     print('$actual------------------------');
//     // NodeTextExpectationsCollector.add(actual);
//     throw StateError('The actual is not as expected.');
//   }
// }
//
// String getSignalText(Signal<Object?> signal) {
//   var buffer = StringBuffer();
//   SignalPrinter(
//     idMapSignal: idMapSignal,
//     idMapDirtyState: idMapDirtyState,
//     idMapHasValueState: idMapHasValueState,
//     sink: TreeStringSink(sink: buffer, indent: ''),
//   ).writeSignal(signal);
//   return buffer.toString();
// }
//
// void _analyzeSnapshot(Uint8List bytes) {
//   timer.reset();
//   var graph = HeapSnapshotGraph.fromChunks([
//     bytes.buffer.asByteData(
//       bytes.offsetInBytes,
//       bytes.length,
//     ),
//   ]);
//   print('[+${timer.elapsedMilliseconds} ms] Create HeapSnapshotGraph');
//
//   var analysis = Analysis(graph);
//
//   // Computing reachable objects takes some time.
//   timer.reset();
//   analysis.reachableObjects;
//   print('[+${timer.elapsedMilliseconds} ms] Compute reachable objects');
//   print('');
//   // {
//   //   var measure = analysis.measureObjects(analysis.reachableObjects);
//   //   allResults.add(
//   //     BenchmarkResultCompound(name: 'reachableObjects', children: [
//   //       BenchmarkResultCount(
//   //         name: 'count',
//   //         value: measure.count,
//   //       ),
//   //       BenchmarkResultBytes(
//   //         name: 'size',
//   //         value: measure.size,
//   //       ),
//   //     ]),
//   //   );
//   // }
//
//   // It is interesting to see all reachable objects.
//   {
//     print('Reachable objects');
//     var objects = analysis.reachableObjects;
//     analysis.printObjectStats(objects, maxLines: 20);
//   }
//
//   {
//     var objects = analysis.filterByClass(
//       analysis.reachableObjects,
//       libraryUri: Uri.parse('package:analyzer/src/fine/signal.dart'),
//       name: 'Subscription',
//     );
//     analysis.printObjectStats(objects, maxLines: 10);
//   }
//
//   // {
//   //   print('\n\n');
//   //   print('Tokens');
//   //   print('Instances of: _GrowableList');
//   //   final objectList = analysis.filter(analysis.reachableObjects, (object) {
//   //     return object.klass.libraryUri == Uri.parse('dart:core') &&
//   //         object.klass.name == '_GrowableList';
//   //     // return analysis.variableLengthOf(object) == 0;
//   //   });
//   //
//   //   // final objectList = analysis.filterByClassPatterns(
//   //   //   analysis.reachableObjects,
//   //   //   ['_GrowableList'],
//   //   // );
//   //   final stats = analysis.generateObjectStats(objectList);
//   //   print(formatHeapStats(stats, maxLines: 20));
//   //   print('');
//   //
//   //   const maxEntries = 10;
//   //   final paths = analysis.retainingPathsOf(objectList, 10);
//   //   for (int i = 0; i < paths.length; ++i) {
//   //     if (maxEntries != -1 && i >= maxEntries) break;
//   //     final path = paths[i];
//   //     print('There are ${path.count} retaining paths of');
//   //     print(formatRetainingPath(analysis.graph, paths[i]));
//   //     print('');
//   //   }
//   // }
//
//   // timer.reset();
//   //
//   // allResults.add(
//   //   _doUniqueUriStr(analysis),
//   // );
//   //
//   // allResults.add(
//   //   _doInterfaceType(analysis),
//   // );
//   //
//   // allResults.add(
//   //   _doLinkedData(analysis),
//   // );
//   //
//   // print('[+${timer.elapsedMilliseconds} ms] Compute benchmark results');
//   // print('');
//   //
//   // return allResults;
// }
//
// Uint8List _getHeapSnapshot() {
//   timer.reset();
//   var tmpDir = io.Directory.systemTemp.createTempSync('analyzer_heap');
//   try {
//     var snapshotFile = io.File('${tmpDir.path}/0.heap_snapshot');
//     developer.NativeRuntime.writeHeapSnapshotToFile(snapshotFile.path);
//     print('[+${timer.elapsedMilliseconds} ms] Write heap snapshot');
//
//     timer.reset();
//     var bytes = snapshotFile.readAsBytesSync();
//     print(
//       '[+${timer.elapsedMilliseconds} ms] '
//       'Read heap snapshot, ${bytes.length ~/ (1024 * 1024)} MB',
//     );
//     return bytes;
//   } finally {
//     tmpDir.deleteSync(recursive: true);
//   }
// }
//
// class AllObserver extends ComputedSignal<void> {
//   final List<Signal> signals;
//   final List<Subscription> subscriptions2 = [];
//
//   AllObserver({
//     required super.context,
//     required this.signals,
//   }) {
//     for (var signal in signals) {
//       var subscription = signal.subscribe(this);
//       subscriptions2.add(subscription);
//     }
//   }
//
//   @override
//   void compute() {
//     for (var signal in subscriptions2) {
//       signal.value;
//     }
//     print('[allObserver][compute]');
//   }
// }
//
// class SumSignal extends ComputedSignal<int> {
//   final List<Signal<int>> signals;
//   final List<Subscription<int>> subscriptions2 = [];
//
//   SumSignal({
//     required super.context,
//     required this.signals,
//   }) {
//     for (var signal in signals) {
//       subscriptions2.add(signal.subscribe(this));
//     }
//   }
//
//   @override
//   int compute() {
//     var result = 0;
//     for (var i = 0; i < subscriptions2.length; i++) {
//       result = (result + subscriptions2[i].value) & 0xFFFF;
//     }
//     // for (var subscription in subscriptions2) {
//     //   result = (result + subscription.value) & 0xFFFF;
//     // }
//     return result;
//   }
//
//   @override
//   String toString() {
//     return 'SumSignal';
//   }
// }
//
// class AddOneSignal extends ComputedSignal<int> {
//   final Signal<int> inputSignal;
//   late final Subscription<int> subscription = inputSignal.subscribe(this);
//
//   AddOneSignal({
//     required super.context,
//     required this.inputSignal,
//   });
//
//   @override
//   int compute() {
//     return subscription.value + 1;
//   }
//
//   @override
//   String toString() {
//     return 'AddOneSignal';
//   }
// }
//
// class SignalPrinter {
//   final Map<Signal, int> idMapSignal;
//   final Set<Signal> _printedSignals = Set.identity();
//
//   final Map<DirtyValueState, String> idMapDirtyState;
//   final Map<HasValueState, String> idMapHasValueState;
//
//   final TreeStringSink sink;
//
//   SignalPrinter({
//     required this.idMapSignal,
//     required this.idMapDirtyState,
//     required this.idMapHasValueState,
//     required this.sink,
//   });
//
//   String getIdDirtyState(DirtyValueState state) {
//     if (idMapDirtyState[state] case var id?) {
//       return id;
//     }
//
//     var dirtyId = idMapDirtyState.length;
//     var valueId = getIdHasValueState(state.hasValue);
//     return idMapDirtyState[state] = '$dirtyId:$valueId';
//   }
//
//   String getIdHasValueState(HasValueState state) {
//     return idMapHasValueState[state] ??= '${idMapHasValueState.length}';
//   }
//
//   int getIdSignal(Signal signal) {
//     return idMapSignal[signal] ??= idMapSignal.length;
//   }
//
//   String getSignalValueString(Object? value) {
//     switch (value) {
//       case int value:
//         return ' [int: $value]';
//     }
//     return '';
//   }
//
//   void writeRootSignals(SignalContext context) {
//     var isFirst = true;
//     for (var rootSignal in context.rootSignals) {
//       if (isFirst) {
//         isFirst = false;
//       } else {
//         sink.writeln();
//       }
//       writeSignal(rootSignal);
//     }
//   }
//
//   void writeSignal(Signal signal) {
//     var isNewSignal = _printedSignals.add(signal);
//     var id = getIdSignal(signal);
//
//     var signalStr = signal.toString();
//     signalStr = signalStr.replaceAll(
//       RegExp(r'file: /home/test/lib/test\.dart'),
//       'testFile',
//     );
//
//     if (isNewSignal) {
//       sink.writeIndentedLine(() {
//         sink.write('[$id] $signalStr');
//         switch (signal) {
//           case ObserverSignal():
//             break;
//           case ComputedSignal():
//             switch (signal.state) {
//               case DirtyValueState<Object?> dirty:
//                 var id = getIdDirtyState(dirty);
//                 var valueStr = getSignalValueString(dirty.hasValue.value);
//                 sink.write(' [dirty(${dirty.count}):$id]$valueStr');
//               case HasValueState<Object?> hasValue:
//                 var id = getIdHasValueState(hasValue);
//                 var valueStr = getSignalValueString(hasValue.value);
//                 sink.write(' [hasValue:$id]$valueStr');
//               case NoValueState():
//                 sink.write(' [noValue]');
//             }
//         }
//       });
//       sink.withIndent(() {
//         // Write interesting values.
//         if (signal case ComputedSignal(:HasValueState state)) {
//           if (state.value case List<Signal> signalList) {
//             sink.writeElements('values', signalList, writeSignal);
//           }
//         }
//         // Write dependencies.
//         for (var dependency in signal.directDependencies) {
//           writeSignal(dependency);
//         }
//       });
//     } else {
//       sink.writelnWithIndent('[$id] $signalStr');
//     }
//   }
// }
//
// class _ObjectSetMeasure {
//   final int count;
//   final int size;
//
//   _ObjectSetMeasure({required this.count, required this.size});
// }
//
// class _PrintSignalEventListener extends SignalEventListener {
//   String _indent = '';
//   int propagateDirtyCount2 = 0;
//
//   // @override
//   // void computedIsEqualToDirty(
//   //   Signal<Object?> signal,
//   //   void Function() operation,
//   // ) {
//   //   var oldIndent = _indent;
//   //   print('$_indent[computedIsEqualToDirty] $signal');
//   //   _indent = '$oldIndent  ';
//   //   operation();
//   //   _indent = oldIndent;
//   // }
//   //
//   // @override
//   // T getValue<T>(Signal<Object?> signal, T Function() operation) {
//   //   var oldIndent = _indent;
//   //   try {
//   //     print('$_indent[getValue] $signal');
//   //     _indent = '$oldIndent  ';
//   //     return operation();
//   //   } finally {
//   //     _indent = oldIndent;
//   //   }
//   // }
//   //
//   // @override
//   // void propagateClean(Signal<Object?> signal, void Function() operation) {
//   //   var oldIndent = _indent;
//   //   print('$_indent[propagateClean] $signal');
//   //   _indent = '$oldIndent  ';
//   //   operation();
//   //   _indent = oldIndent;
//   // }
//   //
//   // @override
//   // void propagateCleanCount(Signal<Object?> signal, int newValue) {
//   //   print('$_indent[propagateCleanCount] $signal [count: $newValue]');
//   // }
//   //
//   // @override
//   // void propagateDirty(Signal<Object?> signal, void Function() operation) {
//   //   var oldIndent = _indent;
//   //   print('$_indent[propagateDirty] $signal');
//   //   _indent = '$oldIndent  ';
//   //   operation();
//   //   _indent = oldIndent;
//   // }
//   //
//   // @override
//   // void propagateDirtyCount(Signal<Object?> signal, int newValue) {
//   //   propagateDirtyCount2++;
//   //   print('$_indent[propagateDirtyCount] $signal [count: $newValue]');
//   // }
//   //
//   // @override
//   // void restoredDirtyValue<T>(Signal<T> signal, T value) {
//   //   print('$_indent[restoredDirtyValue] $signal');
//   // }
// }
//
// extension on Analysis {
//   IntSet classByPredicate(bool Function(HeapSnapshotClass) predicate) {
//     var allClasses = graph.classes;
//     var classSet = SpecializedIntSet(allClasses.length);
//     for (var class_ in allClasses) {
//       if (predicate(class_)) {
//         classSet.add(class_.classId);
//       }
//     }
//     return classSet;
//   }
//
//   IntSet filterByClass(
//     IntSet objectIds, {
//     required Uri libraryUri,
//     required String name,
//   }) {
//     var cid = graph.classes.singleWhere((class_) {
//       return class_.libraryUri == libraryUri && class_.name == name;
//     }).classId;
//     return filter(objectIds, (object) => object.classId == cid);
//   }
//
//   _ObjectSetMeasure measureObjects(IntSet objectIds) {
//     var stats = generateObjectStats(objectIds);
//     var totalSize = 0;
//     var totalCount = 0;
//     for (var class_ in stats.classes) {
//       totalCount += stats.counts[class_.classId];
//       totalSize += stats.sizes[class_.classId];
//     }
//     return _ObjectSetMeasure(count: totalCount, size: totalSize);
//   }
//
//   void printObjectStats(IntSet objectIds, {int maxLines = 20}) {
//     var stats = generateObjectStats(objectIds);
//     print(formatHeapStats(stats, maxLines: maxLines));
//     print('');
//   }
//
//   // ignore: unused_element
//   void printRetainers(
//     IntSet objectIds, {
//     int maxEntries = 3,
//   }) {
//     var paths = retainingPathsOf(objectIds, 20);
//     for (int i = 0; i < paths.length; ++i) {
//       if (i >= maxEntries) break;
//       var path = paths[i];
//       print('There are ${path.count} retaining paths of');
//       print(formatRetainingPath(graph, paths[i]));
//       print('');
//     }
//   }
// }
