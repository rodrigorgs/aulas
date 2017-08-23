---
layout: page
title:  "Promises"
categories: aula
---

## Motivação

Até agora consideramos que as funções assíncronas sempre serão bem-sucedidas em suas respectivas tarefas. Na prática, erros podem acontecer. Por exemplo, uma função que faz o download de um arquivo pode falhar porque o servidor está fora do ar ou muito lento; nesse caso, a função deve indicar o erro ao código que a chamou.

Um padrão comum para possibilitar o tratamento de erros em funções assíncronas é usar dois callbacks: um que será chamado em caso de sucesso, e o outro que será chamado em caso de erro.

No exemplo abaixo, a função assíncrona `sorteia0` retorna um número aleatório entre 0 e `maximo`, mas tem 20% de chance de falhar. Ela recebe dois callbacks: a função `resolve`, que será chamada em caso de sucesso, e a função `reject`, que será chamada em caso de falha.

<textarea class="code">
function sorteia0(maximo, resolve, reject) {
  console.log('sorteia0', maximo, 'inicio');
  setTimeout(() => {
    var bemSucedido = Math.random() < 0.8;
    var valor = Math.round(Math.random() * maximo);
    console.log('sorteia0', maximo, 'fim', bemSucedido ? valor : 'erro');
    if (bemSucedido)
      resolve(valor);
    else
      reject(new Error("Falha na geração"));
  }, 1000 * Math.random());
}

sorteia0(100,
  num => console.log("OK!", num),
  erro => console.log("ERRO!", erro.message));
</textarea>

Se quisermos agora encadear uma sequência de sorteios, de tal forma que um sorteio só inicie quando o sorteio anterior for concluído com sucesso, o código tende a ficar difícil de ler e entender. 

## Promises

Promises são objetos (da classe `Promise`) que encapsulam uma chamada a uma função assíncrona que possui callbacks de sucesso e erro.

(Um conceito relacionado é o de *future*, presente em outras linguagens de programação.)

Uma promise pode estar em um dos seguintes estados:

- **pendente**: a operação ainda não foi finalizada
- **resolvida**: a operação foi finalizada com sucesso
- **rejeitada**: a operação foi finalizada com erro

Uma promise que se encontra no estado resolvida ou rejeitada (isto é, não está pendente) é dita **estabelecida**. 

Podemos reescrever a função assíncrona `sorteia` de forma que ela retorne uma *promise*. O código que usa a função deve então chamar os métodos `then()` e `catch()` da classe `Promise` para tratar o resultado:

- `then(f)` recebe uma função, `f` que deve ser executada quando a promise é resolvida
- `catch(f)` recebe uma função, `f` que deve ser executada quando a promise é rejeitada
- Tanto `then(f)` quanto `catch(f)` retornam uma promise que será resolvida com o valor retornado por `f`.

**Execute o código a seguir para carregar a função `sorteia`, que será usada nos outros exemplos**.

<textarea class="code">
function sorteia(maximo) {
  return new Promise((resolve, reject) => {
    console.log('sorteia', maximo, 'inicio');
    setTimeout(() => {
      var bemSucedido = Math.random() < 0.8;
      var valor = Math.round(Math.random() * maximo);
      console.log('sorteia', maximo, 'fim', bemSucedido ? valor : 'erro');
      if (bemSucedido)
        resolve(valor);
      else
        reject(new Error("Falha na geração"));
    }, 1000 * Math.random());
  })
}
window.sorteia = sorteia; // define no escopo global
console.log('Função sorteia carregada!');
</textarea>

<textarea class="code">
sorteia(100)
  .then(num => console.log("OK!", num))
  .catch(erro => console.log("ERRO!", erro.message));
</textarea>

## Execução sequencial de promises

Como o `then()` retorna uma promise, você pode encadear chamadas a `then()/catch()`, que serão executadas de forma sequencial:

<textarea class="code">
sorteia(10)
  .then(x => sorteia(20))
  .then(x => sorteia(30))
  .then(x => console.log("OK!", x))
  .catch(e => console.log("ERRO!", e.message));
</textarea>

## Execução paralela de promises: Promise.all

`Promise.all` recebe um array de promises e cria um novo promise que termina somente quando todos os promises da array terminam. Em outras palavras, `Promise.all` permite executar várias operações assíncronas em paralelo e executar alguma operação (usando o `then()`) quando todas elas forem resolvidas. A função passada ao `then()` recebe os valores de todos os promises em um array. Se alguma operação for rejeitada, a promise resultante também será rejeitada, imediatamente.

<textarea class="code">
Promise.all([
    sorteia(10),
    sorteia(20),
    sorteia(30)])
  .then(nums => console.log("OK!", nums))
  .catch(e => console.log("ERRO!", e.message));
</textarea>

## Execução paralela de promises: Promise.race

Assim como `Promise.all`, `Promise.race` também cria uma nova promise a partir de um array de promises, e permite executar as promises do array em paralelo. A diferença é que a nova promise é estabelecida (resolvida ou rejeitada) logo que qualquer promise do array for estabelecida.

<textarea class="code">
Promise.race([
    sorteia(10),
    sorteia(20),
    sorteia(30)])
  .then(nums => console.log("OK!", nums))
  .catch(e => console.log("ERRO!", e.message));
</textarea>

## Referências

- <https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Using_promises>
- <https://medium.com/javascript-scene/master-the-javascript-interview-what-is-a-promise-27fc71e77261>

