---
layout: page
title:  "Prolog: listas"
date:   2016-12-21 16:40:00 -0300
categories: aula
---

## Definição

- Uma **lista** é uma sequência finita de elementos. Ex.:

```prolog
[mia, vincent, jules, yolanda]
[mia, robber(honey_bunny), X, 2, mia]
[]
[mia, [vincent, jules], [butch, girlfriend(butch)]]
[[], dead(zed), [2, [b, chopper]], [], Z, [2, [b, chopper]]]
```

## Cabeça e cauda

- Uma lista **não-vazia** pode ser pensada como tendo duas partes:
    + **cabeça** (*head*): primeiro elemento da lista
    + **cauda** (*tail*): lista que sobra quando retiramos a cabeça

## Operador | (pipe)

Uma lista **não-vazia** pode ser representada de forma a apresentar explicitamente a sua cabeça e a sua cauda, usando a sintaxe `[Cabeça|Cauda]`. Exemplos:

```prolog
% lista [b]
[b|[]]
% lista [a, b]
[a|[b|[]]]
```

Essa sintaxe é útil em consultas quando queremos decompor uma lista em cabeça e cauda.

```prolog
?- [Head|Tail] = [mia, vincent, jules, yolanda].

Head = mia
Tail = [vincent,jules,yolanda]
yes
```

Equivalente: `[X|Y] = [mia, vincent, jules, yolanda].`

Obter os dois primeiros elementos da lista

```prolog
?- [X,Y | W] = [[], dead(zed), [2, [b, chopper]], [], Z].
```

Obter o segundo e o quarto elementos

```prolog
?- [_,X,_,Y|_] = [[], dead(zed), [2, [b, chopper]], [], Z].
```

Exemplo mais avançado:

```prolog
?- [_,_,[_|X]|_] =
  [[], dead(zed), [2, [b, chopper]], [], Z, [2, [b, chopper]]].
```

## Predicado `membro`

`membro(X, L)` determina se o elemento `X` faz parte da lista `L`.

```prolog
membro(X, [X|T]).
membro(X, [H|T]) :- membro(X, T).
```

Ou, melhor:

```prolog
member(X, [X|_]).
member(X, [_|T]) :- member(X, T).
```

Considere a busca nas seguintes consultas:

- `membro(vincent,[yolanda,trudy,vincent,jules]).`
- `membro(zed,[trudy,vincent,jules]).`

Outro exemplo de consulta

```prolog
membro(X,[yolanda,trudy,vincent,jules]).
```

## Predicado a2b/2

- retorna "sim" somente se
    + o 1o argumento é uma lista somente de `a`s
    + o 2o argumento é uma lista somente de `b`s
    + as listas têm o mesmo tamanho
- Ex.: `a2b([a,a,a,a],[b,b,b,b]).` é verdadeiro
- Ex.: `a2b([a,a,a,a],[b,b,b]).` é falso

```prolog
a2b([], []).
a2b([a|A], [b|B]) :- a2b(A, B).
```

## Exercícios

**Exercício 31**. Defina o predicado `todos_as(L)`, que retorna verdadeiro somente se todos os elementos da lista `L` são o átomo `a`.

**Exercício 32**. Defina o predicado `contem_1(L)`, que retorna verdadeiro somente se a lista `L` contém o elemento `1`.

**Exercício 33**. Considere a seguinte base de conhecimento:

```prolog
traducao(one,um).
traducao(two,dois).
traducao(three,tres).
traducao(four,quatro).
traducao(five,cinco).
traducao(six,seis).
traducao(seven,sete).
traducao(eight,oito).
traducao(nine,nove).
```

Crie uma regra, `lista_traducao(E,P)`, que traduz uma lista de numerais em inglês na lista correspondente com os numerais em português. Por exemplo, `lista_traducao([one,nine,two],X)` deve retornar `X = [um,nove,dois]`.

Seu programa também deve funcionar no sentido inverso. Isto é, `lista_traducao(X,[um,sete,seis,dois])` deve retornar `X = [one,seven,six,two]`.

Dica: Para resolver esta questão, primeiro tente responder a seguinte pergunta: "Como faço para traduzir uma lista vazia de numerais?". Este é o ponto de parada da recursividade. Para listas que não sejam vazias, primeiro, deve-se traduzir a cabeça da lista e, em seguida, traduzir a cauda utilizando recursividade.

**Exercício 34**. Crie uma regra `duplica_elementos(E, S)`, em que o primeiro argumento (`E`) é uma lista e o segundo (`S`) é uma lista contendo todos os elementos de `E` duplicados.

Ex. 1: `duplica_elementos([a,4,relogio],X)` deve retornar `X = [a,a,4,4,relogio,relogio]`.

Ex. 2: `duplica_elementos([1,2,1,1],X)` deve retornar `X = [1,1,2,2,1,1,1,1]`.

Dica: Para resolver esta questão, primeiro tente responder a seguinte pergunta: "O que deve acontecer quando o primeiro argumento é uma lista vazia?". Este é o ponto de parada da recursividade. Para listas que não sejam vazias, pense no que deve acontecer com a cabeça e, utilizando recursividade, trate a cauda da lista.

## Outros predicados interessantes

- `concatena(L1, L2, L3)` - L3 é a concatenação de L1 com L2
- `inverte(L1, L2)` - L2 é o inverso de L1
- `remover(X, L1, L2)` - L2 é igual a L1 removendo-se o elemento X
- `eh_sublista(L1, L2)` - L1 é sublista de L2
- `intersecao(L1, L2, L3)` - L3 contém apenas os elementos que aparecem em L1 e L2
- `palindrome([r,o,t,a,t,o,r])` - verdadeiro se a lista é igual a seu inverso
- `elemEm(L, N, X)` - X é o N-ésimo elemento de L
- `elemPos(L, N, X)` - N é a posição do elemento X em L

Envolvendo aritmética:

- `comprimento(L, N)`
- `somatorio(L, N)`
- `media(L, N)`





<!-- - `permutar(L, P)` - -->
