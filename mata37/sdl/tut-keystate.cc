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
  if (isQuitEvent(event)) {
    return false; // encerra o game loop
  };

  return true; // continua o game loop
}

void update() {
  const Uint8 *keyboard = SDL_GetKeyboardState(NULL);

  if (keyboard[SDL_SCANCODE_DOWN]) playery += velocidade;
  if (keyboard[SDL_SCANCODE_UP]) playery -= velocidade;
  if (keyboard[SDL_SCANCODE_LEFT]) playerx -= velocidade;
  if (keyboard[SDL_SCANCODE_RIGHT]) playerx += velocidade;

  cleanScreen();
  drawImage(img, playerx, playery);
  updateScreen();

  SDL_Delay(1000.0 / 60);
}

int main() {
  initSDL();
  gameLoop();

  return 0;
}