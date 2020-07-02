---
layout: page
---

## Início

Por favor, comece a cronometrar o tempo de completude.

## Console

Em JavaScript, a função `console.log()` imprime o conteúdo nela passado. Por exemplo, `console.log(“Insira um texto aqui”)` irá imprimir “Insira um texto aqui”, sem aspas (pode-se utilizar aspas simples ou crases também para representar texto). Para separar comandos, pode-se utilizar ponto e vírgula, mas não é obrigatório, já que quebras de linha também significam mudança de comando. 
Uma variável em JavaScript pode ser declarada de três formas: __var__ (não podem ter nomes começando com números, são case sensitive, ou seja, maiúsculas e minúsculas são letras diferentes em nome de variável, e não podem ter nome de palavras-chave), __let__ (podem ser declaradas sem ser inicializadas) e __const__ (o valor delas nunca muda). A atribuição de valor de uma variável se dá por **nome_da_variavel = valor_recebido**.

Para imprimir o valor de uma variável em JavaScript, deve-se passá-la como parâmetro para a função console.log. É possível concatenar variáveis com texto ao se utilizar, por exemplo:
```javascript 
console.log(`Meu nome é ${nome}`);
```
("nome" uma variável), sendo essa a principal utilidade de uso de crase para passar um parâmetro de __console.log__.

Na atividade a seguir, declare duas variáveis, nome e idade, e imprima seu nome e sua idade no console.

<textarea class="code">

</textarea>

## Operações matemáticas

Em JavaScript, variáveis podem ser de diversos tipos, e os tipos de variável podem ser mudados em tempo de execução. Os símbolos de operação numérica podem ser __+__ (soma), __-__ (subtração), __*__ (multiplicação) e __/__ (divisão).

Na atividade a seguir, faça com que total seja a soma de num1 com num2, multiplicada por num3 (para que a atividade esteja correta, tenha certeza de que há apenas um "OK!" no console).

<textarea class="code">
var num1 = 3;
var num2 = 5;
var num3 = 8;

var total;

teste(64, total);
</textarea>

## Objetos

Em JavaScript, objetos possuem seus componentes representados entre chaves, e a separação da atribuição de valor de componentes se dá por vírgulas (por exemplo: `let pessoa { idade: 18, nome: ‘Fulana’}`). Para se obter o valor de um componente de um objeto, deve-se fazer **nome_do_objeto.nome_do_componente** (por exemplo, `pessoa.idade`) ou **nome_do_objeto[nome_do_componente]** (por exemplo, `pessoa[‘nome’]`).

A seguir, assim como na atividade 1, imprima seu nome e sua idade a partir de um objeto.

<textarea class = "code">

</textarea>

## Fim

Por favor, termine de cronometrar e grave o tempo de completude.
