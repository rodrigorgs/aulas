#include <SDL.h>
#include <SDL_ttf.h>
#include <iostream>
#include <cmath>

using namespace std;

// constantes
#define TELA_LARGURA 800
#define TELA_ALTURA 600

#define IMAGEM_MEIA_LARGURA 8
#define IMAGEM_MEIA_ALTURA 8

// variáveis
SDL_Window *window = NULL;
SDL_Surface *screen = NULL;

SDL_Surface *imgbrick = NULL;
SDL_Surface *imghero = NULL;

SDL_Rect item;
int pontuacao = 0;

// variáveis para escrita de texto
TTF_Font *font;
SDL_Color corTexto = {255, 255, 255};

//////////////////////////////////////////////

SDL_Surface *loadImage(char *filename) {
  SDL_Surface *image = SDL_LoadBMP(filename);
  if (!image) {
    cout << "Error loading image: %s" << SDL_GetError() << endl;
    exit(1);
  }
  return image;
}

void initSDL_ttf() {
  if (TTF_Init() == -1) {
    cout << "Erro TTF_Init: " << TTF_GetError() << endl;
    exit(1);
  }
  font = TTF_OpenFont("FreeSans.ttf", 24);
  if (font == NULL) {
    cerr << "TTF_OpenFont() Failed: " << TTF_GetError() << endl;
    exit(1);
  }
}

void initSDL() {
	if (SDL_Init(SDL_INIT_EVERYTHING) < 0) {
		cout << "SDL init video error: %s" << SDL_GetError() << endl;
    exit(1);
	}

  window = SDL_CreateWindow("Tutorial", 0, 0, TELA_LARGURA, TELA_ALTURA, SDL_WINDOW_SHOWN);
  if (!window) {
    cout << "Error creating window: %s" << SDL_GetError() << endl;
    exit(1);
  }

  screen = SDL_GetWindowSurface(window);
}

void moveItem() {
  item.x = rand() % TELA_LARGURA;
  item.y = rand() % TELA_ALTURA;
}

void initGame() {
  imgbrick = loadImage((char *)"brick.bmp");
  imghero = loadImage((char *)"hero.bmp");
  // corTexto = {255, 255, 255};

  moveItem();
}

void escreveTexto(string texto, SDL_Color cor, int x, int y) {
  SDL_Rect pos = {x, y, 0, 0};
  SDL_Surface *text = TTF_RenderText_Solid(font, texto.c_str(), cor);
  if (!text) {
    cout << "Erro rendertext" << endl;
    exit(1);
  }
  SDL_BlitSurface(text, NULL, screen, &pos);
}

void desenha() {
  int mousex, mousey;
  SDL_Rect mouseRect;

  SDL_GetMouseState(&mousex, &mousey);
  mouseRect.x = mousex - IMAGEM_MEIA_LARGURA;
  mouseRect.y = mousey - IMAGEM_MEIA_ALTURA;

  // limpa a tela
  SDL_FillRect(screen, NULL, SDL_MapRGB(screen->format, 0x00, 0x00, 0x00));
  // desenha
  SDL_BlitSurface(imghero, NULL, screen, &mouseRect);
  SDL_BlitSurface(imgbrick, NULL, screen, &item);
  char s[255];
  sprintf(s, "Pontuacao: %d", pontuacao);
  escreveTexto(s, corTexto, 0, 0);
  // atualiza janela
  SDL_UpdateWindowSurface(window);
}

float distancia(int x1, int y1, int x2, int y2) {
  int dx = x2 - x1;
  int dy = y2 - y1;
  return sqrt(dx * dx + dy * dy);
}

void atualiza() {
  int mousex, mousey;
  int centroItemX, centroItemY;

  SDL_GetMouseState(&mousex, &mousey);
  centroItemX = item.x + IMAGEM_MEIA_LARGURA;
  centroItemY = item.y + IMAGEM_MEIA_ALTURA;

  if (distancia(mousex, mousey, centroItemX, centroItemY) < IMAGEM_MEIA_ALTURA * 2) {
    // pegou!
    pontuacao++;
    cout << "Pontuacao: " << pontuacao << endl;
    moveItem();
  }
}

int main(int argc, char *argv[]) {
  SDL_Event event;
  bool quit = false;

  initSDL();
  initSDL_ttf();
  initGame();

  while (!quit) {
    while (SDL_PollEvent(&event) != 0) {
      if (event.type == SDL_QUIT || (event.type == SDL_KEYDOWN && event.key.keysym.sym == SDLK_ESCAPE)) {
        quit = true;
      }
    }
    atualiza();
    desenha();
  }

  SDL_FreeSurface(screen);
  SDL_DestroyWindow(window);
  SDL_Quit();
	
	return 0;
}
