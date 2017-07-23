#include <SDL.h>

int main(int argc, char *argv[]) {
  int intensidade;
  SDL_Window *window;
  SDL_Surface *superficie;

  SDL_Init(SDL_INIT_VIDEO);

  window = SDL_CreateWindow("Tutorial", 100, 100, 320, 480, SDL_WINDOW_SHOWN);
  superficie = SDL_GetWindowSurface(window);

  for (intensidade = 0; intensidade <= 255; intensidade++) {
    SDL_FillRect(superficie, NULL,
      SDL_MapRGB(superficie->format, intensidade, intensidade, intensidade));
    SDL_UpdateWindowSurface(window);
    SDL_Delay(5);
  }
  SDL_Delay(2000);

  SDL_FreeSurface(superficie);
  SDL_DestroyWindow(window);
  SDL_Quit();

  return 0;
}
