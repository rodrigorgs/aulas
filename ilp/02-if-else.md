---
layout: remark
title: Estruturas de seleção
---

{::nomarkdown}
template: inverse

# Estruturas de seleção (condicionais)

{% include_relative footer.txt %}

---

# Estruturas de seleção

As estruturas de seleção determinam, com base em uma **condição**, se certas linhas de código serão executadas ou não.

Em Python, usamos as palavras-chave `if` (se), `else` (caso contrário) e `elif` (abreviação de *else if*)

---

# if

Do inglês, *se* (conjunção subordinativa condicional)

Sintaxe:

```c++
if condicao:
    bloco de código
```

Significado: o `bloco de código` (sequência de instruções) é executado somente se a `condicao` for verdadeira

Note:

- Depois da condição deve vir um sinal de dois-pontos (`:`)
- A sequência de instruções deve estar indentada em relação à palavra `if` (isto é, deve estar mais à direita)

---

# if

Exemplo:

```python
idade = int(input("Digite sua idade: "))
if idade < 18:
    print("Você não é adulto.")
    print("Favor trazer autorização do responsável.")
print("Programa finalizado.")
```

- Sempre que você executar o programa, ele vai pedir sua idade e, ao final, sempre vai escrever `Programa finalizado.`
- Os dois primeiros `print`s, no entanto, só vão ser executados se você digitar um número menor que 18
- O bloco de código do `if` é delimitado pela indentação (espaços à esquerda)

Visualize a execução do código no [Python Tutor](http://pythontutor.com/visualize.html)

---

# Indentação

- Indentar significa inserir espaços em branco no início de uma linha de texto
- Você pode usar espaços ou tabs, mas não misture os dois no mesmo código-fonte
- Python usa indentação para determinar onde começa e onde termina um bloco de código
  - uma sequência de linhas com a mesma indentação (mesmo número de espaços) é um bloco de código
- Se você indentar seu código errado, o interpretador vai emitir um `IndentationError`. Exemplos de erros:

```python
# ERRADO!
if 1 < 2:
print("Menor")

# ERRADO!
  if 1 < 2:
print("Menor")

# ERRADO!
if idade < 18:
    print("Você não é adulto.")
     print("Favor trazer autorização do responsável.")
```

---

# Como escrever condições

Use os operadores relacionais:

- `>` - é maior que
- `<` - é menor que
- `>=` - é maior ou igual a (não escrever `=>`)
- `<=` - é menor ou igual a (não escrever `=<`)
- `==` - é igual a (não confundir com `=`)
- `!=` - é diferente de

---

# if

Considere agora o seguinte programa:

```python
idade = int(input("Digite sua idade: "))
if idade >= 18:
    print("Você é adulto.")
if idade < 18:
    print("Você não é adulto.")
```

Note que as condições são opostas.

---

# if-else

Do inglês, else significa "senão", "caso contrário". O else nunca aparece sozinho; ele é parte da estrutura if-else.

Sintaxe:

```c++
if condicao:
    bloco1
else:
    bloco2
```

Semântica: se a `condicao` for verdadeira, executa `bloco1`; se for falsa, executa `bloco2`

---

# if-else

Exemplo:

```python
idade = int(input("Digite sua idade: "))
if idade >= 18:
    print("Você é adulto.")
else:
    print("Você não é adulto.")
print("Fim")
```

---

# ifs aninhados

```python
idade = int(input("Digite sua idade: "))
if idade >= 18:
    print("Você é adulto.")
else:
    if idade >= 12:
        print("Você é adolescente.")
    else:
        print("Você é criança.")
print("Fim")
```

---

# if-elif

Sintaxe:

```python
if cond1:
    bloco1
elif cond2:
    bloco2
elif condN:
    blocoN
else:     # o else é opcional
    blocoM   
```

Semântica: Executa o `bloco1` se a condição `cond1` for verdadeira; caso contrário, executa `bloco2` se a condição `cond2` for verdadeira, e assim por diante. Se todas as condições `cond1`...`condN` forem falsas, executa `blocoM`.

OBS.: Nessa estrutura, executa-se apenas o bloco de código corresponde à *primeira* condição verdadeira (de cima pra baixo).

---

# if-elif

```python
idade = int(input("Digite sua idade: "))
if idade >= 18:
    print("Você é adulto.")
elif idade >= 12:
    print("Você é adolescente.")
else:
    print("Você é criança.")
print("Fim")
```

---

# if-elif

Exemplo:

```python
nota = float(input())
if nota > 9.0:
    print("Excelente!")
else if nota > 7.0:
    print("Muito bom!")
else if nota > 5.0:
    print("Razoável!")
else
    print("Estude mais!")
```

---

template: inverse

# Expressões lógicas (booleanas)

---

# Expressões lógicas

Dentro dos parênteses do if e do else-if devem-se escrever *expressões lógicas*, isto é, expressões que retornam *verdadeiro* (`True`) ou *falso* (`False`) -- tipo `bool` (booleano). Para isso, podemos usar *operadores relacionais* e *operadores lógicos*.

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

```python
x = int(input())
if x > 0:
  print("Positivo")
elif x < 0:
  print("Negativo")
if x % 2 == 1:
  print("Ímpar")
```

---

# Operadores lógicos

São usados para combinar expressões condicionais:

- `not` - não (negação)
- `and` - e (conjunção lógica)
- `or` - ou (disjunção lógica)

A ordem de precedência é `not`, `and`, `or`

Exemplo:

```python
x = int(input())
if not (x <= 0) and x % 2 == 1:
  print("Positivo impar")
```

---

# Operadores lógicos

Exemplo:

```python
x, y = input().split()
x = int(x)
y = int(y)
if y == 1 or x > 0 and x < 5:
  print("Ok")
```

Por causa das regras de precedência, a expressão é equivalente a `(y == 1) or (x > 0 and x < 5)`.

---

# Avaliação em curto-circuito

Ao computar o resultado de uma expressão lógica com operadores `and` e `or`, o interpretador só avalia as subexpressões se necessário.

- `A and B`: se A for falso, a expressão B não é avaliada, pois qualquer que seja seu valor, a expressão `A and B` é falsa
- `A or B`: se A for verdadeiro, a expressão B não é avaliada, pois qualquer que seja seu valor, a expressão `A or B` é verdadeira

{:/}