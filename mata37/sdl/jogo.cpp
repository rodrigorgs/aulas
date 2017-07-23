#include <SDL.h>
#include <SDL_image.h>
#include <cstdio>
#include <string>
#include <iostream>

using namespace std;

// Variáveis globais
SDL_Window *window = NULL;
SDL_Surface *screenSurface = NULL;
SDL_Surface *image = NULL;

SDL_Surface *imgMenu = NULL;
SDL_Surface *imgCreditos = NULL;

// Adaptado de http://lazyfoo.net/tutorials/SDL/06_extension_libraries_and_loading_other_image_formats/index2.php
SDL_Surface *loadSurface(string path) {
    SDL_Surface* optimizedSurface = NULL;

    SDL_Surface* loadedSurface = IMG_Load(path.c_str());
    if (!loadedSurface) {
      printf( "Unable to load image %s! SDL_image Error: %s\n", path.c_str(), IMG_GetError());
      exit(1);
    }

    optimizedSurface = SDL_ConvertSurface(loadedSurface, screenSurface->format, 0);
    if (!optimizedSurface) {
      printf( "Unable to optimize image %s! SDL Error: %s\n", path.c_str(), SDL_GetError() );
      exit(1);
    }

    SDL_FreeSurface( loadedSurface );

    return optimizedSurface;
}


void initSDL() {
  atexit(SDL_Quit);

  if (SDL_Init(SDL_INIT_EVERYTHING) < 0) {
    cout << "SDL init error: " << SDL_GetError() << endl;
    exit(1);
  }

  window = SDL_CreateWindow("Tutorial", 0, 0, 800, 600, SDL_WINDOW_SHOWN);
  if (!window) {
    cout << "Error creating window: " << SDL_GetError() << endl;
    exit(1);
  }

  int imgFlags = IMG_INIT_PNG;
  if (!(IMG_Init(imgFlags) & imgFlags)) {
    cout << "SDL_image could not initialize! SDL_image Error: " << IMG_GetError() << endl;
    exit(1);
  }

  screenSurface = SDL_GetWindowSurface(window);  
}

void initJogo() {
  // menu
  imgMenu = loadSurface("jogo-menu.jpg");

  // jogo
  imgCreditos = loadSurface("jogo-creditos.jpg");
}

void menuLoop() {
  SDL_Event event;
  bool quit = false;
  int mousex, mousey;

  while (!quit) {
    while (SDL_PollEvent(&event) != 0) {
      if (event.type == SDL_QUIT) {
        quit = true;
      } else if (event.type == SDL_KEYDOWN) {
        switch (event.key.keysym.sym) {
          case SDLK_UP:
            printf("Cima\n");
            break;
          case SDLK_DOWN:
            printf("Baixo\n");
            break;
          case SDLK_ESCAPE:
            printf("Tchau!\n");
            quit = true;
            break;
          default:
            printf("outra\n");
            break;
        }
      }
    }

    SDL_GetGlobalMouseState(&mousex, &mousey);
    if (mousex >= 300 && mousex <= 500 && mousey >= 50 && mousey <= 120) {
      quit = true;
    }

    SDL_BlitSurface(imgMenu, NULL, screenSurface, NULL);
    SDL_UpdateWindowSurface(window);
  }
}

void creditosLoop() {
  SDL_Event event;
  bool quit = false;

  while (!quit) {
    while (SDL_PollEvent(&event) != 0) {
      if (event.type == SDL_QUIT) {
        quit = true;
      } else if (event.type == SDL_KEYDOWN) {
        switch (event.key.keysym.sym) {
          case SDLK_UP:
            printf("Cima\n");
            break;
          case SDLK_DOWN:
            printf("Baixo\n");
            break;
          case SDLK_ESCAPE:
            printf("Tchau!\n");
            quit = true;
            break;
          default:
            printf("outra\n");
            break;
        }
      }
    }

    SDL_BlitSurface(imgCreditos, NULL, screenSurface, NULL);
    SDL_UpdateWindowSurface(window);
  }
}

int main(int argc, char *argv[]) {

  initSDL();

  initJogo();
  menuLoop();
  creditosLoop();

  SDL_FreeSurface(screenSurface);
  SDL_DestroyWindow(window);
  SDL_Quit();
  
  return 0;
}