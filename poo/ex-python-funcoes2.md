---
layout: triple-page
title: "Exercícios: funções em Python"
features: [code, python]
---

## 

## Docstring

A função `distancia(x1, y1, x2, y2)` já está implementada corretamente. Documente a função, usando uma docstring com o seguinte texto: "Calcula a distância euclideana entre os pontos (x1, y1) e (x2, y2)"

<textarea class="code lang-python">
import math

def distancia(x1, y1, x2, y2):
  dx = x2 - x1
  dy = y2 - y1
  return math.sqrt(dx ** 2 + dy ** 2)
</textarea>

<div class="testcode">
import re
try:
  assert distancia(2, 2, 5, 6) == 5, 'A implementação da função está incorreta'
  assert distancia.__doc__ is not None, 'A função não possui docstring'
  assert re.sub(r'[ \n]+', ' ', distancia.__doc__.strip()) == "Calcula a distância euclideana entre os pontos (x1, y1) e (x2, y2)", 'O texto da docstring está incorreto'
except AssertionError as e:
  print(e)
</div>

<!-- 
def distancia(x1, y1, x2, y2):
  '''Calcula a distância entre os pontos (x1, y1) e (x2, y2)'''
  dx = x2 - x1
  dy = y2 - y1
  return math.sqrt(dx ** 2 + dy ** 2)
 -->

## Parâmetros default

Implemente a função `segundo_grau(x, a, b, c)`, que retorna o resultado da expressão `ax² + bx + c`. Considere que os parâmetros `b` e `c` são opcionais e, se não forem passados, são iguais a 0.

<textarea class="code lang-python">
def segundo_grau(x, a, b, c):
  return 0
</textarea>

<div class="testcode">
try:
  assert segundo_grau(2, 1, 1, 1) == 7
  assert segundo_grau(3, 4, -2) == segundo_grau(3, 4, -2, 0)
  assert segundo_grau(-2, 7) == segundo_grau(-2, 7, 0, 0)
  assert segundo_grau(-2, 7, c=8) == segundo_grau(-2, 7, 0, 8)
except AssertionError as e:
    print(e)
</div>

<!-- 
def segundo_grau(x, a, b=0, c=0):
  return a * x ** 2 + b * x + c
-->

## Média justa

Crie uma função uma função `maior(lista)`, que retorna o maior elemento de uma lista de números e uma função `media_justa(lista)`, que retorna a média dos números da lista desconsiderando o seu maior elemento. A segunda função deve usar a primeira.

No caso de uma lista vazia, ambas as funções devem retornar zero.

No caso de uma lista unitária, a função `media_justa` deve retornar zero.

<textarea class="code lang-python">
def maior(lista):
  return 0

def media_justa(lista):
  return 0
</textarea>

<div class="testcode">
try:
  assert maior([]) == 0, 'maior([]) deve retornar 0'
  assert maior([4]) == 4, 'Erro em maior()'
  assert maior([3, 5, 2]) == 5, 'Erro em maior()'
  assert maior([8, 3, 5, 2]) == 8, 'Erro em maior()'
  assert maior([8, 3, 5, 9]) == 9, 'Erro em maior()'

  assert media_justa([]) == 0, 'media_justa([]) deve retornar 0'
  assert media_justa([6]) == 0, 'media_justa(l) deve retornar 0 se l possui apenas um elemento'
  assert media_justa([12, 18]) == 12, 'Erro em media_justa()'
  assert media_justa([1, 3, 5]) == 2, 'Erro em media_justa()'

  # a lista não deve ser modificada
  l = [1, 3, 5]
  lcopy = l.copy()
  media_justa(l)
  assert l == lcopy, 'As funções não devem modificar a lista recebida como parâmetro'

  # Um método deve chamar o outro
  from unittest.mock import MagicMock
  maior = MagicMock(return_value=5)
  assert media_justa([5, 10]) == 5, 'Erro em media_justa()'
  assert maior.called, 'O método media_justa deve chamar o método maior'
except AssertionError as e:
  print('Erro:', e)
</div>

<!-- 
def maior(lista):
  if len(lista) == 0:
    return 0
  return max(lista)

def media_justa(lista):
  if len(lista) <= 1:
    return 0
  return (sum(lista) - maior(lista)) / (len(lista) - 1)
 -->

