---
layout: page
title: Exercícios em Python
features: [code, python]
---

## Introdução

Nestes exercícios você vai criar **funções** segundo alguma especificação. Os valores de entrada do seu algoritmo não serão digitados pelo usuário; em vez disso, os valores de entrada serão fornecidos por um programa Python que usa `assert`s para testar se a saída está correta. Fique à vontade para criar mais `assert`s.

## Retângulo

Crie uma função que recebe como medidas a base e altura de um retângulo e retorna a sua área.

<textarea class="code lang-python">
def calcula_area(base, altura):
  return 0

assert calcula_area(0, 0) == 0
assert calcula_area(3, 4) == 12
</textarea>

## IMC

Crie uma função que determina se uma pessoa está obesa. Uma pessoa obesa é aquela que possui índice de massa corporal (IMC) igual ou superior a 30. O IMC é calculado pela razão entre o peso e o quadrado da altura de uma pessoa.

<textarea class="code lang-python">
def esta_obesa(peso, altura):
  return false

assert esta_obesa(70, 1.70) == False
assert esta_obesa(170, 1.70) == True
</textarea>

## Imposto

Crie uma função que classifique uma pessoa em uma das seguintes categorias, de acordo com a idade: "bebê", "criança", "adolescente", "adulta". Considere o seguinte:

- bebê: 0 a 1 anos
- criança: 2 a 11 anos
- adolescente: 12 a 17 anos
- adulta: 18 anos ou mais

<textarea class="code lang-python">
def faixa_etaria(idade):
  return "bebê"

assert faixa_etaria(1) == "bebê"
assert faixa_etaria(5) == "criança"
assert faixa_etaria(15) == "adolescente"
assert faixa_etaria(25) == "adulta"
</textarea>

## Linha de caracteres

Crie uma função que recebe um caractere e um número inteiro, `N`, e retorna uma string consistindo do caractere repetido `N` vezes.

<textarea class="code lang-python">
def linha(c, n):
  s = "****"
  return s

assert linha("*", 5) == "*****"
assert linha("#", 2) == "##"
assert linha("@", 0) == ""
</textarea>

## Retângulo desenhado

Crie uma função que recebe um caractere e dois inteiros, base e altura, e retorna uma string representando um retângulo com as dimensões fornecidas. Use a função `linha` desenvolvida anteriormente (você precisará copiar a função aqui).

<textarea class="code lang-python">
def retangulo(c, base, altura):
  s = "****"
  s += "****"
  return s

assert retangulo("*", 4, 2) == "****\n****\n"
assert retangulo("#", 5, 1) == "#####\n"
</textarea>

## Lista sequencial

Crie uma função que recebe um número inteiro, `N` e retorna uma lista com todos os números inteiros de 1 a `N`, em ordem crescente. Se `N` for zero ou negativo, deve ser retornada uma lista vazia.

<textarea class="code lang-python">
def sequencia(n):
  return []

assert sequencia(3) == [1, 2, 3]
assert sequencia(1) == [1]
assert sequencia(-1) == []
</textarea>

## Produtório

Crie uma função que recebe uma lista de números e retorna o seu produto ou 1 em caso de lista vazia.

<textarea class="code lang-python">
def produtorio(lista):
  resultado = 1
  return resultado

assert produtorio([]) == 1
assert produtorio([1, 2, 3]) == 6
assert produtorio([1, 0, 3]) == 0
</textarea>
