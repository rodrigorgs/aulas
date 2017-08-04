---
layout: page
title:  "Scheme (recursão profunda)"
date:   2017-02-17 16:40:00 -0300
categories: aula
---

# Programação funcional

## Recursão profunda

Até agora temos trabalhado com listas de átomos, usando recursão para processar seu conteúdo. Definimos como **lista profunda** uma lista que contém outras listas. Listas profundas podem ser pensadas como árvores. Exemplo:

<!-- https://www.cs.bham.ac.uk/research/projects/poplog/paradigms_lectures/lecture9.html -->

```
(a ((b c)) (d (e (f))) g)
```

```
       (a ((b c)) (d (e (f))) g)
                 |
----------------------------------------
|         |              |             |
a      ((b c))      (d (e (f)))        g
          |              |
          |          ----------
          |          |        |
        (b c)        d     (e (f))
          |                   |
       ------             --------
       |    |             |      |
       b    c             e     (f)
                                 |
                                 f
```

Para explorar a árvore completamente, é preciso usar **recursão profunda**. O função usa recursão profunda quando chama a si própria recursivamente no *car* e no *cdr* da lista.

## Implementação de recursão profunda em Scheme

Para implementar funções com recursão profunda, devemos considerar as características da lista passada como parâmetro para a função. Considere a função `(conta-prof x lista)`, que indica o número de ocorrências de `x` na lista `lista`, que pode ou não ser profunda.

Consideramos três casos:

- **a lista é vazia** (caso base): retorna 0.
- **o primeiro elemento da lista é uma lista não-vazia**: nesse caso, devemos contar o número de ocorrências de `x` no primeiro elemento da `lista` (que é uma lista) e na cauda da `lista`. O total de ocorrências vai ser a soma desses dois números.
- **o primeiro elemento da lista é um átomo**: nesse caso, usamos uma lógica parecida com a usada na contagem de elementos em listas não-profundas:
    - se o primeiro elemento é igual a `x`, retornamos 1 + número de ocorrências de `x` na cauda da `lista`.
    - se o primeiro elemento é diferente de `x`, retornamos o número de ocorrências de `x` na cauda da `lista`.

**IMPORTANTE!!!**: Para checar se `x` é uma lista não-vazia, use `(pair? x)` (retorna `t` somente se `x` for uma lista não-vazia).

## Exemplo: conta-prof

Implemente a função `(conta-prof x lista)`, que indica o número de ocorrências de `x` na lista `lista`, que pode ou não ser profunda.

<textarea class="code lang-scheme">
(define (conta-prof x lista)
  (cond
    ; lista vazia
    ((null? lista) ...)
    ; 1o elem é uma lista não-vazia
    ((pair? (car lista)) ...)
    ; 1o elemento é um átomo igual a x
    ((equal? x (car lista)) ...)
    ; 1o elemento é um átomo diferente de x
    (else ...)))

; testes
(teste 0 (conta-prof 'j '(c ((b a)) (d (e (c))) g)))
(teste 2 (conta-prof 'c '(c ((b a)) (d (e (c))) g)))
</textarea>

<textarea class="answer">
(define (conta-prof x lista)
  (cond
    ; lista vazia
    ((null? lista) 0)
    ; 1o elem é uma lista não-vazia
    ((pair? (car lista))
      (+ (conta-prof x (car lista))
         (conta-prof x (cdr lista))))
    ; 1o elemento é um átomo igual a x
    ((equal? x (car lista)) 
      (+ 1 (conta-prof x (cdr lista)))) 
    ; 1o elemento é um átomo diferente de x
    (else (conta-prof x (cdr lista)))))

; testes
(teste 0 (conta-prof 'j '(c ((b a)) (d (e (c))) g)))
(teste 2 (conta-prof 'c '(c ((b a)) (d (e (c))) g)))
</textarea>


## Exemplo: membro-prof

Implemente a função `(membro-prof x lista)`, que indica se `x` aparece na expressão `lista`, que pode ou não ser profunda.

<textarea class="code lang-scheme">
(define (membro-prof x lista)
  (cond
    ; lista vazia
    (... ...)
    ; 1o elem é uma lista não-vazia
    (... ...)
    ; 1o elemento é um átomo igual a x
    (... ...)
    ; 1o elemento é um átomo diferente de x
    (... ...)))

; testes
(teste #f (membro-prof 5 '(1 2 3)))
(teste #t (membro-prof 5 '(1 2 3 (4 5))))
(teste #t (membro-prof 5 '(1 2 (3 (5 4)))))
(teste #f (membro-prof '() '(1 2 3)))
(teste #t (membro-prof '() '(1 () 2 3)))
(teste #t (membro-prof '() '(())))
</textarea>

<textarea class="answer">
(define (membro-prof x lista)
  (cond
    ; nenhum átomo é membro da lista vazia
    ((null? lista) #f)
    ; 1o elemento é uma lista não-vazia
    ((pair? (car lista))
      (or (membro-prof x (car lista))
          (membro-prof x (cdr lista))))
    ; 1o elemento é um átomo
    (else
      (or (equal? (car lista) x)
          (membro-prof x (cdr lista))))))

(teste #f (membro-prof 5 '(1 2 3)))
(teste #t (membro-prof 5 '(1 2 3 (4 5))))
(teste #t (membro-prof 5 '(1 2 (3 (5 4)))))
(teste #f (membro-prof '() '(1 2 3)))
(teste #t (membro-prof '() '(1 () 2 3)))
(teste #t (membro-prof '() '(())))
</textarea>

## Dica

Note que as duas funções de recursão profunda são muito parecidas. O que muda de uma pra outra:

- o valor retornado no caso base (`0` vs. `#f`)
- a função usada para combinar os dois valores retornados pela chamada recursiva (`+` vs. `or`)

## Exemplo: subst

Crie uma função, `(subst x y expr)`, que substitui as oorrências de `x` por `y` na expressão `expr`, usando recursão profunda.

Antes de implementar, responda: que função você vai usar para combinar os resultados das chamadas recursivas? 

<textarea class="code lang-scheme">
(define (subst x y lista)
  ...)

(teste '(0 (0 3 (5 0))) (subst 1 0 '(1 (1 3 (5 1)))))
</textarea>

<textarea class="answer">
(define (subst x y lista)
  (cond
    ; lista vazia
    ((null? lista) '())
    ; 1o elemento da lista é uma lista
    ((pair? (car lista))
      (cons (subst x y (car lista)) (subst x y (cdr lista))))
    ; 1o elemento da lista é um átomo igual a x
    ((equal? (car lista) x)
      (cons y (subst x y (cdr lista))))
    ; 1o elemento da lista é um átomo diferente de x
    (else
      (cons (car lista) (subst x y (cdr lista))))))

(teste '(0 (0 3 (5 0))) (subst 1 0 '(1 (1 3 (5 1)))))
</textarea>

## Exemplo: flatten

Crie uma função, `(flatten lista)`, que "achata" a lista, isto é, retorna uma lista de átomos com a mesma sequência de átomos da lista profunda `lista`. 


<textarea class="code lang-scheme">
(define (flatten lista)
  ...)

(teste '(1 2 3 4 5 6 7) (flatten '(1 ((2 3) (4 (5)) 6) 7)))

</textarea>

<!--
Escreva uma função que remove apenas a primeira ocorrência do átomo em uma estrutura de lista profunda.

Escreva uma função que substitui todas as ocorrências do átomo old por um átomo new em uma estrutura de lista profunda.

Escreva uma função que inverte todos os elementos de uma lista genérica (versão genérica de inverte / reverse) 
-->
