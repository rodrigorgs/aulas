FROM ghcr.io/cirruslabs/flutter@sha256:46691e311715845de03a3ba4753a475476936805b29431b1f00f1816981033f8

ENV FLUTTER_SUPPRESS_ANALYTICS=true \
    FLUTTER_ALREADY_LOCKED=true \
    PUB_CACHE=/opt/pub-cache

WORKDIR /opt/grader

COPY pubspec.yaml pubspec.lock ./
COPY vendor/pub-cache /opt/pub-cache
COPY lib ./lib
COPY test ./test

# Both the application and Flutter tool dependencies are bundled so the
# ezsubmission runner can build with networking disabled.
RUN cd /sdks/flutter/packages/flutter_tools \
    && /sdks/flutter/bin/cache/dart-sdk/bin/dart pub get --offline \
    && cd /opt/grader \
    && flutter pub get --offline \
    && git config --system --add safe.directory '*' \
    && chmod -R a+rX /opt/grader \
    && chmod -R a+rwX /sdks/flutter/bin/cache

COPY grade.sh /usr/local/bin/grade-submission
RUN chmod 0555 /usr/local/bin/grade-submission

ENTRYPOINT ["/usr/local/bin/grade-submission"]
