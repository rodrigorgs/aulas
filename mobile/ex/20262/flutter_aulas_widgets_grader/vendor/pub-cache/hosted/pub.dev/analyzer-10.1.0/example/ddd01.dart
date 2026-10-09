import 'package:analyzer/src/dart/analysis/analysis_context_collection.dart';

void main() async {
  var collection = AnalysisContextCollectionImpl(
    includedPaths: ['/Users/scheglov/dart/test'],
    withFineDependencies: true,
  );

  for (var analysisContext in collection.contexts) {
    // print(analysisContext.contextRoot.root.path);
    var analysisSession = analysisContext.currentSession;
    for (var path in analysisContext.contextRoot.analyzedFiles()) {
      if (path.endsWith('.dart')) {
        print('  $path');
        await analysisSession.getResolvedUnit(path);
      }
    }
  }
}
