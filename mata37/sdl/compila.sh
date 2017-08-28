#!/bin/bash
g++ $@ -std=c++11 `sdl2-config --cflags --libs` -lSDL2_ttf -lSDL2_image -lSDL2_mixer
