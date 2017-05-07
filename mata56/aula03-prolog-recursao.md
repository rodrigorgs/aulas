---
layout: page
title:  "Prolog: recursão"
date:   2016-12-09 16:40:00 -0300
categories: aula
---

## Revisão

Resolução de exercícios selecionados da aula passada: 12, 17 e outros conforme solicitação.

## Recursão

![]({{site.baseurl}}/files/recursion.png)

Considere a seguinte base de conhecimento Prolog:

```prolog
progenitor(maria, jose).
progenitor(joao, jose).
progenitor(joao, ana).
progenitor(jose, julia).
progenitor(jose, iris).
progenitor(iris, jorge).
```

**Exercício 18**. Escreva uma regra para o predicado `ancestral/2`, onde `ancestral(X, Y)` indica que `X` é um antepassado de `Y`.

Dizemos que `X` é antepassado de `Y` se `X` é um progenitor de `Y`, ou é progenitor de um progenitor de `Y`, ou é um progenitor de um progenitor de um progenitor de `Y`, e assim sucessivamente.

Se queremos escrever uma regra completa, que funcione mesmo para as árvores genealógicas mais extensas, é necessário usar **recursão**, isto é, criar definições que fazem referência a si próprias. Toda regra recursiva é composta de duas partes:

- o **caso base**, que é um caso simples que produz uma resposta sem usar recursão, e
- um conjunto de regras que reduzem todos os outros casos para o caso base, fazendo referência à própria regra.

Nunca se esqueça de escrever o caso base, caso contrário o resultado será uma recursão infinita.

![]({{site.baseurl}}/files/infinite-patrick.gif)

**Exercício 19**. Agora escreva uma regra para o predicado `descendente/2`, sem usar o predicado `ancestral/2`.

**Exercício 20**. Considere o predicado `sucessor(X, Y)`, que indica que um número, `X`, é sucessor de outro número, `Y`. Escreva os fatos para relacionar os números de 1 a 6 de acordo com o predicado `sucessor`. Ex.:

```prolog
sucessor(2, 1).
sucessor(3, 2).
% e por aí vai...
```

Agora defina regras para os predicados `maior_que/2` e `menor_que/2`.

**Exercício 21**. Considere a seguinte base de conhecimento:

```prolog
progenitor(maria, jose).
progenitor(joao, jose).
progenitor(joao, ana).
progenitor(jose, julia).
progenitor(jose, iris).
progenitor(iris, jorge).
```

Considere as diferentes definições para a regra `antepassado`:

```prolog
%%%% OPCAO 1 %%%%
antepassado(X,Y) :- progenitor(X,Y).
antepassado(X,Y) :- progenitor(X,Z),
                    antepassado(Z,Y).

%%%% OPCAO 2 %%%%
antepassado(X,Y) :- antepassado(Z,Y),
                    progenitor(X,Z).
antepassado(X,Y) :- progenitor(X,Y).

%%%% OPCAO 3 %%%%
antepassado(X,Y) :- progenitor(X,Y).
antepassado(X,Y) :- antepassado(Z,Y),
                    progenitor(X,Z).

%%%% OPCAO 4 %%%%
antepassado(X,Y) :- progenitor(X,Z),
                    antepassado(Z,Y).
antepassado(X,Y) :- progenitor(X,Y).
```

Do ponto de vista lógico, as quatro definições são equivalentes. Crie quatro versões diferentes da base de conhecimento, cada uma com uma das definições de `antepassado`, e teste a regra `antepassado` realizando tanto consultas que retornam `sim` quanto consultas que retornam `não`. O que acontece em cada caso? Use o `trace` para entender como o Prolog executa as consultas.

**Exercício 22**. Considere a seguinte base de conhecimento:

```prolog
localizado_em(salvador, bahia).
localizado_em(bahia, brasil).
localizado_em(maceio, brasil).
localizado_em(roma, italia).
nasceu_em(joao, salvador).
nasceu_em(maria, maceio).
nasceu_em(giuseppe, roma).
```

Crie uma regra, `nasceu_em_recursivo(P, L)`, que determina se uma pessoa `P` nasceu em um local `L`, considerando que há localidades que englobam outras. No exemplo, `nasceu_em_recursivo(P, brasil)` deve retornar `P = joao`; `P = maria`. Dica: crie um predicado auxiliar `localizado_em_recursivo/2`.

**Exercício 23**. Considere a seguinte base de conhecimento:

```prolog
deCarro(auckland, hamilton).
deCarro(hamilton, raglan).
deCarro(valmont, saarbruecken).
deCarro(valmont, metz).
 
deTrem(metz, frankfurt).
deTrem(saarbruecken, frankfurt).
deTrem(metz, paris).
deTrem(saarbruecken, paris).
 
deAviao(frankfurt, bangkok).
deAviao(frankfurt, singapore).
deAviao(paris, losAngeles).
deAviao(bangkok, auckland).
deAviao(losAngeles, auckland).
```

Escreva um predicado `viagem/2` que determina se é possível viajar de um lugar para outro combinando trajetos de carro, trem e avião. Por exemplo, seu programa deve responder sim à consulta `viagem(valmont, raglan)`.

**Exercício 23.5**. 
