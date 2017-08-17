#include "ilpgame.h"

#define MILISEGUNDOS_POR_IMAGEM 200
#define NUM_IMAGENS 4
#define DURACAO_CICLO (MILISEGUNDOS_POR_IMAGEM * NUM_IMAGENS)

SDL_Surface *img[NUM_IMAGENS];

void init() {
  img[0] = loadImage("walking1.png");
  img[1] = loadImage("walking2.png");
  img[2] = loadImage("walking3.png");
  img[3] = loadImage("walking4.png");
}

void destroy() {
  SDL_FreeSurface(img[0]);
  SDL_FreeSurface(img[1]);
  SDL_FreeSurface(img[2]);
  SDL_FreeSurface(img[3]);
}

void processEvent(SDL_Event event) {
  if (isQuitEvent(event))
    endGameLoop();
}

void update() {
}

void draw() {
  unsigned int tempoAtual = SDL_GetTicks(); // em milissegundos
  int indice = (tempoAtual % DURACAO_CICLO) / MILISEGUNDOS_POR_IMAGEM;
  drawImage(img[indice], 0, 0);
}

int main(int argc, char *argv[]) {
  initSDL();
  gameLoop();
  return 0;
}