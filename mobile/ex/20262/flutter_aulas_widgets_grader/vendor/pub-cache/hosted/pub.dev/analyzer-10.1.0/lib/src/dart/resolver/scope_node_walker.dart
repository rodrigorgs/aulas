// // Copyright (c) 2026, the Dart project authors. Please see the AUTHORS file
// // for details. All rights reserved. Use of this source code is governed by a
// // BSD-style license that can be found in the LICENSE file.
//
// import 'package:_fe_analyzer_shared/src/base/analyzer_public_api.dart';
// import 'package:_fe_analyzer_shared/src/scanner/string_canonicalizer.dart';
// import 'package:analyzer/dart/element/element.dart';
// import 'package:analyzer/dart/element/scope.dart';
// import 'package:analyzer/src/dart/ast/ast.dart';
// import 'package:analyzer/src/dart/element/element.dart';
// import 'package:analyzer/src/fine/requirements.dart';
// import 'package:analyzer/src/generated/engine.dart';
//
// mixin ScopeNodeWalkerMixin {
//   void walkMixinDeclaration({
//     required MixinDeclarationImpl declaration,
//     required void Function(CommentImpl node) visitDocumentationComment,
//     required void Function(List<AnnotationImpl> nodeList) visitMetadata,
//     required void Function(TypeParameterListImpl node) visitTypeParameters,
//     required void Function(MixinOnClauseImpl node) visitOnClause,
//     required void Function(ImplementsClauseImpl node) visitImplementsClause,
//     required void Function(BlockClassBodyImpl node) visitBody,
//   }) {}
//
//   void _withScope(Scope newScope, void Function() f) {
//     var previousScope = scope;
//     try {
//       scope = newScope;
//       f();
//     } finally {
//       scope = previousScope;
//     }
//   }
//
//   void _withTypeParameterScope(
//       List<TypeParameterElement> elements,
//       void Function() f,
//       ) {
//     _withScope(
//       TypeParameterScope(
//         scope,
//         elements,
//         featureSet: libraryFragment.library.featureSet,
//       ),
//       f,
//     );
//   }
// }
