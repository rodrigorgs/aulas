import 'dart:io' as io;

import 'package:analyzer/file_system/overlay_file_system.dart';
import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:analyzer/src/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/src/dart/analysis/byte_store.dart';
import 'package:analyzer/src/dart/analysis/performance_logger.dart';
import 'package:analyzer/src/util/performance/operation_performance.dart';
import 'package:linter/src/rules.dart';

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
      '/Users/scheglov/dart/admin-portal/lib',
      // '/Users/scheglov/dart/admin-portal/lib/data/models/group_model.dart',
      // '/Users/scheglov/dart/admin-portal/lib/utils/formatting.dart',
      // '/Users/scheglov/dart/admin-portal/lib/redux/company/company_selectors.dart',
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

  // analysisContext.driver.scheduler.events.listen((event) {
  //   switch (event) {
  //     case AnalyzeFile analyzeFile:
  //       print('[events][analyzeFile][file: ${analyzeFile.file}]');
  //     case ResolvedUnitResultImpl unitResult:
  //       print('[events][resolvedUnit][file: ${unitResult.file}]');
  //       print('  [events][errors: ${unitResult.errors}]');
  //     default:
  //       print('[events][event: $event]');
  //   }
  // });

  await collection.scheduler.waitForIdle();
  await pumpEventQueue();
  print('\n' * 2);
  print('[S] Now idle');
  print('-' * 64);

  {
    var buffer = StringBuffer();
    collection.scheduler.accumulatedPerformance.write(buffer: buffer);
    print(buffer);
    collection.scheduler.accumulatedPerformance = OperationPerformanceImpl(
      '<scheduler>',
    );
  }

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

  {
    var buffer = StringBuffer();
    collection.scheduler.accumulatedPerformance.write(buffer: buffer);
    print(buffer);
    collection.scheduler.accumulatedPerformance = OperationPerformanceImpl(
      '<scheduler>',
    );
  }

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

  {
    var buffer = StringBuffer();
    collection.scheduler.accumulatedPerformance.write(buffer: buffer);
    print(buffer);
    collection.scheduler.accumulatedPerformance = OperationPerformanceImpl(
      '<scheduler>',
    );
  }

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

  {
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
