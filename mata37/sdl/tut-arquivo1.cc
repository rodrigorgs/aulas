#include "ilpgame.h"
#include "tut-arquivo.h"

SDL_Surface *img;
int playerx = 0, playery = 0;
int velocidade = 16;

void init() {
  img = loadImage("hero.png");
}

void destroy() {
  SDL_FreeSurface(img);
}

int main(int argc, char *argv[]) {
  initSDL();
  gameLoop();

  return 0;
}
