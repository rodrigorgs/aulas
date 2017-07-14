#include "ilpgame.h"

SDL_Surface *img;
int playerx = 0, playery = 0;
int velocidade = 5;

void init() {
  img = loadImage("hero.bmp");
}

void destroy() {
  SDL_FreeSurface(img);
}

bool processEvent(SDL_Event event) {
  SDL_Keycode keycode;

  if (isQuitEvent(event)) {
    return false; // encerra o game loop
  } else if (event.type == SDL_KEYDOWN) {
    keycode = event.key.keysym.sym;

    if (keycode == SDLK_DOWN) playery += velocidade;
    else if (keycode == SDLK_UP) playery -= velocidade;
    else if (keycode == SDLK_LEFT) playerx -= velocidade;
    else if (keycode == SDLK_RIGHT) playerx += velocidade;
  }

  return true; // continua o game loop
}

void update() {
  cleanScreen();

  drawImage(img, playerx, playery);

  updateScreen();
}

int main() {
  initSDL();
  gameLoop();

  return 0;
}