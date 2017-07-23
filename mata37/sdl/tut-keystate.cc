#include "ilpgame.h"

SDL_Surface *img;
int playerx = 0, playery = 0;
int velocidade = 5;

void init() {
  img = loadImage("hero.png");
}

void destroy() {
  SDL_FreeSurface(img);
}

void processEvent(SDL_Event event) {
  if (isQuitEvent(event)) {
    endGameLoop();
  }
}

void update() {
  const Uint8 *keyboard = SDL_GetKeyboardState(NULL);

  if (keyboard[SDL_SCANCODE_DOWN]) playery += velocidade;
  if (keyboard[SDL_SCANCODE_UP]) playery -= velocidade;
  if (keyboard[SDL_SCANCODE_LEFT]) playerx -= velocidade;
  if (keyboard[SDL_SCANCODE_RIGHT]) playerx += velocidade;

  SDL_Delay(1000.0 / 60);
}

void draw() {
  drawImage(img, playerx, playery);
}

int main(int argc, char *argv[]) {
  initSDL();
  gameLoop();

  return 0;
}