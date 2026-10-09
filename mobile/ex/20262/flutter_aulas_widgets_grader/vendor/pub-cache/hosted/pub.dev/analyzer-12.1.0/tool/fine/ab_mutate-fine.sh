#!/bin/bash

dart ab_mutate.dart \
    --repo=/Users/scheglov/Source/Dart/sdk.git/sdk/pkg/analyzer \
    --out=/Users/scheglov/tmp/2025/2025-08-20 \
    --mutate-dirs=/Users/scheglov/Source/Dart/sdk.git/sdk/pkg/analyzer/lib/src/fine \
    --diagnostic-dirs=/Users/scheglov/Source/Dart/sdk.git/sdk/pkg/analyzer/lib,/Users/scheglov/Source/Dart/sdk.git/sdk/pkg/analyzer/test \
    --chains 5 \
    --max-steps-per-chain 10 \
    --kinds rename_local_variable \
    --kinds remove_last_formal_parameter \
    --kinds toggle_return_type_nullability \
    --per-kind 5
