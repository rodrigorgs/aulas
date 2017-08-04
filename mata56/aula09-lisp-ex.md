---
layout: page
title:  "Scheme (prática)"
date:   2017-02-08 16:40:00 -0300
categories: aula
---

# Exercícios

Agora é com você. Defina as funções a seguir.

A função `(teste esperado obtido)` já foi definida para sua conveniência. Essa função compara o resultado `esperado` com o resultado `obtido` e mostra o resultado da comparação no console do navegador (`Ctrl+Shift+I` > `Console`).

## Função maior-de-idade

Função `(maior-de-idade idade)`, que indica se um indivíduo com determinada `idade` já atingiu ou não a maioridade penal no Brasil.

<textarea class="code lang-scheme">
(define (maior-de-idade idade) ...)
; testes
(teste #t (maior-de-idade 25))
(teste #f (maior-de-idade 15))
</textarea>

<textarea class="answer">
(define (maior-de-idade idade) (>= idade 18))
(teste #t (maior-de-idade 25))
(teste #f (maior-de-idade 15))
</textarea>

## Função IMC

Função `(imc peso altura)`, que calcula o IMC de uma pessoa, igual ao seu peso dividido pelo quadrado de sua altura.

<textarea class="code lang-scheme">
(define (imc peso altura) ...)
; testes
(teste 23.148148148148145 (imc 75 1.80))
(teste 30.864197530864196 (imc 100 1.80))
(teste 15.495867768595039 (imc 75 2.20))
</textarea>

<textarea class="answer">
(define (imc peso altura) (/ peso (* altura altura)))
; testes
(teste 23.148148148148145 (imc 75 1.80))
(teste 30.864197530864196 (imc 100 1.80))
(teste 15.495867768595039 (imc 75 2.20))
</textarea>

## Função obesidade

Função `(obesidade peso altura)`, que retorna `'abaixoDoPeso` se o IMC é menor que 20, `'neutro` se o IMC está entre 20 e 30, e `'obeso` se o IMC é maior que 30.

<textarea class="code lang-scheme">
(define ...)
; testes
(teste 'abaixoDoPeso (obesidade 40 1.80))
(teste 'neutro (obesidade 75 1.80))
(teste 'obeso (obesidade 100 1.80))
</textarea>

<textarea class="answer">
(define (imc peso altura) (/ peso (* altura altura)))
(define (obesidade peso altura)
  (let ((indice (imc peso altura)))
    (cond
     ((< indice 20) 'abaixoDoPeso)
     ((<= indice 30) 'neutro)
     (else 'obeso))))
; testes
(teste 'abaixoDoPeso (obesidade 40 1.80))
(teste 'neutro (obesidade 75 1.80))
(teste 'obeso (obesidade 100 1.80))
</textarea>

# Funções recursivas

## Função fib

Função `(fib n)` (retorna o n-ésimo elemento da sequência de Fibonacci). Use recursão.

<textarea class="code lang-scheme">
(define (fib n) ...)
; testes
(teste 1 (fib 1))
(teste 1 (fib 2))
(teste 2 (fib 3))
(teste 3 (fib 4))
(teste 5 (fib 5))
(teste 8 (fib 6))
</textarea>

## Função compr

Função `(compr l)` (retorna o comprimento da lista l, isto é, seu número de elementos). Use recursão.

<textarea class="code lang-scheme">
(define ...)
; testes
(teste 0 (compr '()))
(teste 1 (compr '(1)))
(teste 3 (compr '(1 2 3)))
</textarea>

<textarea class="answer">
(define (compr l)
  (cond
    ((null? l) 0)
    (else (+ 1 (compr (cdr l))))))
; testes
(teste 0 (compr '()))
(teste 1 (compr '(1)))
(teste 3 (compr '(1 2 3)))
</textarea>

## Função member

Função `(member x l)` (indica se o elemento x está presente na lista l):

<textarea class="code lang-scheme">
codigo
</textarea>

<textarea class="answer">
(define (member x l)
  (cond
    ((null? l) Nil)
    ((equal? (car l) x) #t)
    (#t (member x (cdr l)))))

(teste #t (member 2 '(1 2 3 4)))
</textarea>

## Função is-set

Função `(is-set l)` (indica se l é um conjunto, isto é, uma lista na qual todos os elementos são distintos) -- use a função member:

<!-- 
(define (is-set l) 
  (cond
    ((equal? l '()) #t)
    (else
      (and
        (is-set (cdr l))
        (not (member (car l) (cdr l)))))))
 -->

<textarea class="code lang-scheme">
; testes
(teste #t (is-set '()))
(teste #t (is-set '(1)))
(teste #t (is-set '(1 2 3)))
(teste #f (is-set '(1 1 2)))
(teste #f (is-set '(1 2 1)))
(teste #f (is-set '(1 2 3 2 5)))
</textarea>

<textarea class="answer">
(define (is-set l) 
  (cond
    ((equal? l '()) #t)
    (else
      (and
        (is-set (cdr l))
        (not (member (car l) (cdr l)))))))
; testes
(teste #t (is-set '()))
(teste #t (is-set '(1)))
(teste #t (is-set '(1 2 3)))
(teste #f (is-set '(1 1 2)))
(teste #f (is-set '(1 2 1)))
(teste #f (is-set '(1 2 3 2 5)))
</textarea>

## Função freq

Função `(freq x l)` (indica quantas vezes o elemento x aparece na lista l):

<textarea class="code lang-scheme">
(define ...)
; testes
; ...
</textarea>

<textarea class="answer">
(define (freq x l)
  (cond
    ((null? l) 0)
    ((equal? (car l) x) (+ 1 (freq x (cdr l))))
    (#t (freq x (cdr l)))))
; testes
(teste 2 (freq 'b '(a b a b)))
</textarea>

# Mais funções

## Função qtd-pares

A função `(qtd-pares l)` retorna a quantidade de elementos pares na lista `l`.

<textarea class="code lang-scheme">
(define ...)
; testes
; ...
</textarea>

## Função dobra-tudo

Função `(dobra-tudo l)` retorna uma lista em que cada elemento é o dobro do elemento correspondente da lista `l`:

<textarea class="code lang-scheme">
(define ...)
; testes
; ...
</textarea>

## Função filtra-pares

A função `(filtra-pares l)` retorna uma lista igual à lista `l` removendo-se os elementos ímpares:

<textarea class="code lang-scheme">
(define ...)
; testes
; ...
</textarea>

## Função todos-pares

A função `(todos-pares l)` retorna verdadeiro se e somente se todos os elementos da lista `l` são números pares.

<textarea class="code lang-scheme">
(define ...)
; testes
; ...
</textarea>
