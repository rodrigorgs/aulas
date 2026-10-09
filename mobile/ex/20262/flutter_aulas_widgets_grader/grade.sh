#!/bin/sh
set -eu

case "${1:-}" in
  0) question="widget_like" ;;
  1) question="widget_like2" ;;
  2) question="navega" ;;
  3) question="on_off" ;;
  *)
    echo "Unsupported question index: ${1:-<missing>}. Expected 0, 1, 2, or 3." >&2
    exit 2
    ;;
esac

workdir="$(mktemp -d /tmp/flutter-widgets-grader.XXXXXX)"
trap 'rm -rf "$workdir"' EXIT HUP INT TERM

mkdir -p "$workdir/lib" /tmp/flutter-home
cp /opt/grader/pubspec.yaml /opt/grader/pubspec.lock "$workdir/"
cp -R /opt/grader/.dart_tool /opt/grader/lib /opt/grader/test "$workdir/"

# The student's complete Dart answer is supplied on standard input.
cat > "$workdir/lib/$question.dart"

cd "$workdir"
HOME=/tmp/flutter-home flutter test \
  --no-pub \
  --reporter expanded \
  "test/${question}_test.dart"
