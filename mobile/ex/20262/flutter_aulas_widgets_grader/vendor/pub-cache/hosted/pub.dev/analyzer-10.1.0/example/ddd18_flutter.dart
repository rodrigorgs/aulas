import 'dart:io' as io;

import 'package:analyzer/file_system/overlay_file_system.dart';
import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:analyzer/src/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/src/dart/analysis/byte_store.dart';
import 'package:analyzer/src/dart/analysis/file_content_cache.dart';
import 'package:analyzer/src/dart/analysis/performance_logger.dart';
import 'package:analyzer/src/util/performance/operation_performance.dart';
import 'package:linter/src/rules.dart';

void main() async {
  var resourceProvider = OverlayResourceProvider(
    PhysicalResourceProvider.INSTANCE,
  );

  registerLintRules();

  var byteStore = MemoryByteStore();
  // var byteStore = MemoryCachingByteStore(
  //   FileByteStore('/Users/scheglov/tmp/2025/2025-02-21/cache'),
  //   1024 * 1024 * 128,
  // );

  var packageRootPath = '/Users/scheglov/Source/flutter/packages/flutter';
  var libPath = '$packageRootPath/lib';

  // var targetPath = '$libPath/src/widgets/binding.dart';
  // print(targetPath);
  // var targetCode = resourceProvider.getFile(targetPath).readAsStringSync();

  var targetPath = '$libPath/src/widgets/banner.dart';
  print(targetPath);
  var targetCode = resourceProvider.getFile(targetPath).readAsStringSync();

  var collection = AnalysisContextCollectionImpl(
    resourceProvider: resourceProvider,
    sdkPath: '/Users/scheglov/Applications/dart-sdk',
    includedPaths: [
      '/Users/scheglov/Source/flutter/packages/flutter',
      // '/Users/scheglov/Source/flutter/packages/flutter/lib/src/widgets/banner.dart',
      // '/Users/scheglov/Source/flutter/packages/flutter/test/foundation/isolates_test.dart',
      // '/Users/scheglov/Source/flutter/packages/flutter/test/painting/image_provider_test.dart',
      // '/Users/scheglov/Source/flutter/packages/flutter/test/material/icons_test.dart',
      // '/Users/scheglov/Source/flutter/packages/flutter/lib/src/painting/text_scaler.dart',
      // '/Users/scheglov/Source/flutter/packages/flutter/lib/src/painting/image_provider.dart',
      // '/Users/scheglov/Source/flutter/packages/flutter/lib/src/rendering/object.dart',
      // '/Users/scheglov/Source/flutter/packages/flutter/lib/src/rendering/selection.dart',
      // '/Users/scheglov/Source/flutter/packages/flutter/lib/src/rendering/layer.dart',
      // '/Users/scheglov/Source/flutter/packages/flutter/lib/src/cupertino/sliding_segmented_control.dart',
      // '/Users/scheglov/Source/flutter/packages/flutter/lib/src/material/material_state_mixin.dart',
      // '/Users/scheglov/Source/flutter/packages/flutter/lib/src/material/input_decorator.dart',
      // '/Users/scheglov/Source/flutter/packages/flutter/lib/src/material/carousel.dart',
      // '/Users/scheglov/Source/flutter/packages/flutter/lib/src/material/ink_well.dart',
      // '/Users/scheglov/Source/flutter/packages/flutter/lib/src/widgets/router.dart',
      // '/Users/scheglov/Source/flutter/packages/flutter/lib/src/widgets/widget_state.dart',
      // '/Users/scheglov/Source/flutter/packages/flutter/lib/src/widgets/routes.dart',
      // '/Users/scheglov/Source/flutter/packages/flutter/lib/src/widgets/basic.dart',
      // '/Users/scheglov/Source/flutter/packages/flutter/lib/src/widgets/restoration_properties.dart',
      // '/Users/scheglov/Source/flutter/packages/flutter/lib/src/widgets/draggable_scrollable_sheet.dart',
      // '/Users/scheglov/Source/flutter/packages/flutter/lib/src/widgets/radio_group.dart',
      // '/Users/scheglov/Source/flutter/packages/flutter/lib/src/widgets/widget_inspector.dart',
      '/Users/scheglov/Source/flutter/packages/flutter_tools',
    ],
    // /Users/scheglov/Source/flutter/packages/flutter/lib/src/widgets/binding.dart
    byteStore: byteStore,
    fileContentCache: FileContentCache(resourceProvider),
    performanceLog: PerformanceLog(io.stdout),
    withFineDependencies: true,
  );

  for (var analysisContext in collection.contexts) {
    for (var path in analysisContext.contextRoot.analyzedFiles()) {
      if (path.endsWith('.dart')) {
        analysisContext.driver.addFile(path);
      }
    }
  }

  for (var i = 0; i < 100; i++) {
    await collection.scheduler.waitForIdle();
    await pumpEventQueue();
  }
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

  // await Future.delayed(const Duration(seconds: 15), () => 0,);

  // resourceProvider.setOverlay(
  //   targetPath,
  //   content: targetCode.replaceAll(
  //     'Future<bool> didPopRoute()',
  //     'Future<bool> didPopRoute2()',
  //   ),
  //   modificationStamp: 1,
  // );
  resourceProvider.setOverlay(
    targetPath,
    content: targetCode.replaceAll('bool hitTest(', 'bool hitTest2('),
    modificationStamp: 1,
  );
  for (var analysisContext in collection.contexts) {
    analysisContext.changeFile(targetPath);
  }

  // print('[S] createRenderObject() -> didPopRoute2()');
  print('[S] createRenderObject( -> createRenderObject2(');
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

final Stopwatch timer = Stopwatch()..start();

Future pumpEventQueue([int times = 5000]) {
  if (times == 0) return Future.value();
  return Future.delayed(Duration.zero, () => pumpEventQueue(times - 1));
}
