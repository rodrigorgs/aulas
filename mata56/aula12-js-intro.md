---
layout: page
title:  "JavaScript: Introdução e funções de alta ordem"
date:   2017-03-03 16:40:00 -0300
categories: aula
---

# JavaScript: Introdução e funções de alta ordem

JavaScript (JS) é uma linguagem de programação dinâmica, de tipificação fraca e interpretada. Ela foi criada em 1995 pela Netscape Communications, empresa que desenvolveu um dos primeiros navegadores web. Mais tarde, a linguagem foi formalizada na especificação ECMAScript (ES), que vem evoluindo desde então. No momento em que este texto foi escrito, a versão mais recente da especificação é a ECMAScript 2016 (anteriormente conhecida como ECMAScript 7), mas mesmo o ECMAScript 2015, ou [ECMAScript 6](http://es6-features.org/) não é suportado completamente por todos os navegadores. Projetos como o [Babel](http://babeljs.io/) permitem transformar código de uma versão mais recente para uma versão mais antiga da especificação.

## Estruturas básicas

### Strings

Strings podem ser escritas com `"`, `'` ou `` ` ``. Em qualquer caso, você pode usar a barra invertida (`\`) para "escapar" um caractere que do contrário teria um significado especial. Exemplo:

<textarea class="code">
// A função console.log escreve algo no console do navegador.
console.log("Use \\ para \"escapar\" caracteres especiais.");
</textarea>

Apenas as strings com acento grave (`` ` ``) permitem interpolação de strings:

<textarea class="code">
let nome = 'Fulano';
let idade = 18;

console.log(`O aluno ${nome} tem ${idade} anos.`);
</textarea>

Se o `let` e o `` ` `` não funcionarem, seu navegador pode estar desatualizado. Você pode conseguir rodar trocando por `var` e `"` (embora o resultado não seja exatamente igual).

### Tópico opcional: diferença entre let e var

JavaScript originalmente não permitia declarar variáveis com escopo de bloco; assim, todas as declarações de variáveis feitas com `var` são movidas para o início da função, o que é conhecido como *hoisting*.

Alguns exemplos (experimente trocar `var` por `let` e vice-versa e veja como o comportamento muda):

<textarea class="code">
if (true) {
  var x = 1;
}
console.log(x);
</textarea>

<textarea class="code">
function abc() {
  x = 1;
  var x = 3;
  console.log(x);
}
abc();
</textarea>

### Objetos

Objetos em JavaScript são estruturas chave-valor, similar a estruturas que em outras linguagens são chamadas de hash, mapa ou dicionário. As chaves são chamadas propriedades do objeto. Exemplo:

<textarea class="code">
// Objeto pessoa com duas propriedades: nome e idade.
let pessoa = {
    nome: 'Fulano',
    idade: 18
};

// Acessando propriedades (duas formas equivalentes)
console.log(pessoa.nome);
console.log(pessoa['nome']);

// Alterando propriedades
pessoa.nome = 'Sicrano';
console.log(pessoa.nome);
console.log(pessoa['nome']);
</textarea>

Para saber mais: [Working with objects (Mozilla Developer Network)](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Working_with_Objects).

### Arrays

Um array em Javascript (ex.: `[1, 2, 3]`) é um objeto **mutável**, isto é, ele pode ser modificado. As funções que modificam o array são chamadas de funções **destrutivas**. As funções não-destrutivas são aquelas que não modificam o array; em vez disso, elas retornam um novo array que é construído a partir de um array pré-existente.

Do ponto de vista das linguagens funcionais, uma função deve apenas receber valores como parâmetro e retornar um valor. Se a função modifica algum parâmetro, altera variáveis globais, ou acessa entrada/saída (ex.: modifica um arquivo), esses comportamentos são considerados **efeitos colaterais** de se chamar a função, e a função é dita **não-pura**. 

Uma função pura, sem efeitos colaterais, vai sempre retornar o mesmo resultado para uma determinada entrada, não importa quantas vezes a função seja chamada.

A seguir, algumas operações sobre arrays. Nos exemplos, considere que `a` é um array.

|         Operação         |  destrutiva |    não-destrutiva   |
|--------------------------|-------------|---------------------|
| Obter primeiro elemento  |             | `x = a[0]`          |
| Obter restante da lista  | `a.shift()` | `l = a.slice(1)`    |
| Adicionar x ao final     | `a.push(x)` | `l = a.concat([x])` |
| Comprimento do array     |             | `x = a.length`      |
| Criar uma cópia da lista |             | `l = a.slice()`     |

### Funções como cidadãos de primeira classe

Como já vimos, JavaScript é uma linguagem na qual funções são cidadãos de primeira classe, isto é, elas podem ser atribuídas a variáveis, passadas como parâmetro e retornadas de outras funções.

Exemplo:

<button id="botao1">botao1</button>

```javascript
function cumprimenta() {
    alert('Oi, tudo bom?');
}

let botao = document.getElementById('botao1');
botao.addEventListener('click', cumprimenta);
```

<script type="text/javascript">
function cumprimenta() {
    alert('Oi, tudo bom?');
}

let botao = document.getElementById('botao1');
botao.addEventListener('click', cumprimenta);
</script>

Nesse exemplo, a função `cumprimenta` foi passada como parâmetro para a função `addEventListener` (tecnicamente, `addEventListener` é um método -- já que JavaScript é orientada a objetos -- mas na prática é muito semelhante a uma função).

## Funções de alta ordem

Exemplo de função que recebe função como parâmetro, executando a função 3 vezes, cada vez passando um número:

<textarea class="code">
function executaDe1a3(funcao) {
  funcao(1);
  funcao(2);
  funcao(3);
}

executaDe1a3(function (x) { console.log('Dou-lhe ' + x); });
</textarea>

Note que, desta vez, definimos uma função anônima, `function (x) { console.log('Dou-lhe ' + x); }`.

JavaScript já define algumas funções de alta ordem importantes, como a função `map`:

<textarea class="code">
let numeros = [1, 2, 3, 5, 8, 13];
let dobro = numeros.map(function (x) { return x * 2; });
console.log(dobro);
</textarea>

Ou a função `forEach`, para iterar sobre os elementos:

<textarea class="code">
let numeros = [1, 2, 3, 5, 8, 13];
numeros.forEach(function (num) {
   console.log(num); 
});
</textarea>


Funções de alta ordem em JavaScript para arrays: `forEach`, `filter`, `map`, `reduce`, `some`, `every`, `find`, `findIndex`.

## Funções anônimas (sintaxe nova)

Há uma notação compacta para definir funções anônimas: `x => x * 2` (função que recebe um argumento, `x` e retorna o seu dobro). Outros exemplos:

- `(x, y) => x + y`: função soma (para funções com dois ou mais argumentos, eles precisam ser envoltos em parênteses)
- `() => 42`: função que não recebe argumentos e sempre retorna 42.
- `x => { console.log(x); console.log(x + 1); }`: função sucessor com impressão no console (para rodar duas ou mais instruções, envolva-as com chaves; ao usar chaves, nenhum valor é retornado)
- `(n, a) => ({nome: n, altura: a})`: função que retorna um objeto construído a partir de dois parâmetros (para retornar um objeto/hash, envolva as chaves em parênteses, para evitar ambiguidade com o caso anterior)

(Experimente [converter essa notação](http://babeljs.io/repl/) para JavaScript antigo)

Exemplo:

<textarea class="code">
let numeros = [1, 2, 3, 5, 8, 13];
let dobro = numeros.map(x => x * 2);
console.log(dobro);

let criaPessoa = (nome, idade) => ({"nome": nome, "idade": idade});
let pessoa = criaPessoa("Fulano", 18);
console.log(pessoa);
</textarea>

## Exercícios

### map

Implemente a função `meuMap` em JavaScript:

(Duas implementações possíveis: criando um array e modificando-o com operações destrutivas, ou usando apenas operações não-destrutivas; )

<textarea class="code">
function meuMap(funcao, lista) {
  let resultado = [];
  for (let i = 0; i < lista.length; i++) {
    // implemente aqui...
  }
  return resultado;
}

teste([2, 4, 6], meuMap(x => x * 2, [1, 2, 3]));
</textarea>

## Filmes

(Baseado em <http://reactivex.io/learnrx/>.)

Nos exemplos a seguir, considere os seguintes dados (**execute o código** para carregar a variável `filmes` na memória):

<textarea class="code">
filmes = [
{
    "id": 70111470,
    "titulo": "Die Hard",
    "capa": "http://cdn-0.nflximg.com/images/2891/DieHard.jpg",
    "uri": "http://api.netflix.com/catalog/titles/movies/70111470",
    "nota": 4.0,
    "bookmark": []
},
{
    "id": 654356453,
    "titulo": "Bad Boys",
    "capa": "http://cdn-0.nflximg.com/images/2891/BadBoys.jpg",
    "uri": "http://api.netflix.com/catalog/titles/movies/70111470",
    "nota": 5.0,
    "bookmark": [{ id:432534, time:65876586 }]
},
{
    "id": 65432445,
    "titulo": "The Chamber",
    "capa": "http://cdn-0.nflximg.com/images/2891/TheChamber.jpg",
    "uri": "http://api.netflix.com/catalog/titles/movies/70111470",
    "nota": 4.0,
    "bookmark": []
},
{
    "id": 675465,
    "titulo": "Fracture",
    "capa": "http://cdn-0.nflximg.com/images/2891/Fracture.jpg",
    "uri": "http://api.netflix.com/catalog/titles/movies/70111470",
    "nota": 4.5,
    "bookmark": [{ id:432534, time:65876586 }]
}
];

console.log(`Variável filmes carregada, com ${filmes.length} elementos.`);
</textarea>

### map

Use a função `map` para mapear o array em um novo array contendo somente os títulos dos filmes

<textarea class="code">
let x = filmes.map(/* complete o código */);
teste(["Die Hard", "Bad Boys", "The Chamber", "Fracture"], x);
</textarea>

### filter

Use a função `filter` para selecionar apenas os filmes com notas superior a 4.

<textarea class="code">
let x = filmes.filter(/* complete o código */);

let respostaCorreta = [
{
    "id": 654356453,
    "titulo": "Bad Boys",
    "capa": "http://cdn-0.nflximg.com/images/2891/BadBoys.jpg",
    "uri": "http://api.netflix.com/catalog/titles/movies/70111470",
    "nota": 5.0,
    "bookmark": [{ id:432534, time:65876586 }]
},
{
    "id": 675465,
    "titulo": "Fracture",
    "capa": "http://cdn-0.nflximg.com/images/2891/Fracture.jpg",
    "uri": "http://api.netflix.com/catalog/titles/movies/70111470",
    "nota": 4.5,
    "bookmark": [{ id:432534, time:65876586 }]
}
];
teste(respostaCorreta, x);
</textarea>

### map e filter

Agora combine map e filter para retornar apenas os títulos dos filmes com nota superior a 4.

<textarea class="code">
let x = 0; /* altere esta linha */

teste(["Bad Boys", "Fracture"], x);
</textarea>

### reduce

A função `reduce` aplica uma função dada a um acumulador e cada elemento do array para reduzir o array a um único valor. A sintaxe é:

`arr.reduce(f, valorInicial)`, onde

- `valorInicial` é o valor inicial do acumulador
    - se `valorInicial` não for passado, a função assume que o valor do inicial do acumulador é igual ao valor do primeiro elemento de `arr`.
- `f` é uma função que recebe dois parâmetros:
    - `acum`: o valor atual do acumulador
    - `x`: o elemento sendo processado atualmente no array
    - (na verdade a função `f` recebe 4 argumentos, mas vamos ignorar os outros dois)
- o retorno da função `f` é atribuído ao acumulador para ser usado na próxima invocação de `f`
- `reduce` retorna o valor final do acumulador

Por exemplo, considere a função somatório, que retorna o somatório dos elementos de um array, escrito da forma tradicional, com `for`:

<textarea class="code">
function somatorio(arr) {
    let acum = 0;

    for (let i = 0; i < arr.length; i++) {
        let x = arr[i];
        acum = acum + x;
    }

    return acum;
}

console.log(somatorio([1, 2, 3, 4]));
</textarea>

A função pode ser escrita de forma mais compacta usando o `reduce`:

<textarea class="code">
let somatorio = arr => arr.reduce((acum, x) => acum + x);
console.log(somatorio([1, 2, 3, 4]));
</textarea>

Exemplo para somar as notas dos filmes:

<textarea class="code">
let somaNotas = filmes.map(x => x.nota).reduce((acum, x) => x + acum, 0);

teste(17.5, somaNotas);
</textarea>

### reduce (máximo)

Agora use reduce para retornar a maior nota do conjunto.

Dica: use o operador ternário `?:`. A expressão `condicao ? x : y` retorna `x` se a `condicao` for verdadeira, e `y` caso contrário.

<textarea class="code">
let maiorNota = filmes.map(f => f.nota)
                      .reduce(/* complete o código */);

teste(5, maiorNota);
</textarea>

(Você também pode tentar calcular a maior nota sem usar funções de alta ordem. O código será muito mais longo.)


## Referências

- <https://en.wikipedia.org/wiki/JavaScript>
- <https://en.wikipedia.org/wiki/Functional_programming>
- <http://kangax.github.io/compat-table/es2016plus/>
- <https://babeljs.io/repl/>
- <https://repl.it/languages/babel>
- <http://es6-features.org/>
