#include "ilpgame.h"

TTF_Font *font;
SDL_Color whiteColor = {255, 255, 255, 255};
string texto = "escreva: ";

void init() {
  font = loadFont("FreeSans.ttf", 40);
}

void destroy() {
  TTF_CloseFont(font);
}

void processEvent(SDL_Event event) {
  SDL_Keycode keycode;

  if (isQuitEvent(event)) {
    endGameLoop();
  } else if (event.type == SDL_KEYDOWN) {
    keycode = event.key.keysym.sym;

    if (keycode >= SDLK_a && keycode <= SDLK_z) {
      char letra = 'a' + (keycode - SDLK_a);
      texto += letra;
    } else if (keycode == SDLK_BACKSPACE && texto.size() > 0) {
      texto.erase(texto.size() - 1);
    }
  }
}

void update() {
}

void draw() {
  if (texto.size() > 0) {
    drawText(texto, font, whiteColor, 10, 30);
  }
}

int main(int argc, char *argv[]) {
  initSDL();
  gameLoop();

  return 0;
}
