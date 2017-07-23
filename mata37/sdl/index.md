---
layout: remark
title: Introdução à SDL
---

<div>

# SDL

Simple DirectMedia Layer (SDL) é uma biblioteca multiplataforma (Windows, Linux, macOS, Android, iOS...), escrita em C, para aplicações multimídia. Ela provê funções para gerenciar vídeo, áudio, controle, entre outras.

A SDL provê apenas funcionalidades básicas. Funcionalidades adicionais podem ser encontradas em bibliotecas adicionais, como `SDL_image`, `SDL_mixer` e `SDL_ttf`.

---

# Referências importantes

- Referência de todos os tipos, funções etc. da SDL: <https://wiki.libsdl.org/CategoryAPI>

---

# Instalação (macOS)

Instalação:

```bash
brew install sdl2 sdl2_image sdl2_mixer sdl2_ttf
```

---

# Instalação (Ubuntu Linux)

Instalação:

```bash
sudo apt-get install libsdl2*dev
```

---

# Instalação (Windows)

- [Instalação do compilador de C++ (MinGW)](https://youtu.be/bEs-5IU_l9w) (vídeo)
- [Instalação da SDL](https://youtu.be/gvEWGHAPO8k) (vídeo)

<!--
- <https://youtu.be/ybYMOKEW9IY> (em inglês)
- <https://www.youtube.com/watch?v=acLgxNubi1U>
- <https://abaixonivel.wordpress.com/2009/11/28/instalando-e-configurando-o-codeblocks-com-sdl-no-windows/>
- <https://abaixonivel.wordpress.com/2012/07/20/preparando-se-para-usar-sdl2-parte2/>
-->

---

# Compilação (macOS ou Linux)

```bash
g++ alomundo.cc `sdl2-config --cflags --libs`
```

---

# Compilação (Windows)

```bash
g++ alomundo.cc -I "C:\MinGW\include\SDL2" -mwindows -lmingw32 -lSDL2main -lSDL2
```

Esse comando assume que o MinGW está instalado em `C:\MinGW` e que os arquivos de desenvolvimento da SDL foram copiados para os respectivos subdiretórios (`include`, `lib`, `bin`).

---

# Alô mundo - código completo

```c++
#include <SDL.h>

int main(int argc, char *argv[]) {
  SDL_Window *window;
  SDL_Surface *screenSurface;

  SDL_Init(SDL_INIT_VIDEO);

  window = SDL_CreateWindow("Tutorial", 100, 50, 320, 480, SDL_WINDOW_SHOWN);
  screenSurface = SDL_GetWindowSurface(window);
  
  SDL_Delay(5000);

  SDL_FreeSurface(screenSurface);
  SDL_DestroyWindow(window);
  SDL_Quit();

  return 0;
}
```

---

# Alô mundo - observações gerais

- Para usar a biblioteca SDL, você precisa adicionar `#include <SDL.h>`
- Todas as funções, tipos etc. do SDL começam com `SDL_`

---

# Alô mundo - window e surface

O programa possui dois tipos importantes:

- `SDL_Window` representa uma janela do sistema operacional
- `SDL_Surface` representa um retângulo contendo pixels

Para mais informações, consulte a [referência da SDL](https://wiki.libsdl.org/CategoryAPI)

---

# Alô mundo - inicialização

A primeira instrução é [SDL_Init](https://wiki.libsdl.org/SDL_Init), responsável por inicializar a SDL e seus vários subsistemas. No exemplo, inicializamos apenas o vídeo:

```c++
SDL_Init(SDL_INIT_VIDEO);
```

Para inicializar vídeo, áudio e joystick, por exemplo, podemos fazer:

```c++
SDL_Init(SDL_INIT_VIDEO | SDL_INIT_AUDIO | SDL_INIT_JOYSTICK);
```

---

# Alô mundo - lidando com erros

Devemos checar se a inicialização foi bem sucedida e, se não foi, exibir uma mensagem de erro que nos ajude a resolver o problema. Veja o que diz a [documentação da SDL_Init](https://wiki.libsdl.org/SDL_Init):

> Returns 0 on success or a negative error code on failure; call SDL_GetError() for more information.

O código fica assim:

```c++
if (SDL_Init(SDL_INIT_VIDEO) < 0) {
    cout << "Erro: " << SDL_GetError() << endl;
    SDL_Quit();
}
```

---

# Alô mundo - criando a janela

```c++
window = SDL_CreateWindow("Tutorial", 100, 50,
  320, 480, SDL_WINDOW_SHOWN);
```

Veja a [documentação da função SDL_CreateWindow](https://wiki.libsdl.org/SDL_CreateWindow):

```
SDL_Window* SDL_CreateWindow(
  const char* title,
  int         x,
  int         y,
  int         w,
  int         h,
  Uint32      flags)
```

---

# Alô mundo - lidando com erros

Se a criação da janela falhar, `SDL_CreateWindow` retorna `NULL` (uma constante com valor 0). É bom tratar erros:

```c++
if (!window) {
  cout << "Erro: " << SDL_GetError() << endl;
  SDL_Quit();
}
```

(Que provocar um erro? Defina a largura da janela como 99999!)

---

# Alô mundo - obtendo a superfície de desenho

```c++
screenSurface = SDL_GetWindowSurface(window);
```

No exemplo, chamamos [SDL_GetWindowSurface](https://wiki.libsdl.org/SDL_GetWindowSurface) para obter a superfície de desenho, mas ainda não estamos usando essa superfície pra nada útil

---

# Alô mundo - vamos dar um tempo

```c++
SDL_Delay(5000);
```

Aguarda 5000 milissegundos.

---

# Alô mundo - liberando os recursos

```c++
SDL_FreeSurface(screenSurface);
SDL_DestroyWindow(window);
SDL_Quit();
```

---

# Desenhando um retângulo

Antes do `SDL_Delay`, adicione as seguintes linhas:

```c++
SDL_FillRect(screenSurface, NULL, SDL_MapRGB(screenSurface->format,
    0xFF, 0xFF, 0xFF));
SDL_UpdateWindowSurface(window);
```

O [SDL_FillRect](https://wiki.libsdl.org/SDL_FillRect) desenha um retângulo preenchido em uma superfície. Exercício: qual a cor do retângulo desenhado? Como faz para desenhar um retângulo vermelho?

A superfície da janela é oculta; as alterações em uma superfície só ficam visíveis depois que ela é copiada para a tela, e isso é feito com a função [SDL_UpdateWindowSurface](https://wiki.libsdl.org/SDL_UpdateWindowSurface).

Ver [exemplo completo](lesson01.cc).

---

# Desenhando uma imagem

Carregando:

```c++
SDL_Surface *image = SDL_LoadBMP("hello.bmp");
if (!image) {
  printf("Erro: %s\n", SDL_GetError());
  SDL_Quit();
}
```

Desenhando:

```c++
SDL_BlitSurface(image, NULL, screenSurface, NULL);
```

Liberando:

```c++
SDL_FreeSurface(image);
```

</div>

---

# A imagem se mexe!

Para esse exemplo, crie uma janela de 640x480.

```c++
SDL_Rect pos;
int i;

// insira o código de inicialização...

pos.x = 0;
pos.y = 160;
for (i = 0; i < 320; i++) {
  pos.x = i;
  SDL_FillRect(screenSurface, NULL, SDL_MapRGB(screenSurface->format, 0x00, 0x00, 0x00));
  SDL_BlitSurface(image, NULL, screenSurface, &pos);
  SDL_UpdateWindowSurface(window);
  SDL_Delay(10);
}
```

Ver [exemplo completo](lesson02a.cc).

---

# SDL_Rect

SDL_Rect especifica uma região retangular. Possui quatro atributos: x, y (especificam a posição do canto superior esquerdo do retângulo), w (largura - width), h (altura, height).

No exemplo, usamos um SDL_Rect chamado `pos` para especificar a posição onde a imagem será desenhada na tela:

```c++
SDL_BlitSurface(image, NULL, screenSurface, &pos);
```

A função [SDL_BlitSurface](http://wiki.libsdl.org/SDL_BlitSurface) ignora os atributos `w` e `h` de `pos`.

Note o uso de `&` em `&pos`. Isso é um [ponteiro](http://lmgtfy.com/?q=c+ponteiros).

---

# Eventos

SDL é baseada em eventos. Eventos indicam que alguma coisa aconteceu no seu programa e que você pode querer fazer alguma coisa a respeito. Alguns exemplos de eventos:

- `SDL_QUIT`: o usuário fechou a janela do programa
- `SDL_KEYDOWN`: o usuário pressionou uma tecla do teclado
- `SDL_MOUSEMOTION`: o mouse se moveu
- `SDL_MOUSEBUTTONDOWN`: o usuário pressionou um botão do mouse

Veja a documentação sobre [SDL_Event](http://wiki.libsdl.org/SDL_Event)

---

# Loop de eventos

Um programa típico em SDL é um loop infinito que lê eventos, trata eventos, desenha na tela e repete tudo de novo:

```c++
  SDL_Event event;
  bool quit = false;

  // insira o código de inicialização...

  while (!quit) {
    while (SDL_PollEvent(&event) != 0) {
      if (event.type == SDL_QUIT) {
        quit = true;
      }
    }

    SDL_BlitSurface(image, NULL, screenSurface, NULL);
    SDL_UpdateWindowSurface(window);
  }
```

Ver [exemplo completo](lesson03.cc).

Cada iteração do loop mais externo acontece cerca de 60 vezes por segundo.

---

# SDL_PollEvent

[SDL_PollEvent](http://wiki.libsdl.org/SDL_PollEvent) recebe um ponteiro para uma estrutura de evento e preenche a estrutura com informações sobre o evento atual.

```c++
SDL_PollEvent(&event);
```

---

# Usando o teclado

Ver [exemplo completo](lesson04.cc).

---

# Para saber mais

- Documentação oficial (em inglês):
  - [Lista de funções por categoria](https://wiki.libsdl.org/APIByCategory)
  - [Lista de funções em ordem alfabética](https://wiki.libsdl.org/CategoryAPI)
  - [Página inicial](https://wiki.libsdl.org/FrontPage)
- [Slides da UFRJ sobre a SDL](http://equipe.nce.ufrj.br/adriano/c/apostila/sdl/Palestra/Sdl2Tutorial.pdf)
- [Beginning Game Programming v2.0](http://lazyfoo.net/tutorials/SDL/index.php) (em inglês)
