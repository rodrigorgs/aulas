#!/bin/bash

em++ `sdl2-config --cflags --libs` -O2 \
  -lSDL2_ttf -lSDL2_image -lSDL2_mixer \
  --preload-file . \
  -s USE_SDL=2 -s USE_SDL_IMAGE=2 -s USE_SDL_TTF=2 \
  -s USE_OGG=1 -s USE_VORBIS=1 \
  -s SDL2_IMAGE_FORMATS='["bmp", "png"]' \
  $@

# -s USE_SDL_MIXER=2
 