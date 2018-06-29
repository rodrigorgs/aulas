#define ILPGAME_HEADER_ONLY
#include "ilpgame.h"
#include "tut-arquivo.h"

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