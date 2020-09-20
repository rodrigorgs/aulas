#!/bin/bash

cat ex1triple.md | sed -e s/triple-page/page/g > ex1page.md
cat ex2triple.md | sed -e s/triple-page/page/g > ex2page.md