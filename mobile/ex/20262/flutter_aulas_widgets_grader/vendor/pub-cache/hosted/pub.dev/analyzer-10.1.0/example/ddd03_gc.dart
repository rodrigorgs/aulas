import 'dart:io' as io;

void main() {
  var file = io.File('/Users/scheglov/tmp/20230719_gc.txt');
  var lines = file.readAsStringSync().split('\n');
  var regExp = RegExp(r'^\[(.+?),(.+?),(.+?),(.+?),(.+?),');
  var totalDuration = Duration();
  for (var line in lines) {
    var match = regExp.firstMatch(line);
    if (match != null) {
      var singleDurationMsStr = match.group(5);
      if (singleDurationMsStr != null) {
        var milliSeconds = double.parse(singleDurationMsStr);
        var microSeconds = (milliSeconds * 1000).ceil();
        totalDuration += Duration(microseconds: microSeconds);
      }
    }
  }
  print('totalDuration: ${totalDuration.inMilliseconds} ms');
}
