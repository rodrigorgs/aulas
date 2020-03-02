#include <iostream>
#include <SDL.h>

using namespace std;

SDL_Window *window = NULL;
SDL_Surface *screenSurface = NULL;

void init() {
	if (SDL_Init(SDL_INIT_VIDEO) < 0) {
		printf("SDL init video error: %s\n", SDL_GetError());
        SDL_Quit();
	}

  window = SDL_CreateWindow("Tutorial", 0, 0, 320, 240, SDL_WINDOW_SHOWN);
  if (!window) {
    printf("Error creating window: %s\n", SDL_GetError());
    SDL_Quit();
  }

  screenSurface = SDL_GetWindowSurface(window);
}

int main(int argc, char *argv[]) {
  init();

  SDL_Surface *image = SDL_LoadBMP("hello.bmp");
  if (image == NULL) {
    cout << "Error loading image: " << SDL_GetError() << endl;
    SDL_Quit();
  }

  SDL_BlitSurface(image, NULL, screenSurface, NULL);
  SDL_UpdateWindowSurface(window);

  SDL_Delay(4000);
  SDL_FreeSurface(image);
  SDL_FreeSurface(screenSurface);
  SDL_DestroyWindow(window);
  SDL_Quit();

	return 0;
}
