#include <cmath>
#include "ilpgame.h"

#define WINDOW_WIDTH 800
#define WINDOW_HEIGHT 600

#define TAM_CARRO 20

#define PI 3.14159265358979f

#define ACELERACAO 0.1f
#define FRENAGEM (2 * ACELERACAO)
#define DESACELERACAO (0.3 * ACELERACAO)
#define VELMAX 6.0f
#define VELANGULAR 0.1f

typedef struct {
  float x, y;
  float vel;
  float angle;
} Objeto;

Objeto carro;

Mix_Music *musica;

void init() {
  musica = loadMusic("beat.wav");
  Mix_PlayMusic(musica, -1);

  carro.x = WINDOW_WIDTH / 2;
  carro.y = WINDOW_HEIGHT / 2;
  carro.vel = 0.0f;
  carro.angle = PI / 4;
}

void destroy() {
  Mix_FreeMusic(musica);
}

void processEvent(SDL_Event event) {
  if (isQuitEvent(event)) {
    endGameLoop();
  }
}

void update() {
  const Uint8 *keyboard = SDL_GetKeyboardState(NULL);

  // controle de aceleracao/frenagem
  if (keyboard[SDL_SCANCODE_UP]) {
    carro.vel += ACELERACAO;
  }
  if (keyboard[SDL_SCANCODE_DOWN]) {
    carro.vel -= FRENAGEM;
  }

  // controle de rotacao
  if (keyboard[SDL_SCANCODE_LEFT]) {
    carro.angle -= VELANGULAR;
  }
  if (keyboard[SDL_SCANCODE_RIGHT]) {
    carro.angle += VELANGULAR;
  }

  // aplica atrito
  carro.vel -= DESACELERACAO;

  // limita velocidade
  if (carro.vel > VELMAX) {
    carro.vel = VELMAX;
  } else if (carro.vel < 0) {
    carro.vel = 0;
  }

  // atualiza posicao
  carro.x += carro.vel * cos(carro.angle);
  carro.y += carro.vel * sin(carro.angle);
}

void draw() {
  float x2 = carro.x + cos(carro.angle) * TAM_CARRO;
  float y2 = carro.y + sin(carro.angle) * TAM_CARRO;

  drawLine(carro.x, carro.y, x2, y2, 255, 0, 0);
  drawLine(0.3 * carro.x + 0.7 * x2, 0.3 * carro.y + 0.7 * y2, x2, y2, 0, 255, 0);

  SDL_Delay(1000 / 60);
}

int main(int argc, char *argv[]) {
  initSDL(WINDOW_WIDTH, WINDOW_HEIGHT);

  gameLoop();

  return 0;
}
