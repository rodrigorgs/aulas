---
layout: page
---

## Início

Por favor, comece a cronometrar o tempo de completude.

## Arrays

Em JavaScript, Arrays são estruturas mutáveis, ou seja, eles podem ser modificados. Sua declaração é semelhante à de objetos, mas estes são declarados entre colchetes (por exemplo, `vec = [1, 2, 3, 4])`. Há funções que podem modificar ou não um array; por exemplo, há duas formas de se obter um vetor sem o primeiro elemento: `vetor.shift()`, que altera o vetor para um vetor sem o primeiro elemento, e `v1 = v2.slice(1) ` – a função slice corta o vetor, pegando ele a partir do primeiro elemento. Para retornar o tamanho de um vetor em JavaScript, usa-se `vetor.length()`. A função retorna um valor numérico indicando a quantidade de elementos do vetor.

A seguir, retorne o vetor sem alterar a sua quantidade, e verifique se a quantidade de elementos do vetor é a correta com length (para que a atividade esteja correta, tenha certeza de que há apenas um "OK!" no console).

<textarea class="code">
vetor = [1, 2, 3, 4, 5, 6, 7, 8]
vetor.shift();
console.log(vetor);

teste(8, vetor.length);
</textarea>

## Funções

Funções em JavaScript são criadas através do termo function, e estas devem ter um nome e podem ter parâmetros de entrada e saída – os parâmetros de entrada são separados por vírgulas. 

Por exemplo: 

```javascript
 function retornanum (x) { 
 return x; 
}
```

Faça com que funcao1 receba dois parâmetros e retorne a multiplicação dos dois (para que a atividade esteja correta, tenha certeza de que há dois "OK!" no console).

<textarea class="code">
function funcao1(){
}

teste(6, funcao1(3, 2));
teste(18, funcao1(6, 3));
</textarea>

## Funções anônimas

Funções de JavaScript também podem ser anônimas, sendo que estas não são declaradas por function, mas como uma variável comum.

Por exemplo:

```javascript
	let retornanum = (x) => {return x;};
```

Crie a função da atividade anterior, mas como anônima (para que a atividade esteja correta, tenha certeza de que há dois "OK!" no console).

<textarea class="code">
let funcao1 = ;

teste(6, funcao1(3, 2));
teste(18, funcao1(6, 3));
</textarea>

## Fim

Por favor, termine de cronometrar e grave o tempo de completude.
