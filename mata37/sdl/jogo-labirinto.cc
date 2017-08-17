#include "ilpgame.h"

using namespace std;

#define MAP_WIDTH 7
#define MAP_HEIGHT 8
#define IMG_WIDTH 16
#define IMG_HEIGHT 16

SDL_Surface *imgbrick;
SDL_Surface *imghero;

int map[MAP_HEIGHT][MAP_WIDTH] = {
  {1, 1, 1, 1, 1, 1, 1},
  {1, 0, 1, 1, 0, 0, 1},
  {1, 0, 1, 0, 0, 0, 1},
  {1, 0, 1, 0, 1, 0, 1},
  {1, 0, 1, 1, 1, 0, 1},
  {1, 0, 0, 0, 0, 0, 1},
  {1, 0, 0, 1, 0, 0, 1},
  {1, 1, 1, 1, 1, 1, 1}
};

typedef struct {
  int x, y;
} Posicao;

Posicao player;


void init() {
  imgbrick = loadImage("brick.png");
  imghero = loadImage("hero.png");

  player.x = 1;
  player.y = 1;
}

void destroy() {
  SDL_FreeSurface(imgbrick);
  SDL_FreeSurface(imghero);
}

void draw() {
  int x, y, telax, telay;

  for (y = 0; y < MAP_HEIGHT; y++) {
    for (x = 0; x < MAP_WIDTH; x++) {
      telax = x * IMG_WIDTH;
      telay = y * IMG_HEIGHT;
      if (map[y][x] == 1) {
        drawImage(imgbrick, telax, telay);
      }
    }
  }

  telax = player.x * IMG_WIDTH;
  telay = player.y * IMG_HEIGHT;
  drawImage(imghero, telax, telay);
}

void processEvent(SDL_Event event) {
  SDL_Keycode keycode;
  Posicao vel = {0, 0};

  if (isQuitEvent(event)) {
    endGameLoop();
  } else if (event.type == SDL_KEYDOWN) {
    keycode = event.key.keysym.sym;

    if (keycode == SDLK_UP) {
      vel.y--;
    }
    else if (keycode == SDLK_DOWN) {
      vel.y++;
    }
    else if (keycode == SDLK_LEFT) {
      vel.x--;
    }
    else if (keycode == SDLK_RIGHT) {
      vel.x++;
    }
  }

  // se a proxima posicao estiver vazia, atualiza posicao
  if (map[player.y + vel.y][player.x + vel.x] == 0) {
    player.x += vel.x;
    player.y += vel.y;
  }
}

void update() {
}

int main(int argc, char *argv[]) {
  initSDL();
  gameLoop();
  return 0;
}
