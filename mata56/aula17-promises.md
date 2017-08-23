---
layout: page
title:  "Promises"
categories: aula
---

## Motivação

Até agora consideramos que as funções assíncronas sempre serão bem-sucedidas em suas respectivas tarefas. Na prática, erros podem acontecer. Por exemplo, uma função que faz o download de um arquivo pode falhar porque o servidor está fora do ar ou muito lento; nesse caso, a função deve indicar o erro ao código que a chamou.

Um padrão comum para possibilitar o tratamento de erros em funções assíncronas é usar dois callbacks: um que será chamado em caso de sucesso, e o outro que será chamado em caso de erro.

No exemplo abaixo, a função `fazDownload` tem 50% de chance de ser bem-sucedida:

<textarea class="code">
function fazDownload(url, cbSucesso, cbErro) {
  var bemSucedido = Math.random() < 0.5;

  setTimeout(() => {
    if (bemSucedido)
      cbSucesso();
    else
      cbErro();
  }, 1000 * Math.random());
}

fazDownload("http://example.com/",
  () => console.log("Download bem sucedido!"),
  () => console.log("ERRO!"));
</textarea>

Se quisermos agora encadear uma sequência de downloads, de tal forma que um download só inicie quando o download anterior for concluído com sucesso, o código tende a ficar difícil de ler e entender. 

## Promises

Promises são objetos (da classe `Promise`) que encapsulam uma chamada a uma função assíncrona que possui callbacks de sucesso e erro.

(Um conceito relacionado é o de *future*, presente em outras linguagens de programação.)

Uma promise pode estar em um dos seguintes estados:

- pendente: a operação ainda não foi finalizada
- resolvida: a operação foi finalizada com sucesso
- rejeitada: a operação foi finalizada com erro

Uma promise que se encontra no estado resolvida ou rejeitada (isto é, não está pendente) é dita estabelecida. 

Podemos reescrever a função assíncrona `fazDownload` de forma que ela retorne uma *promise*. O código que usa a função deve então chamar os métodos `then()` e `catch()` da classe `Promise` para tratar o resultado:

<textarea class="code">
function fazDownload(url) {
  var bemSucedido = Math.random() < 0.5;

  return new Promise((cbSucesso, cbErro) => {
    setTimeout(function () {
      if (bemSucedido)
        cbSucesso();
      else
        cbErro();
    }, 1000 * Math.random());
  });
}

fazDownload("http://example.com/")
  .then(() => console.log("Download bem sucedido!"))
  .catch(() => console.log("ERRO!"));
</textarea>

## Execução sequencial de promises

Se o seu `then()` retornar uma Promise, você pode encadear promises, que serão executadas de forma sequencial:

<textarea class="code">
function fazDownload(url) {
  var bemSucedido = Math.random() < 0.5;

  return new Promise((cbSucesso, cbErro) => {
    console.log('fazDownload', url, 'inicio');
    setTimeout(function () {
      if (bemSucedido)
        cbSucesso();
      else
        cbErro();
      console.log('fazDownload', url, 'fim', bemSucedido);
    }, 1000 * Math.random());
  });
}

fazDownload("http://example.com/1")
  .then(() => fazDownload("http://example.com/2"))
  .then(() => fazDownload("http://example.com/3"))
  .then(() => console.log("OK!"))
  .catch(() => console.log("ERRO!"));
</textarea>

## Execução paralela de promises: Promise.all

`Promise.all` recebe um array de promises e cria um novo promise que termina somente quando todos os promises da array terminam. Em outras palavras, `Promise.all` permite executar várias operações assíncronas em paralelo e executar alguma operação (usando o `then()`) quando todas elas forem concluídas.

<textarea class="code">
function fazDownload(url) {
  var bemSucedido = Math.random() < 0.5;

  return new Promise((cbSucesso, cbErro) => {
    console.log('fazDownload', url, 'inicio');
    setTimeout(function () {
      if (bemSucedido)
        cbSucesso();
      else
        cbErro();
      console.log('fazDownload', url, 'fim');
    }, 1000 * Math.random());
  });
}

Promise.all([
    fazDownload("http://example.com/1"),
    fazDownload("http://example.com/2"),
    fazDownload("http://example.com/3")])
  .then(() => console.log("OK!"))
  .catch(() => console.log("ERRO!"));
</textarea>

## Execução paralela de promises: Promise.race

Assim como `Promise.all`, `Promise.race` também cria uma nova promise a partir de um array de promises, e permite executar as promises do array em paralelo. A diferença é que a nova promise é concluída logo que qualquer promise do array for concluída.

<textarea class="code">
function fazDownload(url) {
  var bemSucedido = Math.random() < 0.5;

  return new Promise((cbSucesso, cbErro) => {
    console.log('fazDownload', url, 'inicio');
    setTimeout(function () {
      if (bemSucedido)
        cbSucesso();
      else
        cbErro();
      console.log('fazDownload', url, 'fim');
    }, 1000 * Math.random());
  });
}

Promise.race([
    fazDownload("http://example.com/1"),
    fazDownload("http://example.com/2"),
    fazDownload("http://example.com/3")])
  .then(() => console.log("OK!"))
  .catch(() => console.log("ERRO!"));
</textarea>

## Referências

- <https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Using_promises>
- <https://medium.com/javascript-scene/master-the-javascript-interview-what-is-a-promise-27fc71e77261>