#include "ilpgame.h"

TTF_Font *font;
SDL_Color whiteColor = {255, 255, 255, 255};
Uint32 tempoInicial;
string textoContador;

void init() {
  font = loadFont("FreeSans.ttf", 40);
  tempoInicial = SDL_GetTicks();
}

void destroy() {
  TTF_CloseFont(font);
}

void processEvent(SDL_Event event) {
  if (isQuitEvent(event)) {
    endGameLoop();
  }
}

void update() {
	int segundosDecorridos = (SDL_GetTicks() - tempoInicial) / 1000;
  textoContador = tostring(segundosDecorridos);
}

void draw() {
  drawText(textoContador, font, whiteColor, 10, 30);
}

int main(int argc, char *argv[]) {
  initSDL();
  gameLoop();

  return 0;
}
