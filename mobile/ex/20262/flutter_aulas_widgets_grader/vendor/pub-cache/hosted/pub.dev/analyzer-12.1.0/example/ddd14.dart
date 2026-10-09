// import 'dart:io' as io;
//
// import 'package:analyzer/dart/analysis/results.dart';
// import 'package:analyzer/file_system/overlay_file_system.dart';
// import 'package:analyzer/file_system/physical_file_system.dart';
// import 'package:analyzer/src/dart/analysis/analysis_context_collection.dart';
// import 'package:analyzer/src/dart/analysis/byte_store.dart';
// import 'package:analyzer/src/dart/analysis/performance_logger.dart';
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
//   var libPath = '/home/test/lib';
//
//   const fileCount = 10;
//   // const methodCount = 10;
//   // const funRadius = 2;
//
//   var unrelatedPath = '$libPath/unrelated.dart';
//   resourceProvider.setOverlay(unrelatedPath, content: '', modificationStamp: 0);
//
//   {
//     var buffer = StringBuffer();
//     for (var i = 0; i < fileCount; i++) {
//       buffer.writeln("export 'file_$i.dart';");
//     }
//
//     resourceProvider.setOverlay(
//       '$libPath/files.dart',
//       content: buffer.toString(),
//       modificationStamp: 0,
//     );
//   }
//
//   for (var fileIndex = 0; fileIndex < fileCount; fileIndex++) {
//     var filePath = '$libPath/file_$fileIndex.dart';
//
//     var buffer = StringBuffer();
//     buffer.write('''
// import 'files.dart';
// class C$fileIndex {
//   void foo1() {}
//   void foo2() {}
//   void foo3() {}
// ''');
//     //     for (var fieldIndex = 0; fieldIndex < methodCount; fieldIndex++) {
//     //       buffer.write('''
//     //   void foo_$fieldIndex() {}
//     // ''');
//     //     }
//     buffer.write(r'''
// }
// ''');
//
//     if (fileIndex > 0) {
//       buffer.write('''
// void f_$fileIndex(C${fileIndex - 1} c) {
//   c.foo1();
// }
// ''');
//     }
//
//     // var funIndex = 0;
//     //     for (var otherIndex = fileIndex - funRadius;
//     //         otherIndex <= fileIndex + funRadius;
//     //         otherIndex++) {
//     //       var otherIndex2 = (fileCount + otherIndex) % fileCount;
//     //       buffer.writeln('''
//     // void f_${fileIndex}_${funIndex++}(C$otherIndex2 _) {}
//     // ''');
//     //     }
//
//     print('------------ $filePath');
//     print(buffer.toString());
//
//     resourceProvider.setOverlay(
//       filePath,
//       content: buffer.toString(),
//       modificationStamp: 0,
//     );
//   }
//
//   for (var i = 0; i < 1; i++) {
//     var collection = AnalysisContextCollectionImpl(
//       resourceProvider: resourceProvider,
//       includedPaths: [libPath],
//       byteStore: byteStore,
//       performanceLog: PerformanceLog(io.stdout),
//     );
//
//     var analysisContext = collection.contextFor(libPath);
//
//     {
//       var path = '/home/test/lib/file_0.dart';
//
//       var analysisSession = analysisContext.currentSession;
//       await analysisSession.getResolvedLibrary(unrelatedPath);
//       print('\n' * 2);
//
//       print('Analyze #1\n');
//       await analysisSession.getResolvedLibrary(path);
//       print('\n' * 2);
//     }
//
//     {
//       var modifiedPath = '/home/test/lib/file_0.dart';
//       resourceProvider.setOverlay(
//         modifiedPath,
//         content: r'''
// import 'files.dart';
// class C0 {
//   void bar() {}
//   void foo2() {}
//   void foo3() {}
// }
// ''',
//         modificationStamp: 1,
//       );
//
//       analysisContext.changeFile(modifiedPath);
//       await analysisContext.applyPendingFileChanges();
//       var analysisSession = analysisContext.currentSession;
//       print('\n' * 2);
//
//       var path_0 = '/home/test/lib/file_0.dart';
//       var path_1 = '/home/test/lib/file_1.dart';
//
//       print('Analyze #2\n');
//
//       var result_0 = await analysisSession.getResolvedLibrary(path_0);
//       result_0 as ResolvedLibraryResult;
//       print('[errors_0][${result_0.units[0].diagnostics}]');
//       print('\n' * 2);
//
//       // var analysisDriver = analysisContext.driver;
//       // analysisDriver.resetLibraryImportScope(path_1);
//
//       var result_1 = await analysisSession.getResolvedLibrary(path_1);
//       result_1 as ResolvedLibraryResult;
//       print('[errors_1][${result_1.units[0].diagnostics}]');
//       print('\n' * 2);
//     }
//
//     await collection.dispose();
//     print('\n' * 2);
//   }
// }
