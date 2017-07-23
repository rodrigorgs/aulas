#include "ilpgame.h"

SDL_Surface *hero;
SDL_Surface *brick;
SDL_Surface *img;
int x, y;

void init() {
  hero = loadImage("hero.png");
  brick = loadImage("brick.png");
}

void destroy() {
  SDL_FreeSurface(brick);
  SDL_FreeSurface(hero);
}

void processEvent(SDL_Event event) {
  if (isQuitEvent(event)) {
    endGameLoop();
  }
}

void update() {
  Uint32 mouse = SDL_GetMouseState(&x, &y);

  if (mouse & SDL_BUTTON(SDL_BUTTON_LEFT)) {
    img = brick;
  } else {
    img = hero;
  }
}

void draw() {
  drawCenteredImage(img, x, y);
}

int main(int argc, char *argv[]) {
  initSDL();
  gameLoop();

  return 0;
}
