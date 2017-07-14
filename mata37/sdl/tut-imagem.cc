#include "ilpgame.h"

SDL_Surface *img;

void init() {
  img = loadImage("hero.bmp");
}

void destroy() {
  SDL_FreeSurface(img);
}

bool processEvent(SDL_Event event) {
  if (isQuitEvent(event)) {
    return false; // encerra o game loop
  };

  return true; // continua o game loop
}

void update() {
  cleanScreen();
  drawImage(img, playerx, playery);
  updateScreen();
}

int main() {
  SDL_Event event;
  bool quit = false;
  SDL_Surface *img;

  initSDL();

  img = loadImage("hero.bmp");

  while (!quit) {
    while (SDL_PollEvent(&event) != 0) {
      if (event.type == SDL_QUIT || (event.type == SDL_KEYDOWN && event.key.keysym.sym == SDLK_ESCAPE)) {
        quit = true;
      }
    }

    cleanScreen();
    drawImage(img, 0, 0);
    updateScreen();
  }

  return 0;
}