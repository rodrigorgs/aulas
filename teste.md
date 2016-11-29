---
layout: page
title:  "Teste"
date:   2016-10-07 16:40:00 -0300
---

O **contexto** ou **ambiente de referenciamento** de uma região de um programa corresponde ao conjunto de vinculações que pode-se acessar naquela região. Vejamos o exemplo anterior:

```javascript
var glob = 123;     // 1
console.log(glob);  // 2
function teste() {  // 3
    var x = 2;      // 4
    console.log(x); // 5
}                   // 6
glob = 456;         // 7
```

O ambiente de referenciamento da linha 7 corresponde às variáveis `glob` e `teste` (e, naturalmente, outras variáveis definidas globalmente pelo browser, a exemplo de `window` e `console`). O ambiente de referenciamento da linha 5 contém todas essas variáveis e mais a variável `x`.

## Regras de escopo de Javascript

Considere agora o exemplo a seguir. O que acontecerá quando a linha 8 for executada? Vai dar erro? Para responder a essa pergunta, devemos descobrir se a variável `xext` faz ou não faz parte do ambiente de referenciamento da linha 8 (e da função `interna`, em geral). Faça suas apostas e execute o código.

<textarea class="code">
function showRandom() {
  console.log(Math.random() + 1.0);	
}
showRandom();
</textarea>

## Exemplo em Scheme

<textarea class="code lang-scheme">
(define (alo nome) (display "Alo") (display " ") (display nome) (newline))
(alo "Mundo")
(+ 1 2)
</textarea>

## Exemplo em Ruby

<textarea class="code lang-ruby">
def alo(nome)
  puts "alo #{nome}"
end

alo 'mundo'
1 + 2
</textarea>

## Exemplo em Ruby com sintaxe melhorada

{:.editor}

```ruby
def alo(nome)
  puts "alo #{nome}"
end

alo 'mundo'
1 + 2
```

