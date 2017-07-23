#include "ilpgame.h"

TTF_Font *font;
SDL_Color whiteColor = {255, 255, 255, 255};

void init() {
  font = loadFont("FreeSans.ttf", 40);
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
}

void draw() {
  drawText("Hello, World!", font, whiteColor, 10, 30);
}

int main(int argc, char *argv[]) {
  initSDL();
  gameLoop();

  return 0;
}
