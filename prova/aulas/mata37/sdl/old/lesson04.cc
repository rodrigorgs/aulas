#include <SDL.h>

SDL_Window *window = NULL;
SDL_Surface *screenSurface = NULL;
SDL_Surface *image = NULL;

void init() {
	if (SDL_Init(SDL_INIT_VIDEO) < 0) {
		printf("SDL init video error: %s\n", SDL_GetError());
    exit(1);
	}

  window = SDL_CreateWindow("Tutorial", 0, 0, 320, 240, SDL_WINDOW_SHOWN);
  if (!window) {
    printf("Error creating window: %s\n", SDL_GetError());
  }

  screenSurface = SDL_GetWindowSurface(window);
  
  image = SDL_LoadBMP("hello.bmp");
  if (!image) {
    printf("Error loading image: %s\n", SDL_GetError());
    exit(0);
  }
}

int main(int argc, char *argv[]) {
  SDL_Event event;
  bool quit = false;

  init();

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

    SDL_BlitSurface(image, NULL, screenSurface, NULL);
    SDL_UpdateWindowSurface(window);
  }

  SDL_FreeSurface(screenSurface);
  SDL_DestroyWindow(window);
  SDL_Quit();
	
	return 0;
}
