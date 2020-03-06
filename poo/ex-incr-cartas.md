---
layout: page
---

# Exercício incremental: jogo de cartas

## 1

Crie os seguintes enums:

- `Valor`, contendo `AS`, `DOIS`, `TRES`, `QUATRO`, `CINCO`, `SEIS`, `SETE`, `OITO`, `NOVE`, `DEZ`, `VALETE`, `DAMA`, `REI`
- `Naipe`, contendo `PAUS`, `COPAS`, `ESPADAS`, `OUROS`
- `CorCarta`, contendo `VERMELHA`, `PRETA`

## 2

Crie a classe `Carta`, com os seguinte métodos públicos:

- `getValor()`, `getNaipe()`, `getCor()`
- `setValor(Valor valor)`, `setNaipe(Naipe naipe)`, `setCor(CorCarta cor)`
- `getNome()`: retorna o nome da carta para impressão (incluindo valor e naipe). Exemplos: `4♣`, `J♥`, `A♠`, `7♦`

## 3

Adicione à classe `Carta` um construtor que recebe valor e naipe (nessa ordem). Modifique a classe de forma que ela se torne imutável.

## 

