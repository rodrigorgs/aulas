#include "ilpgame.h"

// Aperte Espaço para tocar efeito sonoro
//
// Baseado em http://lazyfoo.net/SDL_tutorials/lesson11/index.php
// Veja também a documentação em https://www.libsdl.org/projects/SDL_mixer/docs/SDL_mixer.html

Mix_Music *musica;
Mix_Chunk *efeitoSonoro;

void init() {
  musica = loadMusic("beat.wav");
  efeitoSonoro = loadSound("coin.wav");

  Mix_PlayMusic(musica, -1); // -1: número de repetições (-1 = infinito)
}

void destroy() {
  Mix_FreeChunk(efeitoSonoro);
  Mix_FreeMusic(musica);
}

void processEvent(SDL_Event event) {
  if (isQuitEvent(event)) {
    endGameLoop();
  } else if (event.type == SDL_KEYDOWN && event.key.keysym.sym == SDLK_SPACE) {
    Mix_PlayChannel(-1, efeitoSonoro, 0);
  }
}

void update() {

}

void draw() {
}

int main(int argc, char *argv[]) {
  initSDL(320, 200);
  gameLoop();
  return 0;
}