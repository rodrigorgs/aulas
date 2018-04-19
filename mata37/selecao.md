---
layout: remark
title: Estruturas de seleção
---

<div>

# Estruturas de seleção

As estruturas de seleção determinam quais linhas de código serão executadas de acordo com alguma condição.

Em C++, as principais estruturas de seleção são as seguintes:

- `if` (`if`-`else`, `if`-`else if`...)
- `switch`
- operador ternário (`? :`)

---

# if

Do inglês, *se* (conjunção subordinativa condicional)

Sintaxe:

```c++
if (condicao) bloco_de_codigo
```

O bloco de código pode ser (i) uma única instrução, finalizada por `;`, ou (ii) uma sequência de instruções, delimitadas por `{` e `}`

Semântica:

Executa o `bloco_de_codigo` somente se a `condicao` for verdadeira.

---

# if

Semântica:

![Fluxograma do if](http://1.bp.blogspot.com/-QupejVk4qO4/T86ovh6uhMI/AAAAAAAAAB4/qwIQbytFNZE/s1600/selecao.gif)

---

# if

Exemplo:

```c++
cin >> idade;
if (idade < 18) {
  cout << "Você não é adulto." << endl;
  cout << "Favor trazer autorização do responsável." << endl;
}
cout << "Programa finalizado." << endl;
```

---

# if

Exemplo (uma única instrução):

```c++
cin >> idade;
if (idade < 18)
  cout << "Você não é adulto." << endl;
cout << "Programa finalizado." << endl;
```

OBS.: É uma boa prática usar `{` e `}` mesmo quando só há uma instrução. Ver <https://blog.codecentric.de/en/2014/02/curly-braces/>

---

# if-else

Do inglês, else significa "senão", "caso contrário". O else nunca aparece sozinho; ele é parte da estrutura if-else.

Sintaxe:

```c++
if (condicao) bloco1 else bloco2
```

Semântica: se a condição for verdadeira, executa `bloco1`; se for falsa, executa `bloco 2`

---

# if-else

Semântica:

![Fluxograma do if-else](http://s3.amazonaws.com/magoo/ABAAABVhUAD-49.jpg)

---

# if-else

Exemplo:

```c++
cin >> idade;
if (idade < 18) {
  cout << "Menor de idade" << endl;
} else {
  cout << "Maior de idade" << endl;
}
cout << "Fim"
```

---

# if-else

Exemplo (sem usar chaves):

```c++
cin >> idade;
if (idade < 18)
  cout << "Menor de idade" << endl;
else
  cout << "Maior de idade" << endl;
cout << "Fim"
```

---

# if-else if

Sintaxe:

```c++
if (cond1) bloco1
else if (cond2) bloco2
...
else if (condN) blocoN
else blocoM   // esta linha é opcional
```

Semântica: Executa o bloco1 se a condição cond1 for verdadeira; caso contrário, executa bloco2 se a condição cond2 for verdadeira, e assim por diante. Se todas as condições cond1...condN forem falsas, executa blocoM.

OBS.: Nessa estrutura, executa-se apenas o bloco de código corresponde à *primeira* condição verdadeira (de cima pra baixo).

---

# if-else if

![Fluxograma do else if](https://www.javatpoint.com/cpages/images/elseifladder.png)

---

# if-else if

Exemplo:

```c++
double nota;
cin >> nota;
if (nota > 9.0)
  cout << "Excelente!"
else if (nota > 7.0)
  cout << "Muito bom!"
else if (nota > 5.0)
  cout << "Razoável!"
else
  cout << "Estude mais!"
```

---

# Quiz de if-else-else if

<https://play.kahoot.it/#/k/5de5558a-7573-487b-a03c-f0a2d2f8e62e>

---

# switch

```c++
switch (expressão) {
    case valorA:
        instrucaoA1;
        ...
        instrucaoAN;
        break;
    case valorB:
        instrucaoB1;
        ...
        instrucaoBN;
        break;
    case valorN:
        instrucaoN1;
        ...
        instrucaoNN;
        break;
    default:
        intrucaoD1;
        ...
        instrucaoDN;
}
```

---

# switch

Se esquecer de escrever o break, a execução continua nas instruções do próximo `case` (o que pode ser desejado ou não).

---

# Expressões lógicas

Dentro dos parênteses do if e do else-if devem-se escrever *expressões lógicas*, isto é, expressões que retornam *verdadeiro* (`true`) ou *falso* (`false`) -- tipo `bool` (booleano). Para isso, podemos usar *operadores relacionais* e *operadores lógicos*.

Além disso, por questões de compatibilidade, é possível escrever expressões aritméticas no lugar de expressões lógicas. Nesse caso, 0 (zero) equivale a falso e qualquer outro número equivale a verdadeiro.

Exemplo:

```c++
int x;
cin >> x;
if (x)
  cout << "Valor equivalente a verdadeiro" << endl;
else
  cout << "Valor equivalente a falso" << endl;
```

---

# Operadores relacionais

Usado para fazer comparações entre o valor de duas expressões. São os seguintes:

- `>` - é maior que
- `<` - é menor que
- `>=` - é maior ou igual a (não escrever `=>`)
- `<=` - é menor ou igual a (não escrever `=<`)
- `==` - é igual a (não confundir com `=`)
- `!=` - é diferente de

---

# Operadores relacionais

Exemplo:

```c++
int x;
cin >> x;
if (x > 0)
  cout << "Positivo" << endl;
else if (x < 0)
  cout << "Negativo" << endl;
if (x % 2 == 1)
  cout << "Ímpar" << endl;
```

---

# Operadores lógicos

São usados para combinar expressões condicionais:

- `!` - não (negação)
- `&&` - e (conjunção lógica)
- `||` - ou (disjunção lógica)

A ordem de precedência é `!`, `&&`, `||`.

Exemplo:

```c++
int x;
cin >> x;
if (!(x <= 0) && x % 2 == 1) {
  cout << "Positivo ímpar"
}
```

---

# Operadores lógicos

Exemplo:

```c++
int x, y;
cin >> x >> y;
if (y == 1 || x > 0 && x < 5) {
  cout << "Ok"
}
```

Por causa das regras de precedência, a expressão é equivalente a `(y == 1) || (x > 0 && x < 5)`.

---

# Avaliação em curto-circuito

Ao computar o resultado de uma expressão lógica com operadores `&&` e `||`, o computador só avalia as subexpressões se necessário.

- `A && B`: se A for falso, a expressão B não é avaliada, pois qualquer que seja seu valor, a expressão `A && B` é falsa
- `A || B`: se A for verdadeiro, a expressão B não é avaliada, pois qualquer que seja seu valor, a expressão `A || B` é verdadeira

---

# Operador ternário

Expressão que retorna um ou outro resultado de acordo com a condição.

Sintaxe:

`cond ? a : b`

Semântica: se `cond` for uma condição verdadeira, retorna `a`; caso contrário, retorna `b`.

---

# Operador ternário

Exemplo:

```c++
string resultado;
int x = 5;

resultado = x > 0 ? "positivo" : "negativo ou zero";
```

---

# Operador ternário

Exemplo:

```c++
int qtdImpares = 0;
int x;

cin >> x;
qtdImpares += (x % 2 == 1 ? 1 : 0)
```

---

# Exemplo: 8-ball

O usuário faz uma pergunta e o programa responde uma das seguintes frases:

- Sim!
- Não!
- Talvez!

Usar o gerador de números aleatórios

</div>