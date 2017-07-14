#include "ilpgame.h"

TTF_Font *font;
SDL_Color whiteColor = {255, 255, 255, 255};

void init() {
  font = loadFont("FreeSans.ttf", 40);
}

void destroy() {
  TTF_CloseFont(font);
}

bool processEvent(SDL_Event event) {
  return !isQuitEvent(event);
}

void update() {
  cleanScreen();
  drawText("Hello, World!", font, whiteColor, 10, 30);
  updateScreen();
}

int main() {
  initSDL();
  gameLoop();

  return 0;
}
