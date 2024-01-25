---
layout: remark
title: Tipos de dados, constantes, variáveis e operadores aritméticos
---

{::nomarkdown}
template: inverse

# Variáveis

{% include_relative footer.txt %}

---
# Variáveis

Variáveis são usadas para guardar informações dentro de um programa.

Uma variável possui...

- um **nome** (chamado de identificador da variável)
- um **valor** de um determinado **tipo**

O valor da variável pode mudar durante a execução do programa.

---

# Atribuição

Para **atribuir** um **valor** a uma variável, usa-se `=`. Exemplos:

```python
>>> idade = 18
>>> x = 2 * 3
>>> y = idade + x
>>> y = y + 1
```

Lê-se: `idade` **recebe** `18`

OBS.: `>>>` indica que estamos usando o modo shell. Não digite `>>>`!

---

# Atribuições compostas

Atribuições compostas modificam o valor de uma variável através de uma operação matemática. Elas são apenas formas mais sucintas de escrever certas atribuições. Usa-se `+=` (incremento), `-=` (decremento), `*=` e `/=`. Exemplos:

| atribuição composta |      é equivalente a       |
|---------------------|----------------------------|
| `x += 3`            | `x = x + 3`                |
| `x += y * 2`        | `x = x + y * 2`            |
| `preco -= desconto` | `preco = preco - desconto` |
| `num /= 2`          | `num = num / 2`            |
| `a *= b + 1`        | `a = a * (b + 1)`          |

---

# Identificador

O nome de uma variável (**identificador**) em Python 

- pode conter letras (A-Z, a-z), dígitos (0-9) e underscore (`_`)
- **não pode** começar com um dígito

Exemplos:

> `idade`, `x2`, `anoNascimento`, `mes_nascimento`, `_abc`

--

Python diferencia maiúsculas e minúsculas nos identificadores. Assim, `idade`, `Idade`, `IDADE` e `iDaDe` são 4 identificadores diferentes, que representam 4 variáveis diferentes.

--

Existem palavras reservadas que não podem ser usadas para dar nome as variáveis, tais como `if`, `for`, `while`, entre outras.

---

template: inverse
# Tipos de dados

---
# Tipos

Os tipos de dados básicos em Python são os seguintes:

- `int` - número **inteiro** (incluindo positivos, negativos e zero). Ex.: `-5`
--

- `float` - número de **ponto flutuante** (decimal). Ex.: `3.14` (O separador decimal é o ponto)
--

- `bool` - valor **lógico** (`True` ou `False`)
--

- `str` - tipo **string** (cadeia de caracteres, texto). Ex.: `"Olá, pessoal!"` (aspas duplas) ou `'Olá, pessoal!'` (aspas simples)

--

O **tipo** determina as operações que podem ser realizadas. Exemplos:

- É possível subtrair números (`int` e `float`), mas não é possível subtrair strings
- Não se pode somar um inteiro a uma string

--

Python possui outros tipos, que veremos mais tarde.

---

# type(var)

Para saber o tipo de uma variável (por exemplo, `x`), use `type(x)`.

```python
>>> x = 1
>>> type(x)  #=> class 'int'
>>> y = 3.0
>>> type(y)  #=> class 'float'
```

---

# Conversão de tipos

Em alguns casos pode-se querer converter um valor de um tipo para outro. Para isso, use uma das funções de conversão:

- `int(valor)`
- `float(valor)`
- `bool(valor)`
- `str(valor)`

```python
x = "10"
y = 2
z = int(x) - y
```

---

# Conversão de tipos

```python
>>> x = 3
>>> float(x)   #=> 3.0
>>> str(x)     #=> "3"
>>> ano = "2001"
>>> int(ano)   #=> 2001
```

--

Na conversão de `float` para `int`, as casas decimais são descartadas.

```python
>>> x = 1.99
>>> int(x)   #=> 1
```

{:/}