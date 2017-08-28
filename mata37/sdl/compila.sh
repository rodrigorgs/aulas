#!/bin/bash
g++ $@ `sdl2-config --cflags --libs` -lSDL2_ttf -lSDL2_image -lSDL2_mixer
