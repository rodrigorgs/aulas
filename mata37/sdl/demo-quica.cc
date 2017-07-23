#include "ilpgame.h"

#define WINDOW_WIDTH 800
#define WINDOW_HEIGHT 600

#define IMG_WIDTH 16
#define IMG_HEIGHT 16

#define GRAVITY 1;

#define COEF_RESTITUICAO 0.9f

typedef struct {
  float x, y;
  float velx, vely;
  SDL_Surface *img;
} Objeto;

Objeto jogador;

void init() {
  jogador.img = loadImage("hero.png");
  jogador.x = 0;
  jogador.y = WINDOW_HEIGHT / 3;
  jogador.velx = 3;
  jogador.vely = 0;
}

void destroy() {
  SDL_FreeSurface(jogador.img);
}

void processEvent(SDL_Event event) {
  if (isQuitEvent(event)) {
    endGameLoop();
  }
}

void update() {
  // atualiza velocidade
  if (jogador.y > WINDOW_HEIGHT - IMG_HEIGHT && jogador.vely > 0) {
    jogador.vely = jogador.vely * -COEF_RESTITUICAO;
  } else {
    jogador.vely += GRAVITY;
  }

  // atualiza posição
  jogador.x += jogador.velx;
  jogador.y += jogador.vely;

  if (jogador.x > WINDOW_WIDTH) {
    endGameLoop();
  }
}

void draw() {
  drawImage(jogador.img, jogador.x, jogador.y);

  SDL_Delay(1000 / 60);
}

int main(int argc, char *argv[]) {
  initSDL(WINDOW_WIDTH, WINDOW_HEIGHT);

  gameLoop();

  return 0;
}
