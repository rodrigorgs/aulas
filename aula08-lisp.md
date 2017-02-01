---
layout: page
title:  "LISP (introdução)"
date:   2017-02-01 16:40:00 -0300
categories: aula
---

# Programação funcional: Lisp (1958)

Programação simbólica, programação funcional.

Diversas implementações e dialetos: Common Lisp, Scheme, Racket, Clojure (roda na JVM e é usada pelo Twitter, Walmart e Netflix).

Usado como linguagem de script no AutoCAD, no Audacity (editor de áudio), no GIMP (editor de imagens) e no Emacs (editor de texto).

Características: tipificação dinâmica, garbage collector, funções como cidadãos de primeira classe, metaprogramação.

## Scheme

Nesta disciplina estudaremos a linguagem Scheme, que é um dialeto de Lisp.

## Lisp: teoria

Dados em Lisp são expressões simbólicas (chamadas de *s-expressions*, ou *sexps*, do inglês *symbolic expressions*) que podem ser **átomos** ou **listas**.

- Átomo: sequência de letras e dígitos e outros caracteres que não são usados em Lisp. Ex.: `1`, `altura`, `print`, `+`.
- Lista: `(` seguido de zero ou mais S-expressões separados por espaços, seguido de `)`. Exemplo: `(a)`, `(+ 2 3)`, `(display 5)`.

Expressões podem ser avaliadas para um valor. Em particular, alguns átomos possuem valor. Exemplos: `1` (número um), `-3.14` (número 3,14 negativo). Outros átomos, como `abc`, não possuem valor, a princípio.

Listas também podem ser avaliadas para valores. Em particular, um núcleo básico de Lisp pode ser definido a partir de regras de re-escrita de listas que seguem os seguintes padrões:

- `(quote x)` ou `'x` ==> `x`, isto é, o valor da lista `(quote x)` é `x`, onde `x` é uma s-expressão qualquer. Exemplo: `(quote abc)` ==> `abc`; `(quote (a b c))` ==> `(a b c)`
- `(car x)` ==> primeiro elemento da lista `x`. Exemplo: `(car (quote a b c))` ==> `a`
- `(cdr x)` ==> lista restante após remover primeiro elemento da lista `x`. Exemplo: `(cdr (quote (a b c)))` ==> `(b c)`
- `(cons x y)` ==> lista resultante de se adicionar o valor de `x` ao início da lista `y`. Exemplo: `(cons (quote a) (quote (b c)))` ==> `(a b c)`
- `(equal? x y)` ==> `#t` se `x` e `y` têm o mesmo valor; `#f` caso contrário.
- `(cond (p1 e1) (p2 e2) ...)` => valor de ei, onde pi é o primeiro dos ps cujo valor não é Nil.
- `((lambda (v1 ... vn) e) e1 ... en)` ==> valor de e em um ambiente no qual as variáveis v1 ... vn assumem os valores das expressões e1 ... en. Exemplo: `((lambda (x y) (cons (car x) y)) (quote (a b)) (quote (c d)))`
- `((define f (lambda ...) e1 .. en)` é o mesmo que lambda..., com a regra adicional que, sempre que a expressão `(f a1 ... an)` for avaliada, f é substituído por `(define f lambda...)`. Isso permite definir funções recursivas. Exemplo: `((define f (lambda (x) (cond ((atom x) x) ((quote t) (ff (car x)))))) (quote ((a b) c)))`

<!-- - `(atom x)` ==> `t` se `x` é um átomo; `Nil' caso contrário -->

Note, a princípio, uma lista não tem valor definido, a não ser se enquadre em um dos casos listados acima.

Exemplos e contra-exemplos:

- `abc` ==> valor indefinido. 
- `(quote abc)` ==> o valor é o símbolo abc
- `(teste 1 2 3)` ==> valor indefinido
- `(1 2 3)` => valor indefinido
- `(quote (1 2 3))` ==> o valor é a lista 1, 2, 3

Para evitar definir uma função toda vez que ela é usada, podemos defini-la usando `(define (f v1 ... vn) e)`. Depois disso, `(f x1 ... xn)` é avaliado através da avaliação de `e` com as variáveis v1 ... vn assumindo os valores x1 ... xn. Exemplo:

<textarea class="code lang-scheme">
; retorna o segundo elemento de uma lista
(define (segundo lista)
    (car (cdr lista)))
</textarea>

<textarea class="code lang-scheme">
(segundo
    (quote (a b c)))
</textarea>

Esse conjunto de regras define o núcleo da linguagem Lisp. Outras construções da linguagem podem ser definidas com base nessas regras.

## Abreviações comuns

- `'e` é equivalente a `(quote e)`. Exemplos: `'abc`, `'(1 2 3)`.
- `(list e1 ... en)` é equivalente a `(cons e1 (cons ... (cons en Nil)))`. Exemplo: `(list 1 2 3)` é equivalente a `(cons 1 (cons 2 (cons 3 Nil)))`, que é equivalente a `(quote (1 2 3))`, que é equivalente a `'(1 2 3)`.
- `(define (null x) (equal? x Nil))`
- `(define (and p q) (cond p q) (t Nil))`
    - também há definições para `not` e `or`
- `(define (cadr x) (car (cdr x)))`
    - `(define (caar x) (car (car x)))`
    - `(define (cadr x) (car (cdr x)))`
    - `(define (cdar x) (cdr (car x)))`
    - `(define (cddr x) (cdr (cdr x)))`
    - `(define (caaar x) (car (car (car x))))`
    - `(define (caadr x) (car (car (cdr x))))`
    - ...
- `(if cond expr1 expr2)` retorna expr1 se a condição é verdadeira, e expr2 caso contrário

## Manipulação de strings

- (length s): comprimento da string s. 
    - Ex.: `(length "Fulano")`
- (concat s1 ... sn): concatena as strings s1 ... sn.
    - Ex.: `(concat  "Alo"   ", "   "Mundo")`
- `(substring s inicio fim)`: retorna uma substring de s
    - Ex.: `(substring ">>Alo, Mundo" 2 5)`

Usamos aspas para representar strings. Exemplo: `"alo mundo"`.

## Números e matemática

- Operadores aritméticos: +, -, /, *, % (resto da divisão)
    - Ex.: `(+ 2 3)`, `(+ 2 (- 4 1))`, `(* 1 (+ 2 (/ 6 2)))`
    - Ex.: `(* 1 2 3 4)` (+ e * permitem mais de dois argumentos)
- Comparadores: <, >, <=, >=, =, /= (diferente)
    - Ex.: `(< 2 3)`, `(/= 5 (+ 2 3))`
- Funcões matemáticas: sin cos tan asin acos atan floor max min log abs ceil pow exp atan2 random sqrt round
    - Ex.: `(sin (/ (* 2 3.141592) 8))`, `(max 3 5)`

## Escopo

define let let*

- `define` define variáveis ou funções no escopo global, atribuindo-lhes um nome

```
(define (alo-mundo) (display "Alo, mundo!"))
```
```
(define (alo nome pontuacao)
    (display (concat "Alo, " nome pontuacao)))
```
```
(alo-mundo)
```
```
(alo "Brasil" "!!!")
```

- `def` define nomes para outros tipos de valores no escopo global

```
(define pi 3.14159265359)
```
```
(display (cos (* 2 pi)))
```

- `let` e `let*` especificam escopos temporários

Uso: `(let ((v1 e1) ... (vn en)) corpo)` -- avalia a expressão "corpo" usando as constantes v1 ... vn (com valores e1 ... en) definidas localmente.

```
(let
    ((pi 3.14159265359)
     (raio 30))
    (display (* pi raio raio)))
```

Se existir dependência entre as definições de constantes (isto é, pelo menos uma das constantes é definida com base em uma constante definida anteriormente), é necessário usar let*. Exemplo:

<textarea class="code lang-scheme">
; tente substituir let* por let pra ver se funciona
(let*
    ((pi 3.14159265359)
     (raio 30)
     (area (* pi raio raio)))
    (display area))
</textarea>




## Referências

- <http://www.scribd.com/doc/54050141/Micro-Manual-LISP> (1978)
- <http://www.jtra.cz/stuff/lisp/sclr/index.html>

<!-- - <http://kybernetikos.github.io/Javathcript/> (implementação usada nesta página) -->


<!-- 
- (display 132)  ;ou (write 123)
- (newline)
- (read)
- (console-log 213)
- (define (fname a1 a2 ...) body)
- #t, #f, #null
- equal? ou eq? (equal? funciona com listas)
- pode usar else no cond
- null?
- consp => pair?
- sequenciamento com (begin ...)
- mod

Referência: <http://jscheme.sourceforge.net/jscheme/doc/R4RSprimitives.html>


Material legal: https://people.eecs.berkeley.edu/~bh/ssch8/higher.html

No repl.it só correção manual (com Scheme)!


(define (map f l)
  (display l)
  (cond
    ((null? l) '())
    (#t (cons (f (car l)) (map f (cdr l))))))

(map (lambda (x) (* x 2)) '(1 2 3 4))

 -->