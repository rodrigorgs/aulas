---
layout: page
title:  "Programação concorrente"
date:   2017-03-22 16:40:00 -0300
categories: aula
---

<!-- 
Java:

https://docs.oracle.com/javase/tutorial/essential/concurrency/index.html
http://www.vogella.com/tutorials/JavaConcurrency/article.html
http://winterbe.com/posts/2015/04/07/java8-concurrency-tutorial-thread-executor-examples/

 -->

Motivação: programas interativos (user interface), aguardar downloads, ler arquivos, executar vários programas ao mesmo tempo.

Concorrência é assunto da disciplina de sistemas operacionais. Aqui vamos abordar alguns aspectos do ponto de vista de linguagens de programação.

## Paralelismo

Em computação, paralelismo é a execução simultânea de instruções. Paralelismo pode ocorrer, por exemplo, ao executar duas tarefas diferentes em dois processadores diferentes do mesmo computador, ou ao executar duas partes de uma tarefa em computadores diferentes.

Por exemplo, se queremos criar miniaturas de uma coleção de 100 imagens, e temos 4 computadores à nossa disposição, podemos distribuir 25 imagens para cada computador, de forma que os 4 computadores executarão parte da tarefa em paralelo.

## Concorrência

Um programa é concorrente quando é composto de tarefas que podem ser executadas em ordens diferentes. Considere um programa que baixa duas imagens da internet e cria uma nova imagem composta das duas imagens, lado a lado. O programa pode ser decomposto nas seguintes tarefas:

    a. Baixa imagem 1
    b. Baixa imagem 2
    c. Cria imagem combinada

Note que as tarefas (a) e (b) podem ser executadas em qualquer ordem (a, b ou b, a), sem afetar o resultado. Um programa concorrente deve garantir apenas que a tarefa (c) é executada após (a) e (b), mas deve funcionar independentemente da ordem de execução de (a) e (b). Note que a ordem depende de fatores externos ao programa: talvez a imagem (a) demore mais para ser baixada, por estar localizada em um servidor mais lento.

Um programa concorrente pode ser executado em um ambiente de execução paralela (múltiplos processadores) ou não. Se houver apenas um processador disponível, o processador deve intercalar a execução entre as tarefas (a) e (b).

Como não é possível determinar a ordem de execução das instruções (i.e., cada vez que o programa é executado, a ordem de execução pode ser diferente), o resultado de um programa concorrente mal projetado é imprevisível. Considere o seguinte exemplo em pseudocódigo:

```
a = 4;

execute concorrentemente { a = a + 3; } // Tarefa 1
execute concorrentemente { a = a * 2; } // Tarefa 2
```

Existem duas sequências possíveis para execução das tarefas 1 e 2: 1, 2 ou 2, 1. A primeira ordem resulta no valor 14; a segunda resulta no valor 11. Isso é chamado de *condição de corrida*.

## Preempção e troca de contexto

As tarefas podem ser quebradas em instruções de baixo nível, e o processador consegue alternar rapidamente entre instruções de diferentes tarefas para dar a ilusão de que as duas tarefas estão sendo executadas ao mesmo tempo, em paralelo.

A interrupção de uma tarefa antes de sua conclusão para dar lugar a outra tarefa é chamada de preempção da primeira tarefa, e a troca de uma tarefa para outra é denominada troca de contexto.

Em um exemplo com duas tarefas concorrentes, a e b, cada uma podendo ser decomposta em 5 instruções de baixo nível, a execução poderia ocorrer da seguinte forma:

```
  b bb b b
aa a  a a
---------------> tempo
```

No exemplo, a tarefa a sofreu preempção 3 vezes.

Considere novamente o seguinte exemplo:

```
a = 4;

execute concorrentemente { a = a + 3; } // Tarefa 1
execute concorrentemente { a = a * 2; } // Tarefa 2
```

Cada tarefa pode ser decomposta em várias instruções de baixo nível:

```
a = 4;

execute concorrentemente { // Tarefa 1
    copie o valor da variável 'a' para o registrador 1
    incremente o registrador 1 em 3 unidades
    copie o valor do registrador 1 para a variável 'a'
}
execute concorrentemente { // Tarefa 2
    copie o valor da variável 'a' para o registrador 2
    multiplique o registrador 2 por 2
    copie o valor do registrador 2 para a variável 'a'
}
```

Dependendo de quando ocorrem trocas de contexto entre as tarefas 1 e 2, o resultado pode ser muito diferente do esperado. Exemplo:

|   Tarefa 1                                         |   Tarefa 2                                         |   Valores           |
|----------------------------------------------------|----------------------------------------------------|---------------------|
| copie o valor da variável 'a' para o registrador 1 |                                                    | a=4, **r1=4**       |
| incremente o registrador 1 em 3 unidades           |                                                    | a=4, **r1=7**       |
|                                                    | copie o valor da variável 'a' para o registrador 2 | a=4, r1=7, **r2=4** |
|                                                    | multiplique o registrador 2 por 2                  | a=4, r1=7, **r2=8** |
|                                                    | copie o valor do registrador 2 para a variável 'a' | **a=8**, r1=7, r2=8 |
| copie o valor do registrador 1 para a variável 'a' |                                                    | **a=7**, r1=7, r2=8 |

## O caso de JavaScript

JavaScript permite escrever programas concorrentes, com uma diferença fundamental: não há preempção, isto é, o ambiente de execução JavaScript executa cada tarefa completamente antes de executar outra tarefa (semântica *run-to-completion*). Isso torna a escrita de programas concorrentes simples muito mais fácil, uma vez que diminui o número de sequências de execução possíveis.

O modelo de concorrência do JavaScript é baseado em um **loop de eventos**, que adiciona e remove itens de uma **fila de tarefas**. O ambiente de execução executa todas as tarefas em sequência, até terminarem as tarefas da fila. Nesse momento, o controle é passado para o navegador, para cuidar de atualizações da interface, leitura de dispositivos de entrada, acesso a rede, entre outras responsabilidades. Então o navegador acessa a fila de tarefas novamente, e executa as tarefas da fila até o final, e assim por diante.

## Run-to-completion

Como já dito anteriormente, o JavaScript não interrompe um código sendo executado, nem mesmo para lidar com a interface do usuário! Execute o exemplo abaixo e tente *rolar a página* enquanto a função está sendo executada:

<textarea class="code">
function funcaoDemorada() {
    var i = 0, j;
    for (i = 0; i < 999999999; i++) {
        j = i * 2;
    }
    console.log(i);
}
funcaoDemorada();
</textarea>

Ou então execute a função demorada e, imediatamente depois, clique neste <button onclick="alert('oi')">botão</button>.

## Agora ou depois?

Na programação web com JavaScript, é muito comum escrever funções que são executadas em algum momento no futuro, em resposta a algum evento. Exemplos:

- mudar o tamanho do texto ao clicar em um botão
- atualizar uma parte da página ao receber a resposta de uma requisição AJAX
- mover um elemento da página após um intervalo de tempo determinado

Considere o exemplo de baixar uma página da web via AJAX (*asynchronous JavaScript and XML*) e mostrar seu conteúdo no console. Um maneira ingênua de fazer isso seria (em pseudocódigo):

```javascript
var codigo = download('https://jsonplaceholder.typicode.com/todos/1');
console.log(codigo);
```

O fato é que o download da página pode demorar até alguns segundos, e não queremos deixar a interface do navegador travada enquanto esperamos o download concluir. É por isso que normalmente as funções de download via AJAX são **assíncronas**, isto é, elas retornam imediatamente para que a próxima instrução possa ser executada. No entanto, no exemplo acima, provavelmente não dará tempo de terminar o download da página no momento que a segunda linha for executada. É por isso que é mais comum usar **callbacks**, isto é, passar para a função *ajax* uma função que será chamada quando o download for concluído. Algo assim:

<script type="text/javascript">
function download(url, f) {
  return $.get(url, f);
}
</script>

<textarea class="code">
download('https://jsonplaceholder.typicode.com/todos/1', function (dados)  {
    console.log(dados);
});
console.log('fim');
</textarea>

Note que, nesse exemplo, o texto `fim` será exibido antes do conteúdo da página, pois a linha 2 será executada apenas depois que o download for concluído.

## Exemplos

A função JavaScript `setTimeout(f, ms)` adiciona `f` à fila de tarefas após `ms` milissegundos.

O que acontece quando você roda o seguinte código?

<textarea class="code">
var x = 1;
setTimeout(function () {
    console.log(x);
  },
  500);  // 500 milisegundos
x = 2;
</textarea>

E se o tempo for zero?

<textarea class="code">
var x = 1;
setTimeout(function () {
    console.log(x);
  },
  0);
x = 2;
</textarea>

Chamar `setTimeout` com instante 0 não faz com que a função seja chamada instantaneamente; em vez disso, a função é inserida no final da fila de tarefas e só será executada depois. Conceitualmente, podemos dividir o programa em partes que serão executadas *agora* (linhas 1, 2, 4, 5 e 6) e partes que serão executadas *depois* (linha 3). Diz-se que o `console.log` na linha 3 está sendo chamado de forma *assíncrona*.

E no código, a seguir, qual é o resultado?

<textarea class="code">
var inicio = new Date();
setTimeout(
  function() {
    var fim = new Date();
    console.log('Tempo decorrido:', fim - inicio, 'ms');
  }, 500
);
while (new Date() - inicio < 1000) {};
</textarea>

E no código a seguir?

<textarea class="code">
for (var i = 1; i <= 3; i++) {
  setTimeout(
    function() {
      console.log(i);
    }, 0);
}
</textarea>

<!-- 
var inicio = new Date();
function resultado() {
  var fim = new Date();
  console.log('resultado:', fim - inicio, 'ms');
}
function espera2000() {
  var fim;
  fim = new Date();
  console.log('while inicio: ', fim - inicio, 'ms');
  while (new Date() - inicio < 2000) {};
  fim = new Date();
  console.log('while:', fim - inicio, 'ms');
}
setTimeout(resultado, 500);
setTimeout(espera2000, 499);
while (new Date() - inicio < 1000) {};

 -->


### Referências:

- <https://blog.getify.com/concurrently-javascript-1/>
- <https://developer.mozilla.org/en-US/docs/Web/JavaScript/EventLoop>
- <https://www.cs.colorado.edu/~kena/classes/5828/f15/lectures/29-asyncjavascriptcallbacks.pdf>
- <https://www.cs.colorado.edu/~kena/classes/5828/f15/lectures/30-asyncjavascriptpromises.pdf>