#!/bin/bash
sourcefile=$1
shift

g++ $sourcefile `sdl2-config --cflags --libs` -lSDL2_ttf -lSDL2_image $@
