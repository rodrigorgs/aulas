---
layout: page
title:  "Prolog: aritmética"
date:   2016-12-16 16:40:00 -0300
categories: aula
---

O que acontece ao executar a seguinte consulta em Prolog?

```prolog
X = 1 + 2.
```

Era de se esperar que `X` fosse instanciado com o valor `3`, mas não é isso o que acontece. Em vez disso, `X` é instanciado com o termo complexo `1+2` ou, equivalentemente, `+(1, 2)`.

```prolog
% As duas formas são idênticas:
1 + 2 == +(1, 2).
```

## Operador `is`

O operador binário `is` é similar ao operador de unificação, `=`, com uma diferença: o lado direito (e **apenas** o lado direito) é interpretado como uma expressão aritmética e seu resultado é calculado antes da unificação. Exemplos:

```prolog
X is 1 + 2.
3 is 1 + 2.
```

A segunda consulta retorna `true` porque o lado direito do operador `is` é avaliado como expressão aritmética, resultando no valor `3`, e `3` (lado esquerdo) pode ser unificado com `3` (lado direito).

Contra-exemplo:

```prolog
1 + 2 is 3.
```

O último exemplo não funciona porque o lado esquerdo do `is` não é avaliado como expressão aritmética. Ao tentar unificar `+(1, 2)` com `3`, a unificação falha.

## Operadores aritméticos

O Prolog possui os operadores mais comuns, como `+`, `-`, `*`, `/`, `abs`, `sin`, `cos`, `tan`, `exp`, `ln`, `log`, `sqrt`, dentre outros. A precedência entre operadores é respeitada. Exemplo:

```prolog
X is 1 + 2 * 3.
X is sqrt(9).
```

Não confunda operadores com predicados! Operadores aritméticos são funções que retornam um número.

## Operadores de comparação

Prolog admite operadores de comparação, como `>` e `<`. Ao usar um desses operadores, **ambos** os lados são avaliados como expressão aritmética. Exemplos:

```prolog
4 > 3.   /* true */
8 + 1 < 5 + 5.   /* true */
X is +(8, 1), X < X + 1.   /* true */
```

Operadores de comparação:

- `<`: menor que
- `>`: maior que
- `>=`: maior ou igual a
- `=<`: menor ou igual a (a maioria das outras linguagens usa `<=`)
- `=:=`: igual a
- `=\=`: diferente de

Note que esses operadores **não** realizam unificação! Por isso, as variáveis devem estar instanciadas antes de se realizar a comparação. Exemplo:

```prolog
X =:= 5.
/* [Error] =:=/2: Arguments are not sufficiently instantiated */
```

Qual o resultado das seguintes consultas?

```prolog
1 + 2 == +(1, 2).
1 + 2 == 2 + 1.
1 + 2 == 1 + X.
1 + 2 = 1 + X.
1 + 2 = X.
1 + 2 = 2 + 1.
1 + 2 = 2 + X.
1 + 2 =:= 2 + 1.
1 + 2 =:= 2 + X.
X is 1 + 2.
1 + 2 is X.
```

Ver também exercícios da página 78 do livro Learn Prolog Now.

## Exercícios

**Exercício 24**. Escreva uma regra para o predicado `entre(X, A, B)`, que indica que o número `X` está entre os números `A` e `B`, inclusive (isto é, deve retornar verdadeiro também se X = A ou X = B). Assuma que `A` é menor ou igual a `B`.

**Exercício 25**. Reescreva a regra da questão anterior de forma que funcione para quaisquer dois valores inteiros de `A` e `B`, seja A maior ou menor do que B.

**Exercício 26**. Escreva uma regra para o predicado `triplo(X, Y)`, que indica que `X` é o triplo do número `Y`. Teste com a seguinte consulta: `triplo(X, 4)`. O que acontece se você consultar `triplo(12, Y)`, para tentar obter um terço de 12?

**Exercício 27**. Escreva uma regra para o predicado `par(X)`, que indica se o número inteiro não-negativo `X` é par. Lembre-se de que 0 é par. Use o operador `mod(X, Y)`, que retorna o resto da divisão de `X` por `Y`.

**Exercício 28**. Reescreva a regra da questão anterior sem usar o operador `mod`.

**Exercício 29**. Escreva uma regra para o predicado `fatorial(X, Y)`, que indica que o fatorial de `X` é `Y`. Dica: considere que o fatorial de 0 é 1 e que o fatorial de `X` é igual a `X` multiplicado pelo fatorial de `X - 1`.

**Exercício 30**. Escreva uma regra para o predicado `sucessor(X, Y)`, que indica que o número `X` é sucessor do número `Y`.
