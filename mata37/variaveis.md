---
layout: remark
title: Tipos de dados, constantes, variáveis e operadores aritméticos
---

<div>

## Variáveis

Uma variável é um espaço de armazenamento na memória associado a

- um nome (identificador da variável)
- um valor
- um tipo

O valor da variável pode mudar durante a execução do programa

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

O tipo `float` representa números fracionários.

---

## Tipos

|             tipo             |            valores             |       espaço / precisão        |
|------------------------------|--------------------------------|--------------------------------|
| char                         | números inteiros ou caracteres | Exatamente 1 byte              |
| int                          | números inteiros               | Pelo menos 16 bits (2 bytes)   |
| long (ou long int)           | números inteiros               | Pelo menos 32 bits (4 bytes)   |
| long long (ou long long int) | números inteiros               | Pelo menos 64 bits (8 bytes)   |
| float                        | números fracionários           |                                |
| double                       | números fracionários           | Tão ou mais preciso que float  |
| long double                  | números fracionários           | Tão ou mais preciso que double |
| bool                         | valor-verdade (true/false)     | .                              |

---

## Tipos

Em alguns compiladores, o tipo `int` ocupa 2 bytes, em outros ocupa 4 ou 8 bytes... depende do compilador e, às vezes, do sistema operacional.

---

## Tipos com e sem sinal

Para cada tipo inteiro, existe um tipo correspondente que comporta apenas valores sem sinal (zero ou positivo).

Exemplo:

- `int`: zero, positivos e negativos
- `unsigned int`: zer e positivos

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

---

## Inicialização de variáveis

Referência: <http://www.cplusplus.com/doc/tutorial/variables/>

<!--

# Conversão de tipos

- Implícita (coerção)
- Explícita (*cast*) -->

</div>