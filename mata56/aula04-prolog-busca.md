---
layout: page
title:  "Prolog: unificação e busca"
date:   2016-12-14 16:40:00 -0300
categories: aula
---

## Unificação

Ao responder a uma consulta, o interpretador Prolog pode precisar **instanciar** variáveis, isto é, atribuir valor às variáveis.

Dizemos que dois termos podem ser **unificados** se eles são iguais ou se contêm variáveis que podem ser instanciadas de formar a tornar os termos idênticos.

Definindo mais formalmente, pode-se dizer que dois termos podem ser unificados se, e somente se uma das condições for verdadeira:

- os dois termos são constantes (i.e., átomos ou números) e iguais
    + ex.: `1` e `1`, `casa` e `'casa'`
- um dos termos é uma variável
    + ex.: `X` e 1, `X` e `masc(harry)`, `X` e `Y`
    + nesse caso, a variável é **instanciada** com o termo
- ambos são termos complexos com o mesmo nome e mesmo número de argumentos, e os termos correspondentes podem ser unificados.
    + ex.: `pai(james, harry)` e `pai(X, harry)` (note que `james` pode ser unificado com `X`).

O predicado `=` pode ser usado para determinar se dois termos podem ser unificados. Exemplos:

- `=(casa, casa).` ou `casa = casa.` (operador infixo)
- `X = casa.` (o escopo de X é a cláusula)
- `X = casa, Y = X`
- `X = Y.`
- Negação: `\=`. `\=(X, Y)` é equivalente a `not(=(X, Y))`

[Exercício 2.1 do livro Learn Prolog Now!, página 31](http://www.dis.uniroma1.it/~gemignani/documents/lucia/LearnPrologNow.pdf#page=37).

## Busca

- Ao receber uma consulta, o Prolog tenta unificá-la com cada um dos fatos e com a cabeça das regras que estão na base de conhecimento.
    + Lembrete: regra = `cabeça :- corpo.`
- Se unificar com um fato, retorna as instâncias das variáveis.
- Se unificar com a cabeça de uma regra, consulta o corpo da regra (recursivamente).
- Ver Exemplo 2 em <http://cs.union.edu/~striegnk/courses/esslli04prolog/slides/0.day2.pdf> (a partir da p. 6)
- Use `trace.` / `notrace.` para ativar/desativar o rastreamento das consultas.
- A busca pode ser construída como uma árvore

### Exemplo 

Considere a seguinte base de conhecimento:

```prolog
progenitor(paul, petunia).
progenitor(paul, lili).

tem_mesmo_progenitor_que(X, Y) :-
    progenitor(P, X), progenitor(P, Y).
eh_irma_de(X, Y) :-
    X \= Y, tem_mesmo_progenitor_que(X, Y).
```

Qual o retorno da consulta `eh_irma_de(petunia, X).`?

O retorno é `false.`, pois `X = Y`, tornando a primeira meta de `eh_irma_de` falsa; em uma conjunção lógica, basta uma parte ser falsa para a expressão toda ser falsa.

O problema é que as variáveis `X` e `Y` ainda não estão instanciadas quando o interpretador Prolog vai tentar provar a meta `X \= Y`. Para resolver esse problema, deve-se mover o termo `X \= Y` para o final da cláusula, pois nesse momento as variáveis `X` e `Y` já terão sido instanciadas por causa da meta `tem_mesmo_progenitor_que(X, Y)`.

### Exercício

Quais das próximas operações de unificação serão bem sucedidas e quais irão falhar? Para as que forem bem sucedidas, quais são as instanciações de variáveis resultantes?

- `ponto(A, B) = ponto(1, 2)`
- `ponto(A, B) = ponto(X, Y, Z)`
- `mais(2, 2) = 4`
- `+(2, D) = +(E, 2)`
- `t(p(-1,0), P2, P3) = t(P1, p(1, 0), p(0, Y))`
