// import 'package:analyzer/dart/analysis/results.dart';
// import 'package:analyzer/dart/ast/visitor.dart';
// import 'package:analyzer/dart/element/element.dart';
// import 'package:analyzer/dart/element/type.dart';
// import 'package:analyzer/src/dart/analysis/analysis_context_collection.dart';
// import 'package:analyzer/src/dart/analysis/byte_store.dart';
// import 'package:analyzer/src/dart/ast/ast.dart';
// import 'package:analyzer/src/utilities/extensions/collection.dart';
//
// void main() async {
//   var byteStore = MemoryByteStore();
//
//   var collection = AnalysisContextCollectionImpl(
//     includedPaths: [
//       // '/Users/scheglov/Source/Dart/sdk.git/sdk/pkg/analyzer/lib',
//       // '/Users/scheglov/Source/Dart/sdk.git/sdk/pkg/analyzer',
//       // '/Users/scheglov/Source/flutter/packages/flutter/lib',
//       '/Users/scheglov/Source/flutter',
//     ],
//     byteStore: byteStore,
//   );
//
//   var visitor = _Visitor();
//
//   var timer = Stopwatch()..start();
//   for (var analysisContext in collection.contexts) {
//     print(analysisContext.contextRoot.root.path);
//     var analysisSession = analysisContext.currentSession;
//     for (var path in analysisContext.contextRoot.analyzedFiles()) {
//       if (path.endsWith('.dart')) {
//         print('  $path');
//         var unitResult = await analysisSession.getResolvedUnit(path);
//         unitResult as ResolvedUnitResult;
//         unitResult.unit.accept(visitor);
//       }
//     }
//   }
//   print('[time: ${timer.elapsedMilliseconds} ms]');
//   await collection.dispose();
//
//   print(
//     '[countFunctionExpressionInvocation: ${visitor.countFunctionExpressionInvocation}]',
//   );
//   print('[countMethodInvocation: ${visitor.countMethodInvocation}]');
//   print(
//     '[countInstanceCreationExpression: ${visitor.countInstanceCreationExpression}]',
//   );
//   // print(visitor.countToRefCount.entries
//   //     .sortedBy<num>((entry) => entry.key)
//   //     .join('\n'));
// }
//
// class _Visitor extends RecursiveAstVisitor<void> {
//   var countFunctionExpressionInvocation = 0;
//   var countMethodInvocation = 0;
//   var countInstanceCreationExpression = 0;
//   final Map<int, List<int>> countToRefCount = {};
//
//   Map<FormalParameterElement, int> _formalParameters = {};
//   List<int> _refCount = [];
//
//   @override
//   void visitConstructorDeclaration(covariant ConstructorDeclarationImpl node) {
//     _startFormalParameters(node.parameters);
//     super.visitConstructorDeclaration(node);
//     _endFormalParameters();
//   }
//
//   @override
//   void visitFunctionExpressionInvocation(FunctionExpressionInvocation node) {
//     if (node.function.staticType is InterfaceType) {
//       print('    $node');
//       countFunctionExpressionInvocation++;
//     }
//     super.visitFunctionExpressionInvocation(node);
//   }
//
//   @override
//   void visitInstanceCreationExpression(InstanceCreationExpression node) {
//     countInstanceCreationExpression++;
//     super.visitInstanceCreationExpression(node);
//   }
//
//   @override
//   void visitMethodDeclaration(covariant MethodDeclarationImpl node) {
//     _startFormalParameters(node.parameters);
//     super.visitMethodDeclaration(node);
//     _endFormalParameters();
//   }
//
//   @override
//   void visitMethodInvocation(MethodInvocation node) {
//     countMethodInvocation++;
//     super.visitMethodInvocation(node);
//   }
//
//   @override
//   void visitSimpleIdentifier(SimpleIdentifier node) {
//     var element = node.element;
//     if (element is FormalParameter) {
//       var index = _formalParameters[element];
//       if (index != null) {
//         _refCount[index]++;
//       } else {
//         // print('[noIndex][element: $element]');
//         // for (AstNode? n = node; n != null; n = n.parent) {
//         //   print('  ${n.runtimeType}');
//         // }
//       }
//     }
//
//     super.visitSimpleIdentifier(node);
//   }
//
//   void _endFormalParameters() {
//     _formalParameters = {};
//     _refCount = [];
//   }
//
//   void _startFormalParameters(FormalParameterListImpl? parameterList) {
//     if (parameterList != null) {
//       _formalParameters =
//           parameterList.parameters
//               .map((e) => e.declaredFragment!.element)
//               .asElementToIndexMap;
//
//       var count = _formalParameters.length;
//       _refCount = countToRefCount[count] ??= List.filled(count, 0);
//     }
//   }
// }
