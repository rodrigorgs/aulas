import 'dart:io' as io;

void main() async {
  var timer = Stopwatch()..start();

  var pathList = io.File('files.txt').readAsStringSync().split('\n');
  var contentLength = 0;

  if (1 == 0) {
    await Future.wait(
      pathList.map((path) async {
        // return io.File(path).readAsString().then((content) {
        //   contentLength += content.length;
        // });
        try {
          var content = await io.File(path).readAsString();
          contentLength += content.length;
        } catch (_) {}
        // return io.File(path).readAsString().onError(
        //   (error, stackTrace) {
        //     print('error');
        //     return '';
        //   },
        // );
      }),
    );
  } else {
    for (var path in pathList) {
      try {
        contentLength += io.File(path).readAsStringSync().length;
      } catch (_) {}
    }
  }

  timer.stop();
  print('Time: ${timer.elapsedMilliseconds} ms');
  print('Content: $contentLength bytes');
}
