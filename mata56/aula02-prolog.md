---
layout: page
title:  "Prolog: conceitos e exercícios básicos"
date:   2016-12-07 16:40:00 -0300
categories: aula
---

## SWI-Prolog

Nesta disciplina, usaremos o [SWISH](http://swish.swi-prolog.org/), um ambiente online para rodar programas no interpretador SWI-Prolog. Ao criar um novo documento no SWISH, a tela é dividida em três partes:

- esquerda: base de conhecimento (programa)
- direita inferior: consulta
- direita superior: resultados

## Exemplo inicial

Escreva, na **base de conhecimento**, o seguinte:

```prolog
humano(joao).
```

Com isso, você está afirmando que `joao` é humano. `humano(joao)`, nesse contexto, é um *fato*. 

Agora, na área de **consulta**, escreva o seguinte:

```prolog
humano(joao).
```

Você está fazendo uma *consulta*: `joao` é humano? Na área de **resultados**, o interpretador vai responder `true.`.

Outras consultas para testar:
    + `humano(shrek).`
    + `humano(caetano).`
    + `humano(X).`

`false` significa "não é possível provar que é verdadeiro" (*hipótese do mundo fechado*).

## Exemplo mais completo

Vamos tentar um exemplo mais completo. Digite o seguinte na base de conhecimento:

```prolog
humano(joao).
humano(maria).
humano(pedro).
mulher(maria).
homem(joao).
homem(pedro).
```

Agora digite a seguinte consulta:

```prolog
humano(X).
```

Nesse contexto, `X` é uma variável. O interpretador Prolog vai retornar todos os valores de X para os quais `humano(X)` é verdadeiro. Nesse caso, o resultado vai ser `X = joao`, `X = maria` e `X = pedro`. 

Se sabemos que `joao` é homem, não deveríamos precisar dizer que ele é humano, pois *todo homem é humano*! A mesma lógica vale para as mulheres! Podemos inserir **regras** na nossa base de conhecimento:

```prolog
humano(X) :- homem(X).
humano(X) :- mulher(X).
mulher(maria).
homem(joao).
homem(pedro).
```

As duas primeiras linhas são regras, que podem ser traduzidas como:

- Se X é homem, então X é humano.
- Se X é mulher, então X é humano.

Agora realize a consulta `humano(joao)`. Qual é o retorno?

Realize também a consulta `humano(X)`. Qual é o retorno?

## Conceitos

Um programa em Prolog é uma **base de conhecimento** que contém **cláusulas** finalizadas por ponto (`.`). Essas cláusulas representam o que sabemos sobre o mundo.

Uma cláusula pode ser um **fato** ou uma **regra**. Uma regra possui **cabeça** e **corpo**, no formato `cabeça :- corpo`, onde corpo.

Identificadores começados por letras minúsculas são **átomos**, que representam objetos específicos do nosso mundo. Identificadores começados por letras maiúsculas são **variáveis**.

Uma variável tem validade apenas dentro da cláusula onde se encontra. Assim, duas ocorrências de `X` na mesma cláusula correspondem à mesma variável:

```prolog
% Se X for joao e pensa(joao) é verdadeiro,
% concluímos que existe(joao).
existe(X) :- pensa(X).
```

Por outro lado, é possível usar o mesmo nome em cláusulas diferentes para se referir a coisas diferentes:

```prolog
% Podemos ter X = joao na primeira cláusula
% e X = maria na segunda cláusula.
humano(X) :- homem(X).
humano(X) :- mulher(X).
```

Note que duas variáveis diferentes na mesma cláusula podem ter o mesmo valor:

```prolog
amigo(joao, maria).
amigo(joao, jose).
amigo(joao, joao).

% Qual o resultado das consultas a seguir?
% amigo(X, X).
% amigo(X, Y).
```

O predicado `amigo` é um predicado binário. Por isso, chamamos ele de `amigo/2`.

Variáveis começadas por `_` não são exibidas no resultado da consulta. Exemplos: `_X`, `_Y`. Usamos nomes começados por `_` para variáveis cujo valor não estamos interessados. Exemplo de código:

```prolog
turma(mata56, turma1, rodrigo).
turma(mata56, turma2, rodrigo).
turma(mata62, turma3, ivan).
turma(mata62, turma4, rodrigo).

%% Consulta: Quais sao as disciplinas de Rodrigo (não exibe as turmas)?
% turma(D, _T, rodrigo).
```

Além disso, a variável anônima, `_` (somente `_`), tem a seguinte peculiaridade: cada ocorrência dela representa uma variável distinta. Exemplo de consulta: 

```prolog
%% Quais são os professores (não importa a disciplina e a turma)?
% turma(_, _, P).
%% Note que o primeiro e o segundo argumentos de turma
%% são variáveis diferentes, que podem assumir valores
%% diferentes. A consulta é equivalente a
% turma(_X, _Y, P).
```

Ao escrever termos, `,` representa `e` (conjunção lógica) e `;` representa `ou` (disjunção lógica).

O predicado `not/1` representa negação; ou seja, `not(X)` é verdadeiro se e somente se `X` for falso.

É possível comparar dois termos com os predicados binários `==` (igual) e `\==` (diferente). Você pode escrever no formato de predicado comum, `==(X, Y)` ou na notação infixa: `X == Y`. Exemplos de consultas (execute para ver o resultado):

```prolog
X == X.
X == Y.
amigo(X, X), X == joao. % considere a base de amigos
amigo(X, X), X == maria. % considere a base de amigos
```

## Prática

### Fatos e consultas

Considere a seguinte **base de conhecimento** composta de predicados `progenitor/2`:

```prolog
progenitor(maria, jose).
progenitor(joao, jose).
progenitor(joao, ana).
progenitor(jose, julia).
progenitor(jose, iris).
progenitor(iris, jorge).
```

Considere que o predicado `progenitor(A, B)` significa que `A` é progenitor (i.e., pai ou mãe) de `B`.

**Exercício 1**. Desenhe a árvore genealógica representada pela base de conhecimento.

**Exercício 2**. Escreva uma consulta para responder à seguinte pergunta: "Ana é progenitora de Jorge?"

**Exercício 3**. Escreva uma consulta para retornar os progenitores de Íris.

**Exercício 4**. Escreva uma consulta para retornar os progenitores de José.

**Exercício 5**. Escreva uma consulta para retornar todos os pares progenitor/filho da base de conhecimento.

**Exercício 6**. Escreva uma consulta para retornar todos os avós de Jorge. Dica: sua consulta será formada por dois termos separados por vírgula.

**Exercício 7**. Escreva uma consulta para retornar todos os netos de João.

**Exercício 8**. Escreva uma consulta para retornar todos os progenitores comuns de José e Ana.

### Regras

Considere a seguinte **base de conhecimento** composta de predicados `progenitor/2`, `masculino/1` e `feminino/1`:

```prolog
progenitor(maria, jose).
progenitor(joao, jose).
progenitor(joao, ana).
progenitor(jose, julia).
progenitor(jose, iris).
progenitor(iris, jorge).

masculino(joao).
masculino(jose).
masculino(jorge).
feminino(maria).
feminino(julia).
feminino(ana).
feminino(iris).
```

**Exercício 9**. Pode-se definir o predicado `filho/2` como sendo o inverso de `progenitor/2`: se `X` é progenitor de `Y`, então `Y` é filho de `X`. Escreva uma regra para computar o predicado `filho/2` e teste com algumas consultas.

**Exercício 10**. Escreva regras para os predicados `mãe/2` e `pai/2`. Teste sua regra.

**Exercício 11**. Escreva regras para os predicados `avô/2` e `avó/2`. Teste sua regra.

**Exercício 12**. Escreva uma regra para o predicado `irmã/2`. Teste sua regra. Em particular, teste com a consulta `irmã(X, iris)`.

## Outro exemplo

Considere uma mesa com a seguinte configuração de pessoas:

```
joao  maria  jose  julia  jorge  ana  iris
```

Isto é, João está imediatamente à esquerda de maria, que está imediatamente à esquerda de José, e assim por diante.

Nos exercícios a seguir, sempre crie consultas para testar a base de conhecimento.

**Exercício 13**. Considere o predicado `a_direita_de(X, Y)`, indicando que `X` se senta imediatamente à direita de `Y`. Escreva uma base de conhecimento com esse predicado para representar a configuração de pessoas da mesa.

**Exercício 14**. Escreva uma regra para o predicado `a_esquerda_de/2`, que é o inverso de `a_direita_de/2`.

**Exercício 15**. Escreva uma regra para o predicado `sao_vizinhos_de(Esq, Dir, Meio)`, que indica que `Esq` e `Dir` são os vizinhos à esquerda e à direita de `Meio`, respectivamente.

**Exercício 16**. Escreva uma regra para o predicado `adjacente(X, Y)`, que indica se `X` e `Y` estão sentados um ao lado do outro.

**Exercício 17**. Escreva uma regra para o predicado `esta_na_ponta(X)`, que indica que `X` está em uma das cabeceiras da mesa. Dica: mesmo quem está na cabeceira é vizinho de alguém.

Observação: é seguro usar `not(G)` quando:

- G está completamente instanciado quando `not(G)` é processado, ou
- G possui variáveis não instanciadas, mas elas não aparecem em outros lugares na cláusula.

Vamos entender os conceitos de instanciação/unificação em outra aula.

Exercício extra: [movie database](http://swish.swi-prolog.org/example/movies.pl).

## Referências:

- [Introdução à Programação Prolog](http://jeiks.net/wp-content/uploads/2013/06/prolog-palazzo.pdf), Luiz Palazzo.
- Prolog programming: a do-it-yourself course for beginners.
