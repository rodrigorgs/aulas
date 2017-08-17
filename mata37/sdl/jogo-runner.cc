#include "ilpgame.h"

#define TELA_LARGURA 640
#define TELA_ALTURA 480

#define QTD_MAX_ARVORES 8

#define ARVORE_LARGURA 60
#define ARVORE_ALTURA 49

#define CARRO_LARGURA 16
#define CARRO_ALTURA 32

SDL_Surface *imgCarro;
SDL_Surface *imgArvore;
SDL_Surface *background;

typedef struct {
  float x, y;
  float largura, altura;
} retangulo;
retangulo jogador;
retangulo arvores[QTD_MAX_ARVORES];
float velocidadeLateral = 1.5f;
float velocidadeVertical = 1.0;
float aceleracaoVertical = 0.05f;

void inicializaArvore(int i) {
  arvores[i].largura = ARVORE_LARGURA;
  arvores[i].altura = ARVORE_ALTURA;
  arvores[i].x = rand() % 300;
  arvores[i].y = -arvores[i].largura - (rand() % 800);
}

void init() {
  srand(time(NULL));

  background = loadImage("background.jpg");
  imgCarro = loadImage("carro.png");
  imgArvore = loadImage("arvore.png");
  
  jogador.x = 100;
  jogador.y = 420;
  jogador.largura = CARRO_LARGURA;
  jogador.altura = CARRO_ALTURA;

  for (int i = 0; i < QTD_MAX_ARVORES; i++) {
    inicializaArvore(i);
  }
}

void destroy() {
  SDL_FreeSurface(background);
  SDL_FreeSurface(imgCarro);
  SDL_FreeSurface(imgArvore);
}

void processEvent(SDL_Event event) {
  SDL_Keycode keycode;

  if (isQuitEvent(event)) {
    endGameLoop();
  } else if (event.type == SDL_KEYDOWN) {
    keycode = event.key.keysym.sym;
    if (keycode == SDLK_SPACE) {
      jogador.y = jogador.y + 30;
    }
  }
}

void atualizaPosicaoJogador() {
  const Uint8 *keyboard = SDL_GetKeyboardState(NULL);
  float velocidade = 0.0f;

  if (keyboard[SDL_SCANCODE_LEFT]) {
    velocidade -= velocidadeLateral;
  }
  if (keyboard[SDL_SCANCODE_RIGHT]) {
    velocidade += velocidadeLateral;
  }

  jogador.x += velocidade;
}

void atualizaArvores() {
  int i;

  for (i = 0; i < QTD_MAX_ARVORES; i++) {
    arvores[i].y += velocidadeVertical;
    if (arvores[i].y > TELA_ALTURA) {
      // criar uma nova árvore!
      
      inicializaArvore(i);

      velocidadeVertical += aceleracaoVertical;
    }
  }

}

void detectaColisao(int i) {
  float ax1 = arvores[i].x,
      ay1 = arvores[i].y,
      ax2 = arvores[i].x + arvores[i].largura,
      ay2 = arvores[i].y + arvores[i].altura;
  float jx1 = jogador.x,
      jy1 = jogador.y,
      jx2 = jogador.x + jogador.largura,
      jy2 = jogador.y + jogador.altura;
  bool colidiu = true;
  if (ax1 > jx2 || ay1 > jy2 || jx1 > ax2 || jy1 > ay2) {
    colidiu = false;
  }

  if (colidiu) {
    endGameLoop();
  }
}

void update() {
  int i;

  atualizaPosicaoJogador();
  atualizaArvores();

  for (i = 0; i < QTD_MAX_ARVORES; i++) {
    detectaColisao(i);
  }
}

void draw() {
  int i;

  drawImage(background, 0, 0);
  drawImage(imgCarro, jogador.x, jogador.y);
  for (i = 0; i < QTD_MAX_ARVORES; i++) {
    drawImage(imgArvore,
      arvores[i].x, arvores[i].y);
  }
}

int main(int argc, char *argv[]) {
  initSDL(TELA_LARGURA, TELA_ALTURA);
  gameLoop();
  return 0;
}

