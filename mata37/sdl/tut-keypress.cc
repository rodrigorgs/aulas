#include "ilpgame.h"

SDL_Surface *img;
int playerx = 0, playery = 0;
int velocidade = 16;

void init() {
  img = loadImage("hero.png");
}

void destroy() {
  SDL_FreeSurface(img);
}

void processEvent(SDL_Event event) {
  SDL_Keycode keycode;

  if (isQuitEvent(event)) {
    endGameLoop();
  } else if (event.type == SDL_KEYDOWN) {
    keycode = event.key.keysym.sym;
    if (keycode == SDLK_DOWN) playery += velocidade;
    else if (keycode == SDLK_UP) playery -= velocidade;
    else if (keycode == SDLK_LEFT) playerx -= velocidade;
    else if (keycode == SDLK_RIGHT) playerx += velocidade;
  }
}

void update() {
}

void draw() {
  drawImage(img, playerx, playery);
}

int main(int argc, char *argv[]) {
  initSDL();
  gameLoop();

  return 0;
}
