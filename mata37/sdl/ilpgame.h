#include <SDL.h>
#include <SDL_image.h>
#include <SDL_ttf.h>
#include <SDL_mixer.h>
#include <iostream>
#include <sstream>
#include <cstdlib> // exit

#ifdef __EMSCRIPTEN__
#include <emscripten.h>
#endif

// https://stackoverflow.com/questions/5590381/easiest-way-to-convert-int-to-string-in-c
#define tostring(x) static_cast<std::ostringstream&>( \
        (std::ostringstream() << std::dec << x)).str()

using namespace std;

SDL_Window *window = NULL;
SDL_Surface *screen = NULL;
SDL_Renderer *renderer = NULL;

bool gameLoopQuit = false;

////////////////////////////////////////////
// Funções definidas pelo usuário
////////////////////////////////////////////

void init();
void destroy();
void processEvent(SDL_Event event);
void update();
void draw();

////////////////////////////////////////////
// Inicializacao
////////////////////////////////////////////

void quit() {
  destroy();

  if (TTF_WasInit()) {
    TTF_Quit();
  }
  while (Mix_Init(0)) {
    Mix_Quit();
  }
  Mix_CloseAudio();

  if (screen) {
    SDL_FreeSurface(screen);
    screen = NULL;
  }
  if (renderer) {
    SDL_DestroyRenderer(renderer);
    renderer = NULL;
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

void initSDL_mixer() {
  int flags = 0;
  int initted = Mix_Init(flags);
  if ((initted & flags) != flags) {
    cerr << "SDL mixer init error: " << Mix_GetError() << endl;
    exit(1);
  }
  if (Mix_OpenAudio(44100, MIX_DEFAULT_FORMAT, 2, 1024) == -1) {
    cerr << "SDL init audio error: " << SDL_GetError() << endl;
    exit(1);
  }
}

void initSDL_base(int width, int height) {
  Uint32 flags = SDL_INIT_TIMER | SDL_INIT_AUDIO | SDL_INIT_VIDEO | SDL_INIT_JOYSTICK | SDL_INIT_GAMECONTROLLER | SDL_INIT_EVENTS;

  if (SDL_Init(flags) < 0) {
    cerr << "SDL init error: " << SDL_GetError() << endl;
    exit(1);
  }

  window = SDL_CreateWindow("Tutorial", SDL_WINDOWPOS_CENTERED, SDL_WINDOWPOS_CENTERED, width, height, 0);
  if (!window) {
    cerr << "Error creating window: " << SDL_GetError() << endl;
    exit(1);
  }

  renderer = SDL_CreateRenderer(window, -1, SDL_RENDERER_SOFTWARE);
  if (!renderer) {
    cerr << "Error creating renderer: " << SDL_GetError() << endl;
    exit(1);
  }

  screen = SDL_GetWindowSurface(window);
}

void initSDL(int width, int height) {
  atexit(quit);
  initSDL_base(width, height);
  initSDL_image();
  initSDL_ttf();
  initSDL_mixer();
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
SDL_Surface *loadImage(string filename) {
  SDL_Surface* optimizedSurface = NULL;

  SDL_Surface* loadedSurface = IMG_Load(filename.c_str());
  if (!loadedSurface) {
    cerr << "Unable to load image " << filename << endl;
    cerr << "SDL_image Error: " << IMG_GetError() << endl;
    exit(1);
  }

  optimizedSurface = SDL_ConvertSurface(loadedSurface, screen->format, 0);
  if (!optimizedSurface) {
    cerr << "Unable to optimize image " << filename << endl;
    cerr << "SDL Error: " << SDL_GetError() << endl;
    exit(1);
  }

  SDL_FreeSurface(loadedSurface);

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

void cleanScreen(int r, int g, int b) {
  SDL_FillRect(screen, NULL, SDL_MapRGB(screen->format, r, g, b));
}

void cleanScreen() {
  cleanScreen(0, 0, 0);
}

void updateScreen() {
  SDL_UpdateWindowSurface(window);
}

void drawText(string text, TTF_Font *font, SDL_Color color, int x, int y) {
  SDL_Rect pos = {x, y, 0, 0};
  SDL_Surface *textSurface = TTF_RenderText_Solid(font, text.c_str(), color);
  if (!textSurface) {
    cerr << "Erro: drawText" << endl;
    exit(1);
  }
  SDL_BlitSurface(textSurface, NULL, screen, &pos);
}

void drawImage(SDL_Surface *surface, int x, int y) {
  if (surface) {
    SDL_Rect dest = {x, y, 0, 0};
    SDL_BlitSurface(surface, NULL, screen, &dest);
  } else {
    cerr << "Erro: drawImage com surface == NULL" << endl;
  }
}

void drawCenteredImage(SDL_Surface *surface, int x, int y) {
  drawImage(surface, x - surface->w / 2, y - surface->h / 2);
}

//////////////////////////////////////
// Desenho geométrico
//////////////////////////////////////

void drawLine(int x1, int y1, int x2, int y2, int r, int g, int b) {
  SDL_SetRenderDrawColor(renderer, r, g, b, SDL_ALPHA_OPAQUE);
  SDL_RenderDrawLine(renderer, x1, y1, x2, y2);
}

//////////////////////////////////////
// Audio
//////////////////////////////////////

#ifdef __EMSCRIPTEN__
// Disable music for now
Mix_Music *loadMusic(string filename) {
  return NULL;
}
Mix_Chunk *loadSound(string filename) {
  return NULL;
}
#define Mix_PlayChannel(a, b, c) cerr << "Mix_PlayChannel is disabled." << endl
#define Mix_PlayMusic(a, b) cerr << "Mix_PlayMusic is disabled." << endl
#define Mix_FreeChunk(a) cerr << "Mix_FreeChunk is disabled." << endl
#define Mix_FreeMusic(a) cerr << "Mix_FreeMusic is disabled." << endl
#else
Mix_Music *loadMusic(string filename) {
  Mix_Music *music = Mix_LoadMUS(filename.c_str());
  if (!music) {
    cerr << "Error loading " << filename << endl;
    exit(1);
  }
  return music;
}

Mix_Chunk *loadSound(string filename) {
  Mix_Chunk *chunk = Mix_LoadWAV(filename.c_str());
  if (!chunk) {
    cerr << "Error loading " << filename << endl;
    exit(1);
  }
  return chunk;
}
#endif


//////////////////////////////////////
// Game loop
//////////////////////////////////////

bool isQuitEvent(SDL_Event event) {
#ifdef __EMSCRIPTEN__
  return false;
#else
  return event.type == SDL_QUIT || (event.type == SDL_KEYDOWN && event.key.keysym.sym == SDLK_ESCAPE);
#endif
}

void endGameLoop() {
  gameLoopQuit = true;
}

void gameLoopIteration(void *arg) {
  SDL_Event event;

  while (SDL_PollEvent(&event) != 0 && !gameLoopQuit) {
    processEvent(event);
  }

  if (!gameLoopQuit) {
    update();
  }

  if (!gameLoopQuit) {
    SDL_RenderClear(renderer);
    cleanScreen();
    draw();
    SDL_RenderPresent(renderer);
    updateScreen();
  }

#ifdef __EMSCRIPTEN__
  if (gameLoopQuit) {
    emscripten_cancel_main_loop();
  }
#endif
}

void gameLoop() {
  gameLoopQuit = false;

  init();

#ifdef __EMSCRIPTEN__
  int simulate_infinite_loop = 1;
  emscripten_set_main_loop_arg(gameLoopIteration, NULL, -1, simulate_infinite_loop);
#else
  while (!gameLoopQuit) {
    gameLoopIteration(NULL);
  }
#endif

  // destroy() is called by quit(), which is called because of atexit()
}

