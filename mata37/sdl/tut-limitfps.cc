#include "ilpgame.h"

SDL_Surface *img;
int x = 16, y = 240;
int vx = 2;


void init() {
  img = loadImage("hero.png");
  limitFPS(30);
}

void destroy() {
  SDL_FreeSurface(img);
}

void processEvent(SDL_Event event) {
  if (isQuitEvent(event))
    endGameLoop();
}

void update() {
  x += vx;
  if (x < 16 || x > 624) {
    vx = -vx;
  }
}

void draw() {
  drawCenteredImage(img, x, y);
}

int main(int argc, char *argv[]) {
  initSDL(640, 480);
  gameLoop();
  return 0;
}