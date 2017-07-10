#!/bin/bash
g++ jogo.cpp -o jogo `sdl2-config --cflags --libs` -lSDL2_image
