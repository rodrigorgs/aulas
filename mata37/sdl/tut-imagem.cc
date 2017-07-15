#include "ilpgame.h"

SDL_Surface *img;

void init() {
  img = loadImage("hero.bmp");
}

void destroy() {
  SDL_FreeSurface(img);
}

void processEvent(SDL_Event event) {
  if (isQuitEvent(event))
    endGameLoop();
}

void update() {
}

void draw() {
  drawImage(img, 0, 0);
}

int main() {
  initSDL();
  gameLoop();
  return 0;
}