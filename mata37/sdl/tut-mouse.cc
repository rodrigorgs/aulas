#include "ilpgame.h"

SDL_Surface *hero;
SDL_Surface *brick;

void init() {
  hero = loadImage("hero.bmp");
  brick = loadImage("brick.bmp");
}

void destroy() {
  SDL_FreeSurface(brick);
  SDL_FreeSurface(hero);
}

bool processEvent(SDL_Event event) {
  if (isQuitEvent(event)) {
    return false; // encerra o game loop
  };

  return true; // continua o game loop
}

void update() {
  SDL_Surface *img;
  int x, y;
  Uint32 mouse = SDL_GetMouseState(&x, &y);

  if (mouse & SDL_BUTTON(SDL_BUTTON_LEFT)) {
    img = brick;
  } else {
    img = hero;
  }

  cleanScreen();
  drawImage(img, x, y);
  updateScreen();
}

int main() {
  initSDL();
  gameLoop();

  return 0;
}