---
layout: page
title:  "Resumo de Scheme"
categories: aula
---


Programas em Scheme são s-expressões, que podem ser um átomo ou uma lista.

`1` é um átomo, `casa` é um átomo... 

Uma lista é representada como `(s1 s2 s3 ... sn)`, onde `s1`...`sn` são s-expressões.

Se você escrever `(1 2 3)` no interpretador Scheme, isso é um programa que resulta em erro, pois o interpretador tenta executar a função `1` passando `2` e `3` como parâmetros.

Para tratar uma s-expressão como dado (e não como programa), use `(quote sexp)` ou `'sexp`, onde `sexp` é uma s-expressão.

Assim, `'(1 2 3)` representa a lista com três elementos, os números 1, 2 e 3.

As listas em Scheme geralmente representam chamada de função. Uma lista `(f p1 p2 ... pn)` corresponde à chamada da função `f` com os parâmetros `p1`, `p2` ... `pn`.

Algumas funções:


`(car lista)` <br/>
retorna a cabeça da lista

`(cdr lista)`<br/>
retorna a cauda da lista

`(cons elem lista)`<br/>
retorna uma cópia da lista com o elemento elem inserido no início da lista

`(equal? x y)`<br/>
retorna `#t` se `x` e `y` forem iguais, `#f` caso contrário
OBS.: Existe o `(= x y)`, que só funciona com números

`(cond (p1 e1) (p2 e2) ...)`<br/>
corresponde ao if/else-if. Retorna o ei correspondente ao primeiro pi que retornar verdadeiro.
O último predicado pode ser a palavra else. Exemplo:

```
(cond
  ((= 1 2) 5)
  ((= 1 2) 8)
  (else 19))
```

(lambda (p1 ... pn) exp)
define uma função anônima que recebe os parâmetros p1 ... pn e retorna exp.

`(define (f p1 ... pn) exp)`
define a função f, que recebe os parâmetros p1 ... pn e retorna exp.

`(f p1 ... pn)`
chama a função f passando os parâmetros p1 ... pn.


Operadores aritméticos: (+ 2 3)     (* 5 1.5)
Operadores lógicos: (and x y)   (or x y)    (not x)


Função (imc peso altura), que calcula o IMC de uma pessoa, igual ao seu peso dividido pelo quadrado de sua altura.







