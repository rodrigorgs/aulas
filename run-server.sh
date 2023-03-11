#!/bin/bash

bundle exec jekyll s -i
#docker run --rm \
#  --volume="$PWD:/srv/jekyll" -p 4000:4000 \
#  -it jekyll/jekyll:3.8 \
#  jekyll s -i
