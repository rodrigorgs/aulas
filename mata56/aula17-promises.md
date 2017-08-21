---
layout: page
title:  "Padrões de concorrência"
categories: aula
---

Até agora consideramos que as funções assíncronas sempre serão bem-sucedidas em suas respectivas tarefas. Na prática, erros podem acontecer. Por exemplo, uma função que faz o download de um arquivo pode falhar porque o servidor está fora do ar ou muito lento; nesse caso, a função deve indicar o erro ao código que a chamou.

Um padrão comum para possibilitar o tratamento de erros em funções assíncronas é usar dois callbacks: um que será chamado em caso de sucesso, e o outro que será chamado em caso de erro.

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

Promises são objetos (da classe `Promise`) que encapsulam uma chamada a uma funções assíncronas que possuem callbacks de sucesso e erro.

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


## Encadeamento de Promises

Se o seu `then()` retornar um Promise, você pode encadear promises, que serão executadas de forma sequencial:

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

fazDownload("http://example.com/1")
  .then(() => fazDownload("http://example.com/2"))
  .then(() => fazDownload("http://example.com/3"))
  .then(() => console.log("OK!"))
  .catch(() => console.log("ERRO!"));
</textarea>

## all e any


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

Promise.all(
  fazDownload("http://example.com/1"),
  fazDownload("http://example.com/2"),
  fazDownload("http://example.com/3")
).then(() => console.log("OK!"));
</textarea>


<script type="text/javascript">
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

Promise.all(
  fazDownload("http://example.com/1"),
  fazDownload("http://example.com/2"),
  fazDownload("http://example.com/3")
).then(() => console.log("OK!"));

</script>