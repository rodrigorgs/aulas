// import 'package:analyzer/dart/analysis/results.dart';
// import 'package:analyzer/file_system/physical_file_system.dart';
// import 'package:analyzer/src/dart/analysis/analysis_context_collection.dart';
// import 'package:analyzer/src/dart/analysis/byte_store.dart';
//
// void main() async {
//   {
//     var byteStore = MemoryByteStore();
//
//     var collection = AnalysisContextCollectionImpl(
//       resourceProvider: PhysicalResourceProvider.INSTANCE,
//       includedPaths: ['/Users/scheglov/dart/2024-04-30/disposable_macro'],
//       byteStore: byteStore,
//     );
//
//     var timer = Stopwatch()..start();
//     for (var analysisContext in collection.contexts) {
//       print(analysisContext.contextRoot.root.path);
//       var analysisSession = analysisContext.currentSession;
//       for (var path in analysisContext.contextRoot.analyzedFiles()) {
//         if (path.endsWith('.dart')) {
//           var unitResult = await analysisSession.getResolvedUnit(path);
//           unitResult as ResolvedUnitResult;
//           print('    ${unitResult.path}');
//           var ep = '\n        ';
//           print('      errors:$ep${unitResult.diagnostics.join(ep)}');
//           // print('---');
//           // print(unitResult.content);
//           // print('---');
//         }
//       }
//     }
//     print('[time: ${timer.elapsedMilliseconds} ms]');
//
//     await collection.dispose();
//   }
// }
