---
layout: remark
title: Tipos de dados, constantes, variáveis e operadores aritméticos
---

<div>

## Variáveis

Uma variável é um espaço de armazenamento na memória associado a

- um nome (chamado de **identificador** da variável)
- um valor
- um tipo

O valor da variável pode mudar durante a execução do programa.

---

## Identificador

O nome de uma variável em C++ deve começar com uma letra ou underscore (`_`) e pode ser seguido de zero ou mais letras, números e underscores. Ex.:

> `idade`, `x2`, `anoNascimento`, `mes_nascimento`, `_abc`

C++ diferencia maiúsculas e minúsculas nos identificadores. Assim, `idade`, `Idade`, `IDADE` e `iDaDe` são 4 identificadores diferentes, que representam 4 variáveis diferentes.

Existem palavras reservadas que não podem ser usadas para dar nome as variáveis, tais como `if`, `case`, `while`, `int`, `double`, entre outras.

---

## Tipos

Cada variável possui um tipo. O tipo representa quais são os valores e as operações possíveis com a variável.

Por exemplo, o tipo `int` representa números inteiros, incluindo o zero, números positivos e números negativos. Com variáveis do tipo `int` é possível realizar soma, subtração, divisão, multiplicação, resto da divisão, dentre outras operações.

O tipo `double` representa números fracionários.

---

|             tipo             |            valores             |       espaço / precisão        |
|------------------------------|--------------------------------|--------------------------------|
| char                         | números inteiros ou caracteres | Exatamente 1 byte              |
| int                          | números inteiros               | Pelo menos 16 bits (2 bytes)   |
| long (ou long int)           | números inteiros               | Pelo menos 32 bits (4 bytes)   |
| long long (ou long long int) | números inteiros               | Pelo menos 64 bits (8 bytes)   |
| float                        | números fracionários (`2.5f`)  |                                |
| double                       | números fracionários (`2.0`)   | Mais preciso que float         |
| long double                  | números fracionários (`2.0`)   | Mais preciso que double        |
| bool                         | valor-verdade (true/false)     | .                              |

---

## Tipos

Note que o valor `2.0` representa um valor do tiplo `double`, enquanto `2.0f` representa um valor do tipo `float`.

---

## Tipos

O tipo `string` representa uma cadeia de caracteres (texto). Para usá-lo, você precisa adicionar `#include <string>` no início do código-fonte. No tipo string, cada caractere ocupa 1 byte.

---

## Tipos

Em alguns compiladores, o tipo `int` ocupa 2 bytes, em outros ocupa 4 ou 8 bytes... depende do compilador e, às vezes, do sistema operacional.

---

## Tipos com e sem sinal

Para cada tipo inteiro, existe um tipo correspondente que comporta apenas valores sem sinal (zero ou positivo).

Exemplo:

- `int`: zero, positivos e negativos
- `unsigned int`: zero e positivos

---

## Tipos e faixa de valores

O número de bits/bytes de um tipo representa a quantidade de valores diferentes que podem ser representados pelo tipo. Ex.:

| Tamanho |             Valores diferentes            |
|---------|-------------------------------------------|
| 8 bits  | 2^8 = 256 valores                         |
| 16 bits | 2^16 = 65 536 valores                     |
| 32 bits | 2^32 = 4 294 967 296 valores              |
| 64 bits | 2^64 = 18 446 744 073 709 551 616 valores |

Assim, o tipo `char` representa valores de -127 a 128, e `unsigned char` representa valores de 0 a 255.

---

## Declaração de variáveis

Antes de usar uma variável no seu programa, é necessário declará-la. A declaração indica o tipo e o nome da variável. Formato geral:

```
<tipo> <identificador1>, <identificador2>, ..., <identificadorN>;
```

Exemplo de declaração:

```c++
int idade;
float altura, peso;
char a, b, c, d;
```

---

## Atribuição

**Atribuição** de um valor a uma variável é o ato modificar o valor de uma variável. Isso é feito com o operador `=` (*igual*). A atribuição de uma variável pode ser feita várias vezes. Exemplo:

```c++
int x, y;
x = 1;
y = 2;
x = x + y;
```

---

Como [ler e executar código](https://medium.com/bits-and-behavior/teaching-a-strategy-for-reading-code-fbc9f4044cab)

```c++
int x = 1;
int y = 2;
int z = x;
x = y;
y = z;
```

Qual o valor de x, y e z ao final da execução do programa?

---

## Inicialização de variáveis

A primeira atribuição de uma variável é chamada de **inicialização** da variável. Todas as variáveis devem ser inicializadas antes de serem usadas (antes de serem usadas em expressões, antes de serem impressas na tela...), pois uma variável que não foi inicializada pode conter qualquer valor.

No exemplo abaixo, qual é o valor de `y`? Pode ser -4, 2345, -1038... não dá pra saber.

```c++
int x, y;
y = x + 1;
cout << y << endl;
```

---

## Inicialização de variáveis

A inicialização de variáveis pode ser feita junto com sua declaração. Exemplo:

```
double pi = 3.14159, r = 2.5, area = 2 * pi * r * r;
```

---

## Atribuições compostas

Atribuições compostas modificam o valor de uma variável através de uma operação matemática. Elas são apenas formas mais sucintas de escrever certas atribuições. Exemplos:

| atribuição composta |      é equivalente a       |
|---------------------|----------------------------|
| `x += 3`            | `x = x + 3`                |
| `x += y * 2`        | `x = x + y * 2`            |
| `preco -= desconto` | `preco = preco - desconto` |
| `num /= 2`          | `num = num / 2`            |
| `a *= b + 1`        | `a = a * (b + 1)`          |

---

## Incremento e decremento

São formas ainda mais sucintas de adicionar ou subtrair 1 unidade de uma variável. Assim, as três linhas a seguir são equivalentes:

```c++
x = x + 1;
x += 1;
x++;
```

As três linhas a seguir também são equivalentes:

```c++
x = x - 1;
x -= 1;
x--;
```

---

## Incremento e decremento como expressões

Os operadores `++` e `--` podem ser em expressões aritméticas, e podem ser usados como sufixo (ex.: `x++`) ou prefixo de variáveis (ex.: `++x`), com diferenças sutis. Exemplos:

```c++
int x = 5, y;
y = x++;
cout << x << " " << y << endl;
```

É equivalente a

```c++
int x = 5, y;
y = x;
x = x + 1;
cout << x << " " << y << endl;
```

---

## Incremento e decremento como expressões

No entanto,

```c++
int x = 5, y;
y = ++x;
cout << x << " " << y << endl;
```

é equivalente a

```c++
int x = 5, y;
x = x + 1;
y = x;
cout << x << " " << y << endl;
```

---

## Constantes

Constantes são como variáveis, exceto que elas devem ser inicializadas na declaração e o seu valor não pode mudar. A declaração é feita escrevendo-se a palavra `const` antes da declaração. Exemplo:

```c++
const float PI = 3.14f, E = 2.7f;
const double NUMERO_DE_AVOGADRO = 6.02e23;
```

Por convenção, geralmente usam-se letras maiúsculas para nomear constantes, mas isso não é obrigatório.

Desafio: tente alterar o valor da constante depois de definido.

---

## define

A palavra `#define` pode ser usada para definir macros e constantes. Exemplo:

```c++
#include <iostream>
using namespace std;

#define PI 3.14159

int main() {
	cout << "PI = " << PI << endl;
	return 0;
}
```

O que acontece nesse caso é que o compilador troca todas as referências a PI (exceto entre parênteses) no programa pelo seu valor (`3.14159`). 

---

## define

Existem usos mais avançados do `#define`, mas sugiro usar com moderação, pois seu programa pode ficar difícil de entender!

```c++
#include <iostream>
using namespace std;

#define INTEIRO int
#define INCREMENTA_X x++

int main() {
	INTEIRO x = 1;
	INCREMENTA_X;
	cout << x << endl;
	return 0;
}
```

O que acontece nesse caso é que o compilador troca todas as referências a PI (exceto entre parênteses) no programa pelo seu valor (`3.14159`). 

---

## Referências

- <http://www.cplusplus.com/doc/tutorial/variables/>
- <http://www.cplusplus.com/doc/tutorial/operators/>

--

## Conversão de tipos

Em alguns casos pode-se converter um valor de um tipo para outro. A conversão pode ser:

- Implícita (coerção)
- Explícita (*cast*)

--

## Conversão implícita (coerção)

Pode ocorrer quando se tenta armazenar um valor de um tipo em uma variável de outro tipo. Ex.:

```c++
int x = 3.9;    //=> 3
double y = 2;   //=> 2.0
float z = 4.4;  //=> 4.4f
```

Nas conversões de número decimal para inteiro, o número é truncado (i.e., a parte decimal é descartada)

--

## Conversão implícita (coerção)

Também pode ocorrer dentro de expressões aritméticas:

```c++
double x = 3.5 + 2;
```

O número 2 é convertido para double (2.0) antes de ser feita a soma.

--

## Conversão explícita (cast)

Você também pode explicitar que deseja fazer uma conversão. Para isso, use o formato `(tipo)valor`. Ex.:

```c++
double x = 3.7;
cout << (int)x << endl;  //=> 3
```

--

## Conversão explícita (cast)

Atenção: o cast tem precedência sobre outras operações. Assim, as duas linhas a seguir produzem resultados diferentes:

```c++
cout << (double)9 / 2 << endl;
cout << (double)(9 / 2) << endl;
```

- No primeiro caso, o número `9` é convertido para `double` antes de ser realizada a divisão
- No segundo caso, o resultado da operação `9 / 2` é convertido para `double`

</div>