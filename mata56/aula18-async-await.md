---
layout: page
title:  "async/await"
categories: aula
---

## Motivação

Código assíncrono com callbacks ou mesmo com [promises](aula17-promises) pode ser difícil de ler.

As instruções async e await são uma abstração de promises que permitem escrever código mais legível.

Considere o exemplo a seguir usando promises. O código aguarda 300 milissegundos, imprime "a", aguarda mais 200 milisegundos e então imprime "b".

<textarea class="code">
function sleep(t) {
  return new Promise(resolve => setTimeout(resolve, t));
}

function imprimeAB() {
  return sleep(300)
    .then(() => console.log("a"))
    .then(sleep(200))
    .then(() => console.log("b"))
}

imprimeAB();
</textarea>

## await

O código acima pode ser reescrito da seguinte forma:

<textarea class="code">
function sleep(t) {
  return new Promise(resolve => setTimeout(resolve, t));
}

async function imprimeAB() {
  await sleep(300);
  console.log("a");
  await sleep(200);
  console.log("b");
}

imprimeAB();
</textarea>

Observações:

- A palavra-chave `await` só pode ser usada dentro de funções `async`
- `await` recebe uma promise
- Funções prefixadas com a palavra-chave `async` são funções assíncronas que retornam promises.

## Exemplo mais completo

Baseado no exemplo da aula de [padrões de concorrência](aula16-concorrencia-padroes).

<textarea class="code">
async function main() {
  let users = await $.get('http://jsonplaceholder.typicode.com/users?username=Delphine')
  let id = users[0].id;
  let albums = await $.get('http://jsonplaceholder.typicode.com/albums?userId=' + id);
  return albums.map(a => a.title);
}

main().then(albums => console.log(albums));
</textarea>