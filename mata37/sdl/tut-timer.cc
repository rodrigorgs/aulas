#include "ilpgame.h"

TTF_Font *font;
SDL_Color whiteColor = {255, 255, 255, 255};
Uint32 tempoInicial;

void init() {
  font = loadFont("FreeSans.ttf", 40);
  tempoInicial = SDL_GetTicks();
}

void destroy() {
  TTF_CloseFont(font);
}

bool processEvent(SDL_Event event) {
  return !isQuitEvent(event);
}

void update() {
	int segundosDecorridos = (SDL_GetTicks() - tempoInicial) / 1000;

  cleanScreen();
  drawText(tostring(segundosDecorridos), font, whiteColor, 10, 30);
  updateScreen();
}

int main() {
  initSDL();
  gameLoop();

  return 0;
}
