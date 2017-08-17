#include <SDL.h>
#include <iostream>

using namespace std;

int main(int argc, char *argv[]) {
	SDL_Window *window = NULL;
	SDL_Surface *screenSurface = NULL;

	if (SDL_Init(SDL_INIT_VIDEO) < 0) {
		cout << "SDL init video error: " << SDL_GetError() << endl;
    SDL_Quit();
	}

  window = SDL_CreateWindow("Tutorial", 0, 0, 320, 480, SDL_WINDOW_SHOWN);
  if (!window) {
    cout << "Error creating window: " << SDL_GetError() << endl;
    SDL_Quit();
  }

  screenSurface = SDL_GetWindowSurface(window);

  SDL_FillRect(screenSurface, NULL, SDL_MapRGB(screenSurface->format, 0xFF, 0xFF, 0xFF));

  SDL_UpdateWindowSurface(window);

  SDL_Delay(2000);

  SDL_FreeSurface(screenSurface);
  SDL_DestroyWindow(window);
  SDL_Quit();
	
	return 0;
}
