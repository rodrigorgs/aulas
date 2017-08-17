---
layout: page
title:  "JavaScript: Currying"
date:   2017-03-10 16:40:00 -0300
categories: aula
---

# Programação funcional

## Currying

**Currying** é o processo de transformar uma função que espera vários argumentos em uma que, quando chamada com menos argumentos, retorna uma nova função que recebe os argumentos restantes.

**Aplicação parcial** de uma função corresponde a chamar a função passando menos argumentos do que a função recebe.

A aplicação parcial de uma função que sofreu currying resulta em uma outra função.

Considere a função `produto`:

```javascript
function produto(a, b) {
    return a * b;
}
```

Do jeito que a função está definida, não faz sentido realizar uma aplicação parcial:

<textarea class="code">
function produto(a, b) {
    return a * b;
}
var dobro = produto(2);
console.log(dobro);
</textarea>

A chamada `produto(2)` equivale à chamada `produto(2, undefined)`, resultado na multiplicação `2 * undefined`, cujo resultado é `NaN` (not a number).

Uma versão **curried** da função (i.e., função resultante do currying) pode ser escrita usando-se *closures*:

<textarea class="code">
function produto(a) {
    return function(b) {
        return a * b;
    };
}
var dobro = produto(2);
console.log(dobro(8));
console.log(produto(2)(8));
</textarea>

Vamos praticar? Considere a seguinte função de 3 argumentos, que calcula o valor de uma função de primeiro grau em determinado ponto:

<textarea class="code">
function primeiroGrau(a, b, x) {
    return a * x + b;
}
// calcula f(42) para f(x) = 3*x + 2
console.log(primeiroGrau(3, 2, 42));
</textarea>

Vamos escrever uma versão *curried* dessa função? Essa versão deve receber `a` e retornar uma função que recebe `b`, que retorna uma função que recebe `x` e retorna a resposta.

<textarea class="code">
function primeiroGrauCurried(a) {
    return function(b) {
        // --- Escreva aqui seu código
        return ...;
        // ---
    };
}
var resultado = primeiroGrauCurried(3)(2)(42);
console.log(resultado);
</textarea>

Dá pra ver que, na versao curried, a maneira de chamar a função fica diferente: usamos `(3)(2)(42)` em vez de `(3, 2, 42)`. Isso porque cada chamada exceto a última retorna uma função, e por precisamos fazer 3 chamadas em vez de uma.

A vantagem de escrever uma função *curried* é que fica mais fácil construir funções com base nas funções curried fixando alguns argumentos. Por exemplo, a função `celsiusParaFahrenheit` pode ser escrita assim:

<textarea class="code">
function primeiroGrauCurried(a) {
  // ... - implemente
}
var celsiusParaFahrenheit = primeiroGrauCurried(1.8)(32);
console.log(celsiusParaFahrenheit(25));
</textarea>

Até agora nós realizamos o currying the funções de forma manual, reescrevendo o código das funções. Em algumas linguagens, como Haskell, todas as funções são curried (e, portanto, admitem aplicação parcial). Isso não acontece com Javascript, mas há bibliotecas capazes de realizar o currying de qualquer função.

A biblioteca [Ramda](http://ramdajs.com/) possui uma função, `R.curry`, que recebe uma função e retorna uma versão curried dessa função.

A biblioteca possui outras funções, como `R.map`, `R.filter`, `R.reduce` e `R.length`. Todas as funções da biblioteca Ramda já são curried e, portanto, admitem aplicação parcial.

O currying feito pela biblioteca Ramda é mais sofisticado, pois permite uma aplicação parcial com um, dois ou mais argumentos, retornando uma função que recebe os argumentos restantes:

<textarea class="code">
function primeiroGrau(a, b, x) {
  return a * x + b;
}
var primeiroGrauCurried = R.curry(primeiroGrau);
var celsiusToFahrenreit = primeiroGrauCurried(1.8)(32);
// forma equivalente:
var celsiusToFahrenreit2 = primeiroGrauCurried(1.8, 32);
// chamada:
console.log(celsiusToFahrenreit2(25));
// outro exemplo
console.log(primeiroGrauCurried(1.8, 32)(25));
</textarea>

Currying é útil em conjunção de funções de alta ordem. Considere a função `arr.map(f)`, que retorna um array resultante da aplicação da função `f` a cada elemento de `arr`. A função `map` chama `f` passando um único argumento; como podemos então usar nossa função `primeiroGrau` para mapear elementos de um array? Usando currying:

<textarea class="code">
function primeiroGrau(a, b, x) {
  return a * x + b;
}
var primeiroGrauCurried = R.curry(primeiroGrau);
var celsius = [10, 15, 20, 25, 30, 35];
var fahrenreit = celsius.map(primeiroGrauCurried(1.8, 32));
console.log(fahrenreit);

// outra opção é usar a função `partial`, que faz aplicação
// parcial em qualquer função (mesmo que não tenha sido curried)
fahrenreit = celsius.map(R.partial(primeiroGrau, [1.8, 32]));
console.log(fahrenreit);

</textarea>

Se você quer criar funções que podem ser curried, vale a pena pensar na ordem dos seus argumentos. O ideal é deixar concentrar os argumentos que tendem a ser fixados no início, e deixar os argumentos que variam mais no final da lista de argumentos. Note o exemplo da função `primeiroGrau(a, b, x)`: normalmente, quando chamamos a função várias vezes, fixamos `a` e `b` e variamos `x`; por isso `x` foi colocado como último argumento.

## Composição de funções

(Baseado em <https://medium.com/@collardeau/intro-to-functional-programming-concepts-in-javascript-b0650773139c> e <https://drboolean.gitbooks.io/mostly-adequate-guide/content/ch5.html>)

Considere o problema de obter a última inicial do nome de uma pessoa. Podemos decompor esse problema em dois: obter o último nome de uma pessoa e obter a primeira letra de um nome:

```javascript
function getUltimoNome(nomeCompleto) { return nomeCompleto.split(" ").splice(-1)[0]; }
function getPrimeiraLetra(string) { return string[0]; }
```

A função que retorna a última inicial de um nome pode então ser escrita como uma **composição** das funções `getUltimoNome` e `getPrimeiraLetra`:

<textarea class="code">
function getUltimoNome(nomeCompleto) { return nomeCompleto.split(" ").splice(-1)[0]; }
function getPrimeiraLetra(string) { return string[0]; }

function getUltimaInicial(nome) { return getPrimeiraLetra(getUltimoNome(nome)); }
console.log(getUltimaInicial("Sir Arthur Conan Doyle"));
</textarea>

Lembre-se do conceito de composição de funções da matemática: se eu tenho as funções f(x), g(x) e h(x), a composição dessas funções, na ordem apresentada, é uma nova função, c(x) = h(g(f(x))).

A biblioteca Ramda fornece uma função de alta ordem para compor duas ou mais funções quaisquer: `R.pipe`. No exemplo da matemática, c(x) = R.pipe(f, g, h). O exemplo da última inicial de um nome fica assim:

<textarea class="code">
function getUltimoNome(nomeCompleto) { return nomeCompleto.split(" ").splice(-1)[0]; }
function getPrimeiraLetra(string) { return string[0]; }

var getUltimaInicial = R.pipe(getUltimoNome, getPrimeiraLetra);
console.log(getUltimaInicial("Sir Arthur Conan Doyle"));
</textarea>

Esse estilo de programar é chamado de *pointfree*, pois a função `getUltimaInicial` é definida sem declarar quais são os seus parâmetros.

Agora é com você. Crie uma função para retornar a quantidade de elementos de um array cujo quadrado é ímpar. (Vamos ignorar o fato de que o quadrado de um número é ímpar se, e somente se o número é impar.)

<textarea class="code">
function comprimento(array) {
  return R.length(array);
}
function filtraImpar(array) {
  return R.filter(x => x % 2 == 1, array);
}
function quadrado(array) {
  return R.map(x => x * x, array);
}
// --- complete o código:
var qtdQuadradosImpares = R.pipe(/* complete o código */);
// ---
teste(4, qtdQuadradosImpares([2, 3, 5, 8, 13, 21]));
</textarea>

Na composição de funções, o retorno da primeira função é passado como parâmetro na chamada da segunda função, o retorno da segunda função é passado como parâmetro na chamada da terceira função, e assim por diante.

Na composição de funções, todas as funções a partir da segunda devem ser funções de um único parâmetro. Você sabe explicar por quê?

Vamos ver um exemplo agora em que a primeira função da composição recebe mais de um parâmetro.

<textarea class="code">
function soma(a, b) {
  return a + b;
}
function quadrado(num) {
  return num * num;
}

var f = R.pipe(soma, quadrado);

console.log(f(2, 3));
</textarea>

Por que a primeira função de uma composição pode ser uma função de dois ou mais parâmetros?

Vamos relembrar o exemplo anterior:

<textarea class="code">
function comprimento(array) {
  return R.length(array);
}
function filtraImpar(array) {
  return R.filter(x => x % 2 == 1, array);
}
function quadrado(array) {
  return R.map(x => x * x, array);
}
// --- complete o código:
var qtdQuadradosImpares = R.pipe(quadrado, filtraImpar, comprimento);
// ---
teste(4, qtdQuadradosImpares([2, 3, 5, 8, 13, 21]));
</textarea>

A função `filtraImpar` é uma função de um parâmetro; por isso ela pode ser usada como segunda função de uma composição. Essa função pode ser escrita de forma mais compacta usando aplicação parcial: `filtraImpar = R.filter(x => x % 2 == 1)` (note que R.filter é uma função curried, assim como todas as funções da biblioteca Ramda). Com essa observação, modifique o código abaixo, substituindo `/*...*/` por aplicações parciais de `R.map`, `R.filter` e `R.length`, de forma a obter o mesmo comportamento do código acima.

<textarea class="code">
// --- complete o código:
var qtdQuadradosImpares = R.pipe(/*...*/);
// ---
teste(4, qtdQuadradosImpares([2, 3, 5, 8, 13, 21]));
</textarea>

<textarea class="answer">
// --- complete o código:
var qtdQuadradosImpares = R.pipe(
  R.map(x => x * x),
  R.filter(x => x % 2 == 1),
  R.length);
// ---
teste(4, qtdQuadradosImpares([2, 3, 5, 8, 13, 21]));
</textarea>

A biblioteca Ramda também possui a função `compose`, que faz a mesma coisa que a função `pipe`, porém recebendo os argumentos na ordem inversa.

Exercícios: <https://drboolean.gitbooks.io/mostly-adequate-guide/content/ch5.html>

## Curiosidade

Pipes são extremamente úteis para escrever transformações de dados. Na linguagem R, uma biblioteca introduziu o operador de pipe, `%>%`, que é comumente usado para aplicar sequências de transformações sobre uma tabela. Para saber mais, leia [Simpler R coding with pipes > the present and future of the magrittr package](https://www.r-statistics.com/2014/08/simpler-r-coding-with-pipes-the-present-and-future-of-the-magrittr-package/).

## Exercício 1

Refatore o código para remover todos os argumentos através da aplicação parcial da função
Considere a função `wordsOriginal`, abaixo, e escreva a função equivalente `words`, através da aplicação parcial de `R.split`:

<textarea class="code">
var wordsOriginal = function(str) {
  return R.split(' ', str);
};
var words = ...;

teste(["Muito", "bem"], wordsOriginal("Muito bem"));
teste(["Muito", "bem"], words("Muito bem"));
</textarea>

<textarea class="answer">
var wordsOriginal = function(str) {
  return R.split(' ', str);
};
var words = R.split(' ');

teste(["Muito", "bem"], wordsOriginal("Muito bem"));
teste(["Muito", "bem"], words("Muito bem"));
</textarea>

## Exercício 1a

Use `map` para criar uma nova função, `wordsArray`, que aplica words a cada elemento da array de entrada.

<textarea class="code">
var words = ...;
var wordsArray = ...;

teste([["Muito", "bem"], ["Vamos", "continuar"]], wordsArray(["Muito bem", "Vamos continuar"]));
</textarea>

<textarea class="answer">
var wordsArray = R.map(R.split(' '));

teste([["Muito", "bem"], ["Vamos", "continuar"]], wordsArray(["Muito bem", "Vamos continuar"]));
</textarea>


## Exercício 2

A função `filterQs` recebe um array de palavras e retorna apenas as palavras que possuem a letra q. Crie uma versão pointfree dessa função, usando composição de funções parcialmente aplicadas:

<textarea class="code">
var filterQs = function(xs) {
  return R.filter(function(x) {
    return R.match(/q/i, x).length > 0;
  }, xs);
};

var filterQsPointfree = R.pipe(/* complete o código */);
teste(["quadrado", "ubíquo"], filterQs(["quadrado", "círculo", "ubíquo", "ok"]));
teste(["quadrado", "ubíquo"], filterQsPointfree(["quadrado", "círculo", "ubíquo", "ok"]));
</textarea>

<textarea class="answer">
var filterQs = function(xs) {
  return R.filter(function(x) {
    return R.match(/q/i, x).length > 0;
  }, xs);
};

var filterQsPointfree = R.filter(R.pipe(R.match(/q/i), R.length))
teste(["quadrado", "ubíquo"], filterQs(["quadrado", "círculo", "ubíquo", "ok"]));
teste(["quadrado", "ubíquo"], filterQsPointfree(["quadrado", "círculo", "ubíquo", "ok"]));
</textarea>

## Exercício 3

Use a função auxiliar `_mantemMaior` para criar uma versão pointfree de `max`:

<textarea class="code">
var _mantemMaior = function(x, y) {
  return x >= y ? x : y;
};

var max = function(xs) {
  return R.reduce(function(acc, x) {
    return _mantemMaior(acc, x);
  }, -Infinity, xs);
};

var maxPointfree = R.pipe(/* complete o código */);
teste(10, maxPointfree([3, -99, 10, 9]));
</textarea>

<textarea class="answer">
var _mantemMaior = function(x, y) {
  return x >= y ? x : y;
};

var max = function(xs) {
  return R.reduce(function(acc, x) {
    return _mantemMaior(acc, x);
  }, -Infinity, xs);
};

var maxPointfree = R.reduce(_mantemMaior, -Infinity);
teste(10, maxPointfree([3, -99, 10, 9]));
</textarea>

Baseado em <https://drboolean.gitbooks.io/mostly-adequate-guide/content/ch4.html>
