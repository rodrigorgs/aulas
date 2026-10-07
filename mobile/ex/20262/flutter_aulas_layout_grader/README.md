# Flutter layout assignment grader

This archive grades the five questions at:

https://rodrigorgs.github.io/aulas/mobile/ex/20262/layout

The ezsubmission runner passes a zero-based question index as the container's
first argument and the student's complete Dart source on standard input.

| Index | Submitted file |
| ---: | --- |
| 0 | `lib/tutorial01.dart` |
| 1 | `lib/tutorial02.dart` |
| 2 | `lib/tutorial03.dart` |
| 3 | `lib/tutorial04.dart` |
| 4 | `lib/tutorial05.dart` |

The container runs only the test associated with the selected question. An
exit status of zero means the answer passed; any other status means it failed.
The Flutter image and dependency lockfile are pinned, and the required package
cache is bundled so the runner can build the image with networking disabled.

## Manual smoke test

```sh
podman build -t flutter-aulas-layout-grader .
podman run --rm -i flutter-aulas-layout-grader 0 < answer.dart
```

Upload the generated ZIP file as the assignment's grading archive URL in
ezsubmission. Its `Dockerfile` is at the root, as required by the runner.
