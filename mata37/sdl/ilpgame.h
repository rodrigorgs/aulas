#include <SDL.h>
#include <SDL_image.h>
#include <SDL_ttf.h>
#include <iostream>
#include <sstream>

// https://stackoverflow.com/questions/5590381/easiest-way-to-convert-int-to-string-in-c
#define tostring(x) static_cast<std::ostringstream&>( \
        (std::ostringstream() << std::dec << x)).str()

using namespace std;

SDL_Window *window = NULL;
SDL_Surface *screen = NULL;

////////////////////////////////////////////
// Inicializacao
////////////////////////////////////////////

void destroy();

void quit() {
  destroy();
  
  if (TTF_WasInit()) {
    TTF_Quit();
  }

  if (screen) {
    SDL_FreeSurface(screen);
    screen = NULL;
  }
  if (window) {
    SDL_DestroyWindow(window);
    window = NULL;
  }

  SDL_Quit();
}

void initSDL_ttf() {
  if (TTF_Init() == -1) {
    cerr << "TTF_Init error: " << TTF_GetError() << endl;
    exit(1);
  }
}

void initSDL_image() {
  int imgFlags = IMG_INIT_PNG;
  if (!(IMG_Init(imgFlags) & imgFlags)) {
    cerr << "SDL_image could not initialize! SDL_image Error: " << IMG_GetError() << endl;
    exit(1);
  }
}

void initSDL_base(int width, int height) {
  if (SDL_Init(SDL_INIT_EVERYTHING) < 0) {
    cerr << "SDL init error: " << SDL_GetError() << endl;
    exit(1);
  }

  window = SDL_CreateWindow("Tutorial", 0, 0, width, height, SDL_WINDOW_SHOWN);
  if (!window) {
    cerr << "Error creating window: " << SDL_GetError() << endl;
    exit(1);
  }

  screen = SDL_GetWindowSurface(window);  
}

void initSDL(int width, int height) {
  atexit(quit);
  initSDL_base(width, height);
  initSDL_image();
  initSDL_ttf();
}

void initSDL() {
  initSDL(800, 600);
}


/////////////////////////////////////////
// Carga
/////////////////////////////////////////

SDL_Surface *loadBMP(string filename) {
  SDL_Surface *image = SDL_LoadBMP(filename.c_str());
  if (!image) {
    cerr << "Error loading image: %s" << SDL_GetError() << endl;
    exit(1);
  }
  return image;
}

// Adaptado de http://lazyfoo.net/tutorials/SDL/06_extension_libraries_and_loading_other_image_formats/index2.php
SDL_Surface *loadImage(string path) {
  SDL_Surface* optimizedSurface = NULL;

  SDL_Surface* loadedSurface = IMG_Load(path.c_str());
  if (!loadedSurface) {
    printf( "Unable to load image %s! SDL_image Error: %s\n", path.c_str(), IMG_GetError());
    exit(1);
  }

  optimizedSurface = SDL_ConvertSurface(loadedSurface, screen->format, 0);
  if (!optimizedSurface) {
    printf( "Unable to optimize image %s! SDL Error: %s\n", path.c_str(), SDL_GetError() );
    exit(1);
  }

  SDL_FreeSurface( loadedSurface );

  return optimizedSurface;
}

TTF_Font *loadFont(string filename, int size) {
  TTF_Font *font = TTF_OpenFont(filename.c_str(), size);
  if (font == NULL) {
    cerr << "TTF_OpenFont() Failed: " << TTF_GetError() << endl;
    exit(1);
  }
  return font;
}

//////////////////////////////////////
// Desenho
//////////////////////////////////////

void cleanScreen() {
  SDL_FillRect(screen, NULL, SDL_MapRGB(screen->format, 0x00, 0x00, 0x00));
}

void cleanScreen(int r, int g, int b) {
  SDL_FillRect(screen, NULL, SDL_MapRGB(screen->format, r, g, b));
}

void updateScreen() {
  SDL_UpdateWindowSurface(window);
}

void drawText(string texto, TTF_Font *font, SDL_Color cor, int x, int y) {
  SDL_Rect pos = {x, y, 0, 0};
  SDL_Surface *text = TTF_RenderText_Solid(font, texto.c_str(), cor);
  if (!text) {
    cerr << "Erro rendertext" << endl;
    exit(1);
  }
  SDL_BlitSurface(text, NULL, screen, &pos);
}

void drawImage(SDL_Surface *surface, int x, int y) {
  SDL_Rect dest = {x, y, 0, 0};
  SDL_BlitSurface(surface, NULL, screen, &dest);
}

//////////////////////////////////////
// Game loop
//////////////////////////////////////

void init();
bool processEvent(SDL_Event event);
void update();

bool isQuitEvent(SDL_Event event) {
  return event.type == SDL_QUIT || (event.type == SDL_KEYDOWN && event.key.keysym.sym == SDLK_ESCAPE);
}

void gameLoop() {
  SDL_Event event;
  bool gameLoopQuit = false;

  init();

  while (!gameLoopQuit) {
    while (SDL_PollEvent(&event) != 0) {
      gameLoopQuit = !processEvent(event);
    }

    update();
  }
}

