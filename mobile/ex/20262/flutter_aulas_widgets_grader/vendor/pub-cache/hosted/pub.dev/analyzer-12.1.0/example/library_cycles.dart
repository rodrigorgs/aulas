import 'dart:collection';

import 'package:analyzer/src/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/src/dart/analysis/file_state.dart';
import 'package:analyzer/src/dart/analysis/library_graph.dart';

void main() async {
  var collection = AnalysisContextCollectionImpl(
    includedPaths: ['/Users/scheglov/Source/Dart/sdk.git/sdk/pkg/analyzer/lib'],
    withFineDependencies: true,
  );

  var analysisContext = collection.contexts.single;
  var fsState = analysisContext.driver.fsState;

  var libraryCycles = HashSet<LibraryCycle>.identity();
  for (var path in analysisContext.contextRoot.analyzedFiles()) {
    if (path.endsWith('.dart')) {
      var fileState = fsState.getFileForPath(path);
      if (fileState.kind case LibraryFileKind libraryKind) {
        var libraryCycle = libraryKind.libraryCycle;
        if (libraryCycles.add(libraryCycle)) {
          var libraries = libraryCycle.libraries;
          if (libraries.length > 5) {
            print('[${libraries.length}]');
            print('  ${libraryCycle.libraryUris.join('\n  ')}');
          }
        }
      }
    }
  }

  await collection.dispose();
}
