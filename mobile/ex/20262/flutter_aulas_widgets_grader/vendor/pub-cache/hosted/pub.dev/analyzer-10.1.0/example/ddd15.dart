// import 'dart:io' as io;
//
// import 'package:analyzer/file_system/overlay_file_system.dart';
// import 'package:analyzer/file_system/physical_file_system.dart';
// import 'package:analyzer/src/dart/analysis/analysis_context_collection.dart';
// import 'package:analyzer/src/dart/analysis/byte_store.dart';
// import 'package:analyzer/src/dart/analysis/driver_event.dart';
// import 'package:analyzer/src/dart/analysis/performance_logger.dart';
// import 'package:analyzer/src/dart/analysis/results.dart';
// import 'package:analyzer/utilities/package_config_file_builder.dart';
// import 'package:linter/src/rules.dart';
//
// void main() async {
//   var resourceProvider = OverlayResourceProvider(
//     PhysicalResourceProvider.INSTANCE,
//   );
//
//   registerLintRules();
//
//   var byteStore = NullByteStore();
//
//   var builder =
//       PackageConfigFileBuilder()..add(name: 'test', rootPath: '/home/test');
//
//   resourceProvider.setOverlay(
//     '/home/test/.dart_tool/package_config.json',
//     content: builder.toContent(pathContext: resourceProvider.pathContext),
//     modificationStamp: 0,
//   );
//
//   var libPath = '/home/test/lib';
//
//   var modelPath = '$libPath/group_model.dart';
//   resourceProvider.setOverlay(
//     modelPath,
//     content: r'''
// import 'user_1.dart';
// import 'user_2.dart';
// import 'user_3.dart';
// class GroupEntity {
//   bool get hasCurrency => true;
//   bool get hasLanguage => true;
// }
// ''',
//     modificationStamp: 0,
//   );
//
//   var userPath_1 = '$libPath/user_1.dart';
//   resourceProvider.setOverlay(
//     userPath_1,
//     content: r'''
// import 'group_model.dart';
// void f1(GroupEntity group) {
//   group.hasCurrency;
// }
// ''',
//     modificationStamp: 0,
//   );
//
//   var userPath_2 = '$libPath/user_2.dart';
//   resourceProvider.setOverlay(
//     userPath_2,
//     content: r'''
// import 'group_model.dart';
// void f2(GroupEntity group) {
//   group.hasLanguage;
// }
// ''',
//     modificationStamp: 0,
//   );
//
//   var userPath_3 = '$libPath/user_3.dart';
//   resourceProvider.setOverlay(
//     userPath_3,
//     content: r'''
// import 'group_model.dart';
// void f2(GroupEntity group) {
//   group.hasCurrency;
// }
// ''',
//     modificationStamp: 0,
//   );
//
//   var collection = AnalysisContextCollectionImpl(
//     resourceProvider: resourceProvider,
//     includedPaths: [libPath],
//     byteStore: byteStore,
//     performanceLog: PerformanceLog(io.stdout),
//     drainStreams: false,
//   );
//
//   var analysisContext = collection.contextFor(libPath);
//   // analysisContext.driver.addFile(modelPath);
//   analysisContext.driver.addFile(userPath_1);
//   analysisContext.driver.addFile(userPath_2);
//   analysisContext.driver.addFile(userPath_3);
//
//   analysisContext.driver.scheduler.events.listen((event) {
//     switch (event) {
//       case AnalyzeFile analyzeFile:
//         print('[events][analyzeFile][file: ${analyzeFile.file}]');
//       case ResolvedUnitResultImpl unitResult:
//         print('[events][resolvedUnit][file: ${unitResult.file}]');
//         print('  [events][errors: ${unitResult.errors}]');
//       default:
//         print('[events][event: $event]');
//     }
//   });
//
//   // {
//   //   await analysisContext.applyPendingFileChanges();
//   //   var analysisSession = analysisContext.currentSession;
//   //
//   //   await analysisSession.getLibraryByUri(
//   //     'package:test/group_model.dart',
//   //   );
//   //   print('\n' * 2);
//   //
//   //   // print('Analyze #1\n');
//   //   // await analysisSession.getResolvedLibrary(path);
//   //   // print('\n' * 2);
//   // }
//
//   await collection.scheduler.waitForIdle();
//   await pumpEventQueue();
//   print('\n' * 2);
//   print('[S] Now idle');
//   print('-' * 64);
//
//   resourceProvider.setOverlay(
//     modelPath,
//     content: r'''
// import 'user_1.dart';
// import 'user_2.dart';
// import 'user_3.dart';
// class GroupEntity {
//   bool get hasCurrency2 => true;
//   bool get hasLanguage => true;
// }
// ''',
//     modificationStamp: 1,
//   );
//   analysisContext.changeFile(modelPath);
//   print('[S] hasCurrency -> hasCurrency2');
//   print('\n' * 2);
//
//   await collection.scheduler.waitForIdle();
//   await pumpEventQueue();
//   print('\n' * 2);
//   print('[S] Now idle');
//   print('-' * 64);
//
//   resourceProvider.setOverlay(
//     modelPath,
//     content: r'''
// import 'user_1.dart';
// import 'user_2.dart';
// import 'user_3.dart';
// class GroupEntity {
//   bool get hasCurrency => true;
//   bool get hasLanguage => true;
// }
// ''',
//     modificationStamp: 1,
//   );
//   analysisContext.changeFile(modelPath);
//   print('[S] hasCurrency2 -> hasCurrency');
//   print('\n' * 2);
//
//   await collection.scheduler.waitForIdle();
//   await pumpEventQueue();
//   print('\n' * 2);
//   print('[S] Now idle');
//   print('-' * 64);
//
//   print('[S] Disposing...');
//   await collection.dispose();
// }
//
// Future pumpEventQueue([int times = 5000]) {
//   if (times == 0) return Future.value();
//   return Future.delayed(Duration.zero, () => pumpEventQueue(times - 1));
// }
