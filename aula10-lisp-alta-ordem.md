---
layout: page
title:  "Lisp (funções de alta ordem)"
date:   2017-02-15 16:40:00 -0300
categories: aula
---

## Revisão

Escreva a função `(todos-pares l)`, que indica que todos os elementos da lista `l` são números pares. Observações:

- Use a função `(par x)` definida na questão.
- Use `(null? l)` para testar se a lista `l` é vazia. 
- Em uma lista vazia, todos os elementos são pares.
- A resposta está nó código-fonte da página.

<textarea class="code lang-scheme">
(define (todos-pares l)
  ...)
; testes
(define (par x) (= (mod x 2) 0))

(teste #t (todos-pares '()))
(teste #t (todos-pares '(2 4 6)))
(teste #f (todos-pares '(1 2 4 6)))
</textarea>

<!-- 
(define (todos-pares l)
  (cond
    ((null? l) #t)
    (else (and (par (car l)) (todos-pares (cdr l))))))
 -->

## Funções de alta ordem

E se você quisesse saber se todos os elementos de uma lista são ímpares? Ou se todos são menores que 20? Ou se todos são primos? Será que é necessário criar uma função para cada condição (`todos-impares`, `todos-menores-que` etc.)?

Note que a condição pode ser representada por uma função. Scheme é uma linguagem funcional, na qual funções são **cidadãos de primeira classe**, ou seja, funções podem ser atribuídas a variáveis e constantes, podem ser passadas como parâmetros ou retornadas de uma função. Com isso, podemos generalizar a função `(todos-pares lista)` para "(todos condicao lista)", onde `condicao` é uma função que recebe um elemento da lista e retorna `#t` ou `#f`.

Uma função é dita de **alta ordem** se recebe uma função como parâmetro ou retorna uma função. Funções de alta ordem só podem ser construídas em linguagens nas quais funções são cidadãos de primeira classe.

## Função all (todos)

(Também conhecida como `every`.)

Implemente a função `(all f l)`, que retorna verdadeiro se, e somente se, a lista é vazia ou a função `f` retorna verdadeiro para todos os elementos de `l`:

<textarea class="code lang-scheme">
(define (all f l)
  (cond
    ((null? l) #t)
    (else ...)))
; testes
(define (par x) (= (mod x 2) 0))
(teste #t (all par '()))
(teste #t (all par '(2 4 6)))
(teste #f (all par '(1 2 4 6)))
; você também pode usar funções anônimas (funções lambda)
(teste #t
  (all
    (lambda (x) (< x 10))
    '(8 5 9 3)))
</textarea>

<!-- 
(define (all f l)
  (cond
    ((null? l) #t)
    (else (and (f (car l)) (all f (cdr l))))))
 -->

## Reimplemente todos-pares

Reimplemente a função todos-pares para usar a função `all`.

<textarea class="code lang-scheme">
(define (todos-pares l) (all ...))
; testes
(define (par x) (= (mod x 2) 0))
(teste #t (todos-pares '()))
(teste #t (todos-pares '(2 4 6)))
(teste #f (todos-pares '(1 2 4 6)))
</textarea>

## Função any

(Também conhecida como `exists`.)

Implemente a função `(any f l)` (indica se a função `f` retorna verdadeiro para algum elemento de l):

<textarea class="code lang-scheme">
(define (any f l)
  ...)
; testes
(define (par x) (= (mod x 2) 0))
(teste #f (any par '()))
(teste #f (any par '(1 3 5)))
(teste #t (any par '(1 3 6 9)))
</textarea>

<!-- 
(define (any f l)
  (cond
    ((null? l) #f)
    (else (or (f (car l)) (any f (cdr l))))))
 -->

## Função map

(Também conhecida como `collect`.)

A função `(map f l)` retorna uma cópia da lista `l` na qual cada elemento, `x`, é substituído por `(f x)`.

OBS.: Use a função `(cons elem lista)` para construir uma lista cujo primeiro elemento é `elem`.

<textarea class="code lang-scheme">
(define (map f l)
  ...)

(define (dobro n) (* n 2))

; testes
(teste '() (map dobro '()))
(teste '(6) (map dobro '(3)))
(teste '(6 6) (map dobro '(3 3)))
(teste '(2 4 6 8 10) (map dobro '(1 2 3 4 5)))
</textarea>

<!-- 
(define (map f l)
  (cond
    ((null? l) '())
    (else (cons (f (car l)) (map f (cdr l))))))
 -->

## Função filter

(Também conhecida como `select`.)

Implemente a função `(filter f l)` (retorna uma cópia da lista `l` contendo apenas os elementos para os quais a função `f` retorna `#t`). Use `cons`.

<!-- 
; em Scheme:
(define (filter f l)
  (cond
    ((null? l) l)
    ((f (car l)) (cons (car l) (filter f (cdr l)) ) )
    (else (filter f (cdr l)))))
 -->

<textarea class="code lang-scheme">
(define (filter f l)
  (cond
    ((null? l) l)
    ((f (car l)) (cons (car l) (filter f (cdr l)) ) )
    (else (filter f (cdr l)))))
; testes
(teste '(3 6 9)
  (filter
    (lambda (x) (< x 10))
    '(3 12 6 15 9)))
</textarea>

<a href="javascript:alert('Considere três casos: lista vazia, lista cujo primeiro elemento satisaz à função f, e lista cujo primeiro elemento não satisfaz à função f.')">dica</a>

## Função reduce

(Também conhecida como `fold`, `foldr` ou `fold-right`.)

Função `(reduce f x l)` (aplica a função `f` sobre um acumulador para cada valor da lista `l`, para reduzi-la a um único valor; o valor inicial do acumulador é `x`).

Exemplo:

`(reduce + 0 '(1 2 3))` calcula `(+ 1 (+ 2 (+ 3 0)))`.

<textarea class="code lang-scheme">
; Já está implementada abaixo; se quiser testar
; seus conhecimentos, apague e reescreva.
(define (reduce f x l)
  (cond
    ((null? l) x)
    (else (f (car l) (reduce f x (cdr l))))))
; testes
(teste 6 (reduce + 0 '(1 2 3)))
(teste 0 (reduce + 0 '()))
</textarea>

## Reescreva

Reescreva as funções `all` e `any` usando `reduce`.

<!-- https://www.quora.com/What-is-tail-recursion-Why-is-it-so-bad -->

