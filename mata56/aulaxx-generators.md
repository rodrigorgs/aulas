---
layout: page
title:  "Generators"
categories: aula
---

<!-- https://stackoverflow.com/questions/102535/what-can-you-use-python-generator-functions-for -->

# Programação funcional

## Estratégias de avaliação

Uma estratégia de avaliação determina quando uma expressão passada como argumento para uma função é avaliada.

Existem duas categorias principais de estratégias:

- Avaliação estrita (ou ansiosa, *eager*): os argumentos são avaliados completamente antes da aplicação da função
- Avaliação não-estrita (ou preguiçosa, *lazy*)

Considere o exemplo a seguir. Antes de executá-lo, tente adivinhar o que será escrito no console, na ordem correta.

<textarea class="code">
function cumprimenta(nome, pontuacao) {
    console.log("pre-cumprimenta");
    console.log("Alo, " + nome + pontuacao);
    console.log("pos-cumprimenta");
}
function pontoFinal(entusiasmado) {
    console.log("pre-pontoFinal");
    return entusiasmado ? "!" : ".";
}
function diminutivo(nome) {
    console.log("pre-diminutivo");
    return nome + "zinho";
}

// chama função cumprimenta
console.log("pre-chamada");
cumprimenta(diminutivo("Fulano"), pontoFinal(true));
console.log("pos-chamada");
</textarea>
Acertou? Chegou perto? Para entender o que aconteceu, temos que falar de **estratégias de avaliação**.


## Conceitos

- Parâmetro formal: variável que aparece na definição de uma função
- Parâmetro real (ou argumento): variável ou valor passado em uma chamada para uma função

```javascript
function soma(a, b) { // a e b são parâmetros formais
    return a + b;
}
var x = 1, y = 2;
var z = soma(2*x, y); // 2*x e y são argumentos
                      // (parâmetros reais)
```

## Avaliação estrita

**Passagem por valor**: o valor da expressão é avaliado antes da chamada da função; a função recebe uma cópia do valor.

**Passagem por referência**: a função recebe uma referência para a variável; a função pode modificar a variável e atribuir um novo valor a ela. Nesse caso o argumento não pode ser qualquer expressão; deve ser uma variável. Exemplo: função `swap` em Pascal:

```pascal
procedure swap(var x, y: integer);
var
   temp: integer;

begin
   temp := x;
   x:= y;
   y := temp;
end;
```

Não é possível escrever uma função similar em Javascript em usar artifícios, pois Javascript não dá suporte a passagem de parâmetros por referência.

**Passagem por compartilhamento** (às vezes chamado de passagem por referência): como na passagem por referência, a função consegue modificar o objeto passado, mas não consegue atribuir a variável a outro valor. Exemplo:

<textarea class="code">
function insere(vetor, elemento) {
    vetor.push(elemento);
}
var x = [1, 2, 3];
insere(x, 4);
alert(x);
</textarea>
Podemos usar a passagem por compartilhamento para emular passagem por referência e escrever uma função `swap` em Javascript:

<textarea class="code">
function swap(obj) {
    var temp = obj.a;
    obj.a = obj.b;
    obj.b = temp;
}
var a = 1, b = 2;
var obj = {"a": a, "b": b};
swap(obj);
a = obj.a;
b = obj.b;
alert([a, b]);
</textarea>
**Passagem por cópia e restauração (copy-restore)**. Como passagem por compartilhamento, útil no contexto de chamadas remotas (o chamador e a função estão em processos diferentes). O valor é copiado para a função, e ao final o novo valor é copiado de volta para o chamador.

## Avaliação não-estrita

**Chamada por nome**. Nesta avaliação, os argumentos não são avaliados de maneira completa, tais argumentos são substituídos diretamente dentro do corpo da função. Se um parêmetro não é usado na avaliação da função, este nunca será avaliado, e se o parâmetro é usado varias vezes, este é reavaliado a cada vez.

**Chamada por necessidade**. Chamada por necessidade é uma versão da chamada por nome, se o argumento da função é avaliado, seu valor é gravado para uso posterior.

**Chamada por expansão de macro**. Ver `#define` em C.

## Lazy evaluation em Javascript

Embora Javascript não permita diretamente a passagem de parâmetros por necessidade, podemos escrever programas que usam essa estratégia.

Considere o seguinte exemplo, que tenta emular o operador ternário `condicao ? valorVerdadeiro : valorFalso`:

<textarea class="code">
function ternario(condicao, valorTrue, valorFalse) {
    console.log("chamou ternario");
    if (condicao) {
        return valorTrue;
    } else {
        return valorFalse;
    }
}
function soma(a, b) {
    console.log("chamou soma(" + a + "," + b + ")");
    return a + b;
}
var curso = "Computacao";
var valorInscricao = ternario(curso === "Computacao", soma(20, 10), soma(40, 20));
console.log(valorInscricao);
// É equivalente ao de baixo?
// var valorInscricao = curso === "Computacao" ? soma(20, 10) : soma(40, 20));
</textarea>
Você deve ter percebido que é impossível emular perfeitamente o operador ternário, pois os argumentos são avaliados de forma estrita. O único jeito é reescrever `ternario` para receber funções, e não valores.

<textarea class="code">
function ternario(condicao, funcaoTrue, funcaoFalse) {
    console.log("chamou ternario");
    if (condicao) {
        return funcaoTrue();
    } else {
        return funcaoFalse();
    }
}
function soma(a, b) {
    console.log("chamou soma(" + a + "," + b + ")");
    return a + b;
}
var curso = "Computacao";
var valorInscricao = ternario(curso === "Computacao", () => soma(20, 10), () => soma(40, 20));
console.log(valorInscricao);
// É equivalente ao de baixo?
// var valorInscricao = curso === "Computacao" ? soma(20, 10) : soma(40, 20));
</textarea>
<!--
### Exemplo: logging

<textarea class="code">
function log(nivel, mensagem) {
    if (nivel >= nivelAtual) {
        console.log(mensagem);
    }
}
</textarea> -->

### Memoização

Consideremos outro exemplo:

<textarea class="code">
function repete(string, nvezes) {
    var i;
    for (i = 0; i < nvezes; i++) {
        console.log(string);
    }
}
function concatena(str1, str2) {
    console.log("concatena");
    return str1 + ", " + str2;
}
var tranquilo = "tá tranquilo";
var favoravel = "tá favorável";
repete(concatena(tranquilo, favoravel), 4);
console.log("======");
repete(concatena(tranquilo, favoravel), 0);
</textarea>
Na primeira chamada a `repete`, a expressão `concatena(tranquilo, favoravel)` é avaliada apenas uma vez, e seu valor é passado ao parâmetro `string`. Na segunda chamada, a expressão é avaliada, mas seu valor nunca chega a ser usado (por ele é não é impresso nenhuma vez). Isso representa um desperdício de processamento! Para resolver isso, vamos usar uma estratégia de avaliação preguiçosa:

<textarea class="code">
function repete(lazyString, nvezes) {
    var i;
    for (i = 0; i < nvezes; i++) {
        console.log(lazyString());
    }
}
function concatena(str1, str2) {
    console.log("concatena");
    return str1 + ", " + str2;
}
var tranquilo = "tá tranquilo";
var favoravel = "tá favorável";
repete(() => concatena(tranquilo, favoravel), 4);
console.log("======");
repete(() => concatena(tranquilo, favoravel), 0);
</textarea>
Pronto! Agora, no segundo caso (`nvezes` igual a `0`), a função `concatena` não é chamada, porque não é necessário! Em compensação, a função é chamada 4 vezes no primeiro `repete`, o que também é um desperdício, já que o resultado é sempre o mesmo. Essa é a desvantagem da passagem de parâmetros **por nome**. Vamos transformar em passagem **por necessidade**; para isso, é preciso guardar o valor na primeira chamada.

<textarea class="code">
function repete(lazyString, nvezes) {
    var i, memo;
    for (i = 0; i < nvezes; i++) {
        if (memo === undefined) {
            memo = lazyString();
        }
        console.log(memo);
    }
}
function concatena(str1, str2) {
    console.log("concatena");
    return str1 + ", " + str2;
}
var tranquilo = "tá tranquilo";
var favoravel = "tá favorável";
repete(() => concatena(tranquilo, favoravel), 4);
console.log("======");
repete(() => concatena(tranquilo, favoravel), 0);
</textarea>
Essa técnica de guardar o retorno de uma função para consultar em chamadas subsequentes à função é chamada **memoização**.

Exercício: implementar `chamadaMemoizada(f)`.

Aplicação prática: logging.

```javascript
nivelAtual = 3;
function log(nivel, mensagem) {
    if (nivel >= nivelAtual) {
        console.log(mensagem);
    }
}

if (nivelAtual >= 3) { // otimização para evitar computar a mensagem se não for ser exibida
    log(3, "Usuário clicou em " + convertePosicao(mouse.x) + ", " + convertePosicao(mouse.y));
}
```

## Listas preguiçosas com iterators

Um objeto é um iterador quando ele sabe como acessar itens de uma coleção um de cada vez, enquanto mantém o registro da posição atual dentro da sequência.

Em Javascript, um iterador é um objeto que fornece um método `next()` que retorna o próximo item na sequência. Esse método retorna um objeto com duas propriedades: `done` (indica se a sequência terminou) e `value` (representa o item atual da sequência).

<textarea class="code">
function criaIterador(array) {
    var indice = 0;

    return {
        next: function() {
            if (indice < array.length) {
                return {value: array[indice++], done: false};
            } else {
                return {value: undefined, done: true};
            }
        }
    };
}
var iter = criaIterador(['a', 'b', 'c']);
var elem = iter.next();
while (!elem.done) {
    console.log("elem: " + elem.value);
    elem = iter.next();
}
</textarea>
Vejamos outro exemplo, desta vez com um iterador infinito:

<textarea class="code">
function criaIteradorFib() {
    var a = 1, b = 1;

    obj = {
        next: function() {
            var prox = a + b;
            a = b;
            b = prox;
            return {value: prox, done: false};
        }
    };

    return obj;
}
var iter = criaIteradorFib();
var elem = iter.next();
while (!elem.done && elem.value < 100) {
    console.log(elem.value);
    elem = iter.next();
}
</textarea>
O conceito de gerador ou **função geradora** (generator function) permite escrever esse código de forma muito mais intuitiva. Para definir um gerador, use `function*`. Para chamar um gerador, você pode usar o mesmo esquema de `next()`, `done` e `value` ou pode usar `for (x of gerador())`:

<textarea class="code">
function* geraFib() {
    var a = 1, b = 1, prox;

    while (true) {
        prox = a + b;
        a = b;
        b = prox;
        yield prox;
    }
}
for (x of geraFib()) {
    if (x >= 100) break;
    console.log(x);
}
</textarea>
Podemos criar uma função genérica que executa uma função para os primeiros `n` valores de um generator:

<textarea class="code">
function* geraFib() {
    var a = 1, b = 1, prox;

    while (true) {
        prox = a + b;
        a = b;
        b = prox;
        yield prox;
    }
}

function take(gen, n, fn) {
    var i = 0, x;
    for (x of gen()) {
        if (i >= n) break;
        fn(x);
        i++;
    }
}

take(geraFib, 5, x => console.log(x));
</textarea>

------------------

## Exercícios

Considere a seguinte função, que imprime os primeiros `n` números primos:

<textarea class="code">
function imprimePrimeirosPrimos(n) {
    var i, num = 0, ehprimo, qtdprimos = 0;
    while (qtdprimos < n) {
        if (num >= 2) {
            ehprimo = true;
            for (i = 2; i < num; i++) {
                if (num % i === 0) {
                    ehprimo = false;
                    break;
                }
            }
            if (ehprimo) {
                qtdprimos++;
                console.log(num);
            }
        }
        num++;
    }
}
imprimePrimeirosPrimos(10);
</textarea>

Essa função tem várias responsabilidades:

- determinar se um número é primo
- controlar a quantidade de números retornados
- imprimir números

Do jeito que está, a função não é muito extensível. E se quiséssemos retornar os números primos em vez de imprimi-los? E se quiséssemos obter os números primos menores que 100? Qualquer dessas mudanças exigiria a implementação de uma nova função.

Ainda bem que Javascript é uma linguagem funcional! Vamos aproveitar os recursos da linguagem para decompor essa função em funções menores, cada uma com uma única responsabilidade, para facilitar o reuso das funções?

## Isolando a checagem de números primos

Vamos decompor a função original em duas partes: a função `ehPrimo(numero)` determina se um número é primo ou não, e `imprimePrimeiros(n, pred)` imprime os primeiros `n` números naturais que satisfazem à função `pred`. Com isso, podemos reescrever `imprimePrimeirosPrimos(n)` combinando as duas funções.

<textarea class="code">
// --- modifique imprimePrimeiros para receber
//     uma função.
function imprimePrimeiros(n, pred) {
    var i, num = 0, ehprimo, qtdprimos = 0;
    while (qtdprimos < n) {
        if (num >= 2) {
            ehprimo = true;
            for (i = 2; i < num; i++) {
                if (num % i === 0) {
                    ehprimo = false;
                    break;
                }
            }
            if (ehprimo) {
                qtdprimos++;
                console.log(num);
            }
        }
        num++;
    }
}
function ehPrimo(numero) {
    
}
// ---
function imprimePrimeirosPrimos(n) {
    imprimePrimeiros(n, ehPrimo);
}
imprimePrimeirosPrimos(10);
</textarea>

<!-- 
function imprimePrimeiros(n, pred) {
    var i, num = 0, ehprimo, qtd = 0;
    while (qtd < n) {
        if (pred(num)) {
            qtd++;
            console.log(num)
        }
        num++;
    }
}
function ehPrimo(num) {
    ehprimo = false;
    if (num >= 2) {
        ehprimo = true;
        for (i = 2; i < num; i++) {
            if (num % i === 0) {
                ehprimo = false;
                break;
            }
        }
    }
    return ehprimo;
}
function imprimePrimeirosPrimos(n) {
    imprimePrimeiros(n, ehPrimo);
}
imprimePrimeirosPrimos(10);
 -->

## Isolando a forma de retorno

A função atual imprime o resultado no console. E se quiséssemos mostrar em caixas de alerta? E se quiséssemos retornar um array? Vamos reescrever a função para dar essa possibilidade.

<textarea class="code">
function primeirosPred(n, pred, func) {
// --- chame a função func para cada número primo
    var i, num = 0, ehprimo, qtd = 0;
    while (qtd < n) {
        if (pred(num)) {
            qtd++;
            console.log(num);
        }
        num++;
    }
// ---
}
function ehPrimo(num) {
    if (num <= 2) return false;
    for (i = 2; i < num; i++) {
        if (num % i === 0) return false;
    }
    return true;
}
function imprimePrimeirosPrimos(n) {
    primeirosPred(n, ehPrimo, (x) => console.log(x));
}
function retornaPrimeirosPrimos(n) {
    array = [];
    primeirosPred(n, ehPrimo, (x) => array.push(x));
    return array;
}
imprimePrimeirosPrimos(10);
console.log(retornaPrimeirosPrimos(10));
</textarea>

<!-- 

function primeirosPred(n, pred, func) {
    var i, num = 0, ehprimo, qtd = 0;
    while (qtd < n) {
        if (pred(num)) {
            qtd++;
            func(num);
        }
        num++;
    }
}
function ehPrimo(num) {
    ehprimo = false;
    if (num >= 2) {
        ehprimo = true;
        for (i = 2; i < num; i++) {
            if (num % i === 0) {
                ehprimo = false;
                break;
            }
        }
    }
    return ehprimo;
}
function imprimePrimeirosPrimos(n) {
    primeirosPred(n, ehPrimo, (x) => console.log(x));
}
function retornaPrimeirosPrimos(n) {
    array = []
    primeirosPred(n, ehPrimo, (x) => array.push(x));
    return array;
}
imprimePrimeirosPrimos(10);
console.log(retornaPrimeirosPrimos(10));
 -->

## Transforme a função primeirosPred em um generator.

Nesse caso, você não precisará mais passar a função `func`, uma vez que `primeirosPred` retornará diretamente o valor através da instrução `yield`.

<textarea class="code">
function primeirosPred(n, pred, func) {
    var i, num = 0, ehprimo, qtd = 0;
    while (qtd < n) {
        if (pred(num)) {
            qtd++;
            func(num);
        }
        num++;
    }
}
function ehPrimo(num) {
    ehprimo = false;
    if (num >= 2) {
        ehprimo = true;
        for (i = 2; i < num; i++) {
            if (num % i === 0) {
                ehprimo = false;
                break;
            }
        }
    }
    return ehprimo;
}
function imprimePrimeirosPrimos(n) {
    primeirosPred(n, ehPrimo, (x) => console.log(x));
}
function retornaPrimeirosPrimos(n) {
    array = []
    primeirosPred(n, ehPrimo, (x) => array.push(x));
    return array;
}
imprimePrimeirosPrimos(10);
console.log(retornaPrimeirosPrimos(10));
</textarea>

<!-- ## Isolando o conjunto de números

E se não quisermos encontrar os primeiros `n` números, e sim os números de uma sequência que são primos? Considere o seguinte generator:

```javascript
function* geraFib() {
    var a = 1, b = 1, prox;

    while (true) {
        prox = a + b;
        a = b;
        b = prox;
        yield prox;
    }
}
```

Escreva o restante do código no exemplo abaixo para imprimir no console todos os números da sequência de Fibonacci que são primos.

<textarea class="code">
function* geraFib() {
    var a = 1, b = 1, prox;

    while (true) {
        prox = a + b;
        a = b;
        b = prox;
        yield prox;
    }
}
// --- seu código aqui
// ...
// ---
todosPred(geraFib, ehPrimo, (x) => console.log(x));
</textarea> -->

<!--
function* geraFib() {
    var a = 1, b = 1, prox;

    while (true) {
        prox = a + b;
        a = b;
        b = prox;
        yield prox;
    }
}
function todosPred(gen, pred, func) {
    var i, num = 0, ehprimo, qtd = 0;
    for (num of gen()) {
        if (pred(num)) {
            qtd++;
            func(num);
        }
        num++;
    }
}
function ehPrimo(num) {
    ehprimo = false;
    if (num >= 2) {
        ehprimo = true;
        for (i = 2; i < num; i++) {
            if (num % i === 0) {
                ehprimo = false;
                break;
            }
        }
    }
    return ehprimo;
}
todosPred(geraFib, ehPrimo, (x) => console.log(x));
-->