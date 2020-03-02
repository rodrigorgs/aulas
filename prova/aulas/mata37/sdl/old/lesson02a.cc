#include <SDL.h>

SDL_Window *window = NULL;
SDL_Surface *screenSurface = NULL;

void init() {
  if (SDL_Init(SDL_INIT_VIDEO) < 0) {
    printf("SDL init video error: %s\n", SDL_GetError());
    SDL_Quit();
  }

  window = SDL_CreateWindow("Tutorial", 0, 0, 640, 480, SDL_WINDOW_SHOWN);
  if (!window) {
    printf("Error creating window: %s\n", SDL_GetError());
    SDL_Quit();
  }

  screenSurface = SDL_GetWindowSurface(window);
}

int main(int argc, char *argv[]) {
  SDL_Rect pos;
  int i;

  init();
  
  SDL_Surface *image = SDL_LoadBMP("hello.bmp");
  if (!image) {
    printf("Error loading image: %s\n", SDL_GetError());
    SDL_Quit();
  }

  pos.x = 0;
  pos.y = 160;
  for (i = 0; i < 320; i++) {
    pos.x = i;
    SDL_FillRect(screenSurface, NULL, SDL_MapRGB(screenSurface->format, 0, 0, 0));
    SDL_BlitSurface(image, NULL, screenSurface, &pos);
    SDL_UpdateWindowSurface(window);
    SDL_Delay(10);
  }

  SDL_FreeSurface(image);
  SDL_FreeSurface(screenSurface);
  SDL_DestroyWindow(window);
  SDL_Quit();
  
  return 0;
}
