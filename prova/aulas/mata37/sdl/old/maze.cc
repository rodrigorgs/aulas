#include <SDL.h>
#include <iostream>

using namespace std;

#define MAP_WIDTH 7
#define MAP_HEIGHT 7
#define TILE_WIDTH 16
#define TILE_HEIGHT 16

SDL_Window *window = NULL;
SDL_Surface *screen = NULL;

SDL_Surface *imgbrick = NULL;
SDL_Surface *imghero = NULL;

int map[MAP_WIDTH][MAP_HEIGHT] = {
  {1, 1, 1, 1, 1, 1, 1},
  {1, 0, 1, 1, 0, 0, 1},
  {1, 0, 1, 0, 0, 0, 1},
  {1, 0, 1, 0, 1, 0, 1},
  {1, 0, 1, 1, 1, 0, 1},
  {1, 0, 0, 0, 0, 0, 1},
  {1, 1, 1, 1, 1, 1, 1}
};

SDL_Rect playerpos;

SDL_Surface *loadImage(char *filename) {
  SDL_Surface *image = SDL_LoadBMP(filename);
  if (!image) {
    cout << "Error loading image: %s" << SDL_GetError() << endl;
    exit(1);
  }
  return image;
}

void init() {
	if (SDL_Init(SDL_INIT_VIDEO) < 0) {
		cout << "SDL init video error: %s" << SDL_GetError() << endl;
    exit(1);
	}

  window = SDL_CreateWindow("Tutorial", 0, 0, 320, 240, SDL_WINDOW_SHOWN);
  if (!window) {
    cout << "Error creating window: %s" << SDL_GetError() << endl;
    exit(1);
  }

  screen = SDL_GetWindowSurface(window);
}

void drawMap(int m[MAP_WIDTH][MAP_HEIGHT]) {
  int x, y;
  SDL_Rect dest;

  for (y = 0; y < MAP_HEIGHT; y++) {
    for (x = 0; x < MAP_WIDTH; x++) {
      if (m[y][x] == 1) {
        dest.x = x * TILE_WIDTH;
        dest.y = y * TILE_HEIGHT;
        SDL_BlitSurface(imgbrick, NULL, screen, &dest);
      }
    }
  }

  dest.x = playerpos.x * TILE_WIDTH;
  dest.y = playerpos.y * TILE_HEIGHT;
  SDL_BlitSurface(imghero, NULL, screen, &dest);
}

void movePlayer(int m[MAP_WIDTH][MAP_HEIGHT], SDL_Keycode key) {
  SDL_Rect vel;
  vel.x = 0;
  vel.y = 0;

  switch (key) {
    case SDLK_UP:
      vel.y--;
      break;
    case SDLK_DOWN:
      vel.y++;
      break;
    case SDLK_LEFT:
      vel.x--;
      break;
    case SDLK_RIGHT:
      vel.x++;
      break;
  }

  if (m[playerpos.y + vel.y][playerpos.x + vel.x] == 0) {
    playerpos.x += vel.x;
    playerpos.y += vel.y;
  }
}

int main(int argc, char *argv[]) {
  SDL_Event event;
  bool quit = false;

  init();
  imgbrick = loadImage((char *)"brick.bmp");
  imghero = loadImage((char *)"hero.bmp");
  playerpos.x = 1;
  playerpos.y = 1;

  while (!quit) {
    while (SDL_PollEvent(&event) != 0) {
      if (event.type == SDL_QUIT) {
        quit = true;
      } else if (event.type == SDL_KEYDOWN) {
        movePlayer(map, event.key.keysym.sym);

        if (event.key.keysym.sym == SDLK_ESCAPE) {
          quit = true;
        }
      }
    }

    SDL_FillRect(screen, NULL, SDL_MapRGB(screen->format, 0x00, 0x00, 0x00));
    drawMap(map);
    SDL_UpdateWindowSurface(window);
  }

  SDL_FreeSurface(screen);
  SDL_DestroyWindow(window);
  SDL_Quit();
	
	return 0;
}
