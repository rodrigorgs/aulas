---
layout: page
---

# Exercício incremental: jogo de cartas

## 1

Crie os seguintes enums:

- `Valor`, contendo `AS`, `DOIS`, `TRES`, `QUATRO`, `CINCO`, `SEIS`, `SETE`, `OITO`, `NOVE`, `DEZ`, `VALETE`, `DAMA`, `REI`
- `Naipe`, contendo `PAUS`, `COPAS`, `ESPADAS`, `OUROS`
- `CorNaipe`, contendo `VERMELHA`, `PRETA`

## 2

Crie a classe `Carta`, com os seguinte métodos públicos:

- `getValor()`, `getNaipe()`, `getCor()`
- `setValor(Valor valor)`, `setNaipe(Naipe naipe)`, `setCor(CorNaipe cor)`
- `getNome()`: retorna o nome da carta para impressão (incluindo valor e naipe). Exemplos: `4♣`, `J♥`, `A♠`, `7♦`

## 3

<!-- construtores; exception -->

Adicione à classe `Carta` um construtor que recebe valor e naipe (nessa ordem). Modifique a classe de forma que ela se torne imutável. Não deve ser permitido criar cartas com valor ou naipe nulos.

## 4

<!-- Collections -->

Crie a classe `Baralho`, que representa um conjunto ordenado de cartas e é inicializado com 52 cartas distintas. Defina os seguintes métodos públicos:

- `insereNoTopo(Carta carta)`: insere a carta no topo do baralho (exceto se o baralho já contiver uma carta igual à que está sendo inserida)
- `Carta removeDoTopo()`: remove carta do topo do baralho e retorna essa carta (ou null se o baralho estiver vazio)
- `Carta obtemCartaDoTopo()`: retorna a carta do topo do baralho sem removê-la do baralho (ou null se o baralho estiver vazio)
- `boolean contem(Carta carta)`: indica se o baralho já contém a carta fornecida como parâmetro
- `int tamanho()`: retorna o número de cartas no baralho

<!-- 
- `Carta removeAleatoria(Carta carta)`: remove uma carta aleatória do baralho
- `Carta removeDoFundo(Carta carta)`: remove carta do fundo do baralho
- `insereNoFundo(Carta carta)`: insere a carta no fundo do baralho (exceto se o baralho já contiver uma carta igual à que está sendo inserida) -->

## 5

<!-- imutabilidade, visibilidade -->

Adicione à classe `Baralho` o seguinte método:

- `List<Carta> obtemCartas()`: retorna a lista de cartas contidas no baralho

Garanta que o baralho só pode ser modificado através dos métodos `insereNoTopo` e `removeDoTopo`.