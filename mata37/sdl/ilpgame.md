---
layout: page
title: Biblioteca ILP Game
---

## O que é?

A ILP Game é uma biblioteca de funções que simplificam o desenvolvimento de aplicações multimídia com a biblioteca [SDL](https://www.libsdl.org/).

A ILP Game possui poucas funções; na prática, você ainda precisará usar a SDL diretamente em várias situações, seguindo as orientações [nestes slides](https://rodrigorgs.github.io/aulas/mata37/sdl/) e na [documentação da SDL](https://wiki.libsdl.org/APIByCategory).

## Dependências

Antes de usar a ILP Game, você precisa de:

- compilador de C++
- biblioteca SDL
- biblioteca SDL\_image
- biblioteca SDL\_ttf
- biblioteca SDL\_mixer

**Instalação das dependências no macOS:**

```bash
brew install sdl2 sdl2_image sdl2_mixer sdl2_ttf
```

**Instalação das dependências no Ubuntu Linux:**

```bash
sudo apt-get install libsdl2*dev
```

**Instalação das dependências no Windows:**

- [Instalação do compilador de C++ (MinGW)](https://youtu.be/bEs-5IU_l9w) (vídeo)
- [Instalação da SDL](https://youtu.be/gvEWGHAPO8k) (vídeo)


Veja também os [slides sobre SDL](https://rodrigorgs.github.io/aulas/mata37/sdl/).

## Como usar?

Para usar, copie o arquivo [ilpgame.h](ilpgame.h) para o diretório onde está o seu arquivo fonte (`.cc` ou `.cpp`) e adicione a seguinte linha ao início do arquivo fonte:

```c++
#include "ilpgame.h"
```

(Se você tiver múltiplos arquivos `.cc` ou `.cpp`, insira a linha `#define ILPGAME_HEADER_ONLY` antes do `#include` em todos os seus arquivos `.cc`/`.cpp` exceto um.)

Você também precisará definir as seguintes funções:

```c++
void init() {
}

void destroy() {
}

void processEvent(SDL_Event event) {
}

void update() {
}

void draw() {
}
```

O seu `main()` deve ficar assim:

```c++
int main(int argc, char *argv[]) {
  initSDL();
  gameLoop();
  return 0;
}
```

## Como compilar?

No Mac ou no Linux:

```bash
g++ seuarquivo.cc `sdl2-config --cflags --libs` -lSDL2_ttf -lSDL2_image -lSDL2_mixer
```

No Windows: veja o vídeo [Instalação da SDL](https://youtu.be/gvEWGHAPO8k); no comando de compilação, você precisará incluir `-lSDL2_ttf -lSDL2_image -lSDL2_mixer`

## Como funciona?

A função `initSDL()` inicializa as bibliotecas SDL, SDL\_ttf (permite carregar fontes e escrever texto na tela) e SDL\_image (permite carregar diversos formatos de imagem). Além disso, ela também cria a janela do programa.

A função `gameLoop()` chama a função `init()` e então entra em um loop, no qual chama repetidamente as funções `processEvent()`, `update()` e `draw()`, várias vezes por segundo. Se alguma dessas funções chamar `endGameLoop()`, o loop se encerra e a função `destroy()` é chamada.

Informações adicionais:

- **`init()`**: chamada no início da execução do programa; aqui você deve carregar arquivos (imagens, fontes, áudio), inicializar variáveis etc.
- **`destroy()`**: chamada no final da execução do programa; aqui você deve liberar os recursos, usando funções como `SDL_FreeSurface()`, `TTF_CloseFont()`, dentre outras.
- loop (executado várias vezes por segundo):
  - **`processEvent()`**: aqui você deve tratar os eventos do SDL, como pressionar um botão, fechar janela, dentre outros; essa função pode ser chamada várias vezes dentro de uma iteração do loop.
  - **`update()`**: aqui você deve atualizar a sua simulação, alterando variáveis como posições de imagens, velocidades, dentre outros; aqui também pode ser útil ler o estado de teclas e do mouse, usando funções como `SDL_GetKeyboardState()` e `SDL_GetMouseState()`.
  - **`draw()`**: aqui você vai desenhar coisas na tela; note que a função `gameLoop()` limpa a tela antes de chamar `draw()`, de forma que você precisa redesenhar tudo a cada vez.

## Exemplos

Todos os arquivos se encontram em <https://github.com/rodrigorgs/aulas/tree/master/mata37/sdl>.

Exemplos básicos (alguns exemplos requerem arquivos adicionais, como [`FreeSans.ttf`](FreeSans.ttf), [`hero.bmp`](hero.bmp) e [`brick.bmp`](brick.bmp)):

- [Carregar e mostrar uma imagem](tut-imagem.cc) (aperte Esc para sair)
- [Movimentar imagem ao pressionar tecla direcional](tut-keypress.cc)
- [Movimentar imagem de acordo com o estado das teclas direcionais](tut-keystate.cc) (experimente andar na diagonal)
  + Veja também os códigos de teclas na [documentação do SDL_Keycode](https://wiki.libsdl.org/SDL_Keycode).
- [Desenhar imagem sob o cursor do mouse](tut-mouse.cc) (ao segurar o botão esquerdo do mouse, a imagem muda)
- [Desenhar texto](tut-texto.cc)
- [Escrever com o teclado](tut-escreve.cc): aceita teclas de A a Z e backspace
- [Contador de tempo](tut-timer.cc)
- [Limitar FPS](tut-limitfps.cc): limita a taxa de atualização do jogo (FPS) para que ele rode na mesma velocidade em todos os computadores
- [Áudio](tut-audio.cc)

Demonstrações:

- [Bola quicando](demo-quica.cc): simula gravidade e coeficiente de restituição
- [Carro](demo-carro.cc): controle um carro usando as setas direcionais
- [Animação](demo-anima.cc): animação de uma pessoa andando formada por 4 imagens

Jogos:

- [Labirinto](jogo-labirinto.cc): movimente com setas direcionais
- [Runner](jogo-runner.cc): mova para os lados para se desviar dos obstáculos

## Funções: Guia de Referência

- Inicialização
    - **`initSDL(w, h)`**: inicializa SDL e bibliotecas relacionadas, e cria janela com largura `w` e altura `h`. Se `w` e `h` forem omitidos, considera 800x600.
- Carregamento de arquivos
    - **`loadImage(filename)`**: carrega o arquivo de imagem `filename` e retorna um `SDL_Surface*` representando a imagem. Ex.: `SDL_Surface *img = loadImage("hello.bmp")`. Ao final, a imagem deve ser liberada com `SDL_FreeSurface(img)`.
    - **`loadFont(filename, size)`**: carrega o arquivo de fonte `filename` com tamanho de `size` pontos. Ex.: `TTF_Font *font = loadFont("OpenSans.ttf", 14)`. Ao final, a fonte deve ser liberada com `TTF_CloseFont(font)`.
- Desenho
    - **`drawImage(img, x, y)`**: desenha a imagem `img` (do tipo `SDL_Surface*`) de forma que seu canto superior esquerdo fique na posição (`x`, `y`) da tela.
    - **`drawCenteredImage(img, x, y)`**: desenha a imagem `img` (do tipo `SDL_Surface*`) de forma que o seu centro fique na posição (`x`, `y`) da tela.
    - **`drawText(text, font, color, x, y)`**: escreve o texto `text` na posição (`x`, `y`) da tela, usando a fonte `font` (carregada com `loadFont()`) e a cor `color` (do tipo `SDL_Color`).
    - **`drawLine(x1, y1, x2, y2, r, g, b)`**: desenha uma linha da posição (`x1`, `y1`) até a posição (`x2`, `y2`) da tela, usando a cor (`r`, `g`, `b`), onde cada componente da cor vai de 0 a 255.
- Game loop
    - **`gameLoop()`**: executa o game loop (`processEvent`, `update`, `draw`), precedido de `init()` e sucedido por `destroy()`.
    - **`endGameLoop()`**: finaliza a executação do game loop
    - **`isQuitEvent(event)`**: indica se o evento `event` corresponde a fechar a janela ou teclar Esc.
