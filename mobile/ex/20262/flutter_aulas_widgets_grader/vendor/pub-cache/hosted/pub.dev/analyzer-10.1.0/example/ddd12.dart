// import 'package:analyzer/dart/analysis/results.dart';
// import 'package:analyzer/dart/ast/ast.dart';
// import 'package:analyzer/file_system/overlay_file_system.dart';
// import 'package:analyzer/file_system/physical_file_system.dart';
// import 'package:analyzer/src/dart/analysis/analysis_context_collection.dart';
// import 'package:analyzer/src/dart/analysis/byte_store.dart';
// import 'package:analyzer/src/dart/ast/extensions.dart';
//
// Future<void> main() async {
//   var resourceProvider = OverlayResourceProvider(
//     PhysicalResourceProvider.INSTANCE,
//   );
//
//   var workspacePath = '/workspace';
//   var testPackageRootPath = '$workspacePath/test';
//   var testFilePath = '$testPackageRootPath/lib/test.dart';
//
//   resourceProvider.setOverlay(
//     testFilePath,
//     content: r'''
// class A {
//   (@deprecated int, String) foo() => (0, '');
// }
// ''',
//     modificationStamp: -1,
//   );
//
//   var byteStore = MemoryByteStore();
//
//   var collection = AnalysisContextCollectionImpl(
//     resourceProvider: resourceProvider,
//     includedPaths: [
//       workspacePath,
//     ],
//     byteStore: byteStore,
//   );
//
//   var analysisContext = collection.contextFor(testFilePath);
//   var analysisSession = analysisContext.currentSession;
//
//   var unitResult = await analysisSession.getUnitElement(testFilePath);
//   unitResult as UnitElementResult;
//   var foo = unitResult.element.classes[0].methods[0];
//
//   var libraryResult = await analysisSession.getResolvedLibrary(testFilePath);
//   libraryResult as ResolvedLibraryResult;
//   var fooNodeResult = libraryResult.getElementDeclaration(foo)!;
//   var node = fooNodeResult.node as MethodDeclaration;
//   print(node);
//
//   var returnType = node.returnType as RecordTypeAnnotation;
//   var metadata = returnType.fields[0].metadata;
//   print(metadata[0].element);
// }
