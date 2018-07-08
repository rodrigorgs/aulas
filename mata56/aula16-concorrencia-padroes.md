---
layout: page
title:  "Padrões de concorrência"
categories: aula
---

## Não-determinismo

Considere a função `chamaDepois(f)`, que chama a função `f` após um intervalo de tempo aleatório:

<textarea class="code">
function chamaDepois(f) {
    var interval = Math.random() * 1500;
    setTimeout(f, interval);
}
</textarea>

<script type="text/javascript">
function chamaDepois(f) {
    var interval = Math.random() * 1500;
    setTimeout(f, interval);
}
</script>

Essa função emula o comportamento de um download ou de um clique do mouse: não podemos prever quando esses eventos acontecerão.

Agora considere que as funções de adicionar e multiplicar números foram implementadas em um computador remoto, e precisamos fazer requisições para esses computadores para realizar as operações. Eis um exemplo prático de programa concorrente no qual a ordem de execução das tarefas afeta o resultado:

<textarea class="code">
x = 1;
function adiciona() {
  chamaDepois(function () {
    console.log('adiciona');
    x = x + 1;
  });
}
function multiplica() {
  chamaDepois(function () {
    console.log('multiplica');
    x = x * 2;
  });
}
function imprime() {
  console.log(x);
}
adiciona();
multiplica();
setTimeout(imprime, 2000);
</textarea>

Essa solução possui dois problemas:

- não temos como saber a ordem em que as funções serão executadas
- não temos como saber quando as funções terminaram de executar
  - estamos chamando `imprime` após 2000 milissegundos, mas quem garante que esse tempo é suficiente?

Para resolver isso, usamos callbacks: chamamos a função assíncrona passando uma função que será "chamada de volta" (called back) quando a função assíncrona terminar de executar.

## Estrutura sequencial com callbacks

Usamos callbacks para garantir uma ordem sequencial de execução de funções assíncronas:


<textarea class="code">
x = 1;
function adiciona(callback) {
  chamaDepois(function () {
    console.log('adiciona');
    x = x + 1;
    callback();
  });
}
function multiplica(callback) {
  chamaDepois(function () {
    console.log('multiplica');
    x = x * 2;
    callback();
  });
}
function imprime() {
    console.log(x);
}
console.log('a');
adiciona(function () {
  console.log('b');
  multiplica(function () {
    console.log('c');
    imprime();
    console.log('d');
  });
  console.log('e');
});
console.log('f');
</textarea>

À medida que combinamos sequencialmente várias funções assíncronas, o nível de indentação do programa vai aumentando, um problema conhecido como [pyramid of doom](https://en.wikipedia.org/wiki/Pyramid_of_doom_(programming)) ou [callback hell](http://callbackhell.com/).

Outro exemplo:

<textarea class="code">
// AJAX fake
function ajax(url, callback) {
    var intervalo = Math.random() * 1500;
    setTimeout(callback, intervalo);
}

console.log(1);
ajax('http://imagem.com/', function (img) {
    console.log(2);
    ajax('http://processa-imagem', function (img) {
        console.log(3);
        console.log('exibindo a imagem...');
        console.log(4);
    });
    console.log(5);
});
console.log(6);
</textarea>

## Join

Agora considere a situação em que há duas funções assíncronas, `adiciona1` e `adiciona2`, que adicionam 1 e 2, respectivamente, à variável `x`. Queremos executar as duas funções e, ao final, executar `imprime` para ver o resultado.

```javascript
function adiciona1(callback) {
  chamaDepois(function () {
    console.log('adiciona');
    x = x + 1;
    callback();
  });
}
function adiciona2(callback) {
  chamaDepois(function () {
    console.log('adiciona');
    x = x + 2;
    callback();
  });
}
function imprime() {
    console.log(x);
}
```

A diferença aqui é que, dentre `adiciona1` e `adiciona2`, não importa quem executa primeiro, contanto que `imprime` só execute quando as ambas terminarem de executar:

```
adiciona1 ---
             \_____ imprime
             /
adiciona2 ---
```

Esse padrão de concorrência é conhecido como *join*. Eis uma forma de implementá-lo:

<textarea class="code">
x = 1;
var chamou1 = false, chamou2 = false;
function adiciona1() {
  chamaDepois(function () {
    console.log('adiciona1');
    chamou1 = true;
    x = x + 1;
    if (chamou1 && chamou2) {
        imprime();
    }
  });
}
function adiciona2() {
  chamaDepois(function () {
    console.log('adiciona2');
    chamou2 = true;
    x = x + 2;
    if (chamou1 && chamou2) {
      imprime();
    }  
  });
}
function imprime() {
    console.log(x);
}
adiciona1();
adiciona2();
</textarea>

Desafio: na solução anterior, usamos variáveis globais e colocamos a chamada a `imprime` no próprio código das funções `adiciona1` e `adiciona2`. Tente generalizar essa solução:

- Crie uma função `join(funcoes, callback)`, que recebe um array de funções (`funcoes`) e uma função (`callback`)
- Cada função do array recebe como parâmetro uma função `f`, e chama `f` quando termina de executar
- A função `join` chama `callback` quando todas as funções em `funcoes` terminam de executar.

<textarea class="code">
</textarea>

<textarea class="answer">
// Exemplo de funções assíncronas

x = 1;
function adiciona1(callback) {
  chamaDepois(function () {
    x = x + 1;
    callback();
  });
}
function adiciona2(callback) {
  chamaDepois(function () {
    x = x + 2;
    callback();
  });
}

///////////////

function join(funcoes, callback) {
  var i, funcao;
  var n = funcoes.length;
  var contador = 0;
  
  function concluiFuncao() {
    contador++;
    if (contador == n) {
      callback();
    }
  }
  
  for (i = 0; i < n; i++) {
    funcao = funcoes[i];
    funcao(concluiFuncao);
  }
}

join([adiciona1, adiciona2], () => { console.log(x) });
</textarea>

# Exercícios

Nesta aula vamos usar o site [JSONPlaceholder](https://jsonplaceholder.typicode.com/) para dar suporte a nossos exemplos práticos.

Para simplificar o código, definimos a variável global ROOT como sendo a URL do JSONPlaceholder.

<script type="text/javascript">
    ROOT = 'https://jsonplaceholder.typicode.com';
</script>

As funções `$.get(url, f)` e `$.post(url, f)` realizam uma requisição AJAX à `url` e, quando a resposta chega, chama a função `f` passando o objeto associado à resposta.

Para ver o que a chamada `$.get(ROOT + '/users', ...)` retorna, basta acessar <https://jsonplaceholder.typicode.com/users> no seu navegador.

## Exemplo simples

Antes de executar o código a seguir, tente prever a ordem de execução das instruções `console.log`.

<textarea class="code">
console.log(1);
console.log('ROOT = ', ROOT);
$.get(ROOT + '/users', function (data) {
  console.log(data.map(u => u.name));
});
console.log(2);
</textarea>

## Algo mais elaborado

O exemplo a seguir deveria buscar o id do usuário com username `Delphine` e então mostrar o título dos álbuns desse usuário:

  <textarea class="code">
var id, albums;
$.get(ROOT + '/users?username=Delphine', function (data) {
  id = data[0].id;
});
$.get(ROOT + '/albums?userId=' + id, function (data) {
  albums = data.map(a => a.title);
});
console.log(albums);
</textarea>

<textarea class="code">
var id, albums;
$.get(ROOT + '/users?username=Delphine', function (data) {
  id = data[0].id;
  $.get(ROOT + '/albums?userId=' + id, function (data) {
    albums = data.map(a => a.title);
    console.log(albums);
  });
});
</textarea>

No entanto, o programador não percebeu que as chamadas de função que realizou são assíncronas, e por isso o programa não funciona como deveria. Conserte o programa.

## Join

Agora você quer pegar o e-mail de todos os usuários pagantes e então exibir os e-mails separados por vírgulas (não importa a ordem). (Suponha que a url `/users`, que retorna todos os dados de todos os usuários, não existe). Corrija o código abaixo:

<textarea class="code">
var pagantes = [1, 2, 5, 8];
var emails = [];
function recebeResultado(user) {
  emails.push(user.email);
}
function imprimeResultado() {
  console.log('Emails: ' + emails.join(',') + '.');
}
pagantes.forEach(function (idx, userId) {
  $.get(ROOT + '/users/' + userId, recebeResultado);
});
imprimeResultado();
</textarea>


<!-- 
// Sequencial
function executaOnline(f) {
  var interval = Math.random() * 1500;
  return new Promise((resolve) => {
    setTimeout(() => resolve(f()), interval)
  });
}

async function adiciona(x, y) {
  var ret = await executaOnline(() => x + y);
  console.log('parcial:', ret);
  return ret;
}


async function computa() {
  var x = 1;
  console.log('inicial:', x);
  
  x = await adiciona(x, 1);
  x = await adiciona(x, 2);

  return x;
}

computa().then(ret => console.log('final:', ret));



// join

function executaOnline(f) {
  var interval = Math.random() * 1500;
  return new Promise((resolve) => {
    setTimeout(() => resolve(f()), interval)
  });
}

contador = 0

async function incrementaContador(x) {
  return executaOnline(() => {
    contador += x;
    console.log('incrementa', x);
  });
}


async function computa() {
  console.log('inicial:', contador);

  await Promise.all([
    incrementaContador(1),
    incrementaContador(2)]);

  console.log('final:', contador)
  return x;
}

computa().then(ret => console.log('final:', ret));

 -->