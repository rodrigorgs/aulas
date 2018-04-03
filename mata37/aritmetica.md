---
layout: remark
title: Expressões aritméticas em C++
---

<div>
## Expressões aritméticas

Expressões aritméticas podem ser:

- um número
  - inteiro (`int`) ou racional (`float`, `double`)
- uma variável numérica
- uma operação aritmética envolvendo duas expressões aritméticas
- a aplicação de uma função a uma expressão aritmética

---

## Exemplos

`5` é uma expressão aritmética

`-8` é uma expressão aritmética

`5 + 7` é uma expressão aritmética (operação envolvendo dois números)

`(5 + 7) + 3` é uma expressão aritmética (operação envolvendo duas expressões aritméticas, sendo que a da direita é um número)

`cos(3)` é uma expressão aritmética (aplicação de função a um número)

`cos(5 + 7)` é uma expressão aritmética (aplicação de função a uma expressão aritmética)

---

## Números

Números (também chamados de constantes numéricas ou literais numéricos), podem ser representados de diferentes formas em C++:

- Números inteiros:
  - Base decimal: 4, 0, -3...
  - Base hexadecimal: 0xFF, -0x3B, 0x20
  - Base octal (menos comum): 0123
- Números racionais:
  - Base decimal: 4.3, -2.8, 8265.9182
  - Base decimal e notação científica: 23e-2 (23 vezes 10 elevado a -2), -2.3e5
- Indicadores de tipo:
  - Tipo float: (coloca um *f* no final) 2.3f
  - Tipo long: (coloca um *l* no final) 123456789l
  - Tipo int: não precisa colocar nenhuma letra no final, ex.: 123
  - Tipo double: não precisa colocar nenhuma letra no final, ex.: 1.23

Referência: <http://www.cplusplus.com/doc/tutorial/constants/>

---

## Conversão de tipos

O C++ realiza certas conversões de tipos automaticamente:

```c++
int x = 2.3;   // converte double (2.3) para int (2)
float y = 2.3; // converte double (2.3) para float (2.3f)
double z = 3;  // converte int (3) para double (3.0)
```

---

## Operadores aritméticos

| Símbolo |   significado    |
|---------|------------------|
| `+`     | soma             |
| `-`     | subtração        |
| `*`     | multiplicação    |
| `/`     | divisão\*        |
| `%`     | resto da divisão |

\* No caso da divisão, se os dois operandos forem de tipos inteiros (`int`, `long`...), então será realizada a **divisão inteira**, isto é, o resultado será um número inteiro (a parte decimal é desprezada). Exemplos:

- `10 / 4` ==> `2`
- `10.0 / 4` ==> `2.5`
- `10 / 4.0` ==> `2.5`
- `10.0 / 4.0` ==> `2.5`

Referência: <http://www.cplusplus.com/doc/tutorial/operators/>

---

## Precedência de operadores

- 1º nível: \* / % (maior precedência)
- 2º nível: + - (menor precedência)
- Duas operações no mesmo nível: executar da esquerda para a direita

Exemplos:

- 1 + 2 * 3 = ?
- 6 * 6 / 12 = ?
- 4 / 2 * 3 = ?

---

## Divisão e resto da divisão

- Como determinar se um número é par?
- Como extrair o dígito das unidades de um número?
- Como extrair o dígito das dezenas de um número?

---

## Funções matemáticas

Para usar as funções matemáticas, você precisa incluir a seguinte linha no início de seu código:

```c++
#include <cmath>
```

- Funções trigonométricas: `sin(x)`, `cos(x)`, `tan(x)`. Ex.: `cos(3.14)` (note que o valor passado deve estar em radianos)
- Valor absoluto: `abs(x)` (tipo int), `fabs(x)` (tipo double). Ex.: `abs(-11)` ==> `11`, `fabs(-11.3)` => `11.3`
- Potenciação: `pow(base, expoente)`, `sqrt(x)`. Ex.: `pow(2, 3)` ==> `8`.
- Logaritmos: `log(x)` (logaritmo natural, base e), `log10(x)` (base 10)
- Arredondamento: `ceil(x)` (arredonda pra cima), `floor(x)` (arredonda pra baixo), onde `x` é do tipo `double`

OBS.: a função `abs(x)` (tipo `int`) está definida no arquivo `cstdlib` (use `#include <cstdlib>`.

Referência: <http://www.cplusplus.com/reference/cmath/>

</div>
