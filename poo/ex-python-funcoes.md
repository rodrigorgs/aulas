---
layout: triple-page
title: "Exercícios: funções em Python"
features: [code, python]
---

## Distância

Crie uma função `distancia(x1, y1, x2, y2)`, que calcula a distância euclideana entre os pontos (x1, y1) e (x2, y2). A função deve ter uma docstring para documentar o seu uso.

<textarea class="code lang-python">
import math

def distancia(x1, y1, x2, y2):
  return 0

### Testes
assert distancia(2, 2, 5, 6) == 5
assert distancia.__doc__ is not None
</textarea>

<!-- 
def distancia(x1, y1, x2, y2):
  '''Calcula a distância entre os pontos (x1, y1) e (x2, y2)'''
  dx = x2 - x1
  dy = y2 - y1
  return math.sqrt(dx ** 2 + dy ** 2)
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

### Testes
assert maior([]) == 0
assert maior([4]) == 4
assert maior([3, 5, 2]) == 5
assert maior([8, 3, 5, 2]) == 8
assert maior([8, 3, 5, 9]) == 9

assert media_justa([]) == 0
assert media_justa([6]) == 0
assert media_justa([12, 18]) == 12
assert media_justa([1, 3, 5]) == 2

# a lista não deve ser modificada
l = [1, 3, 5]
lcopy = l.copy()
media_justa(l)
assert l == lcopy

from unittest.mock import MagicMock
maior = MagicMock(return_value=5)
assert media_justa([5, 10]) == 10
maior.assert_called()
</textarea>

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

## Preço final

Escreva uma função `preco_final(preco_produto, desconto, valor_frete)`, que calcula o preço final de um produto, calculado com base no preço do produto, no desconto (em porcentagem) e um frete (valor fixo). O desconto é aplicado sobre o preço do produto e o frete é somado ao final. Você deve definir as seguintes funções e chamá-las na sua função `preco_final`:

- `preco_com_desconto(preco_produto, desconto)`
- `preco_com_frete(preco, valor_frete)`

<textarea class="code lang-python">
def preco_final(preco_produto, desconto, valor_frete):
  return 0

def preco_com_desconto(preco_produto, desconto):
  return 0

def preco_com_frete(preco, valor_frete):
  return 0

### Testes
assert preco_com_desconto(200, 20) == 160
assert preco_com_desconto(200, 100) == 0
assert preco_com_desconto(200, 0) == 200

assert preco_com_frete(200, 10) == 210

assert preco_final(200, 10, 0) == 180
assert preco_final(200, 0, 5) == 205
assert preco_final(200, 10, 5) == 185

from unittest.mock import MagicMock
preco_com_desconto = MagicMock(return_value=1)
preco_com_frete = MagicMock(return_value=2)
assert preco_final(200, 50, 50) == 2
preco_com_desconto.assert_called()
preco_com_frete.assert_called()
</textarea>

<!-- 
def preco_final(preco_produto, desconto, valor_frete):
  p1 = preco_com_desconto(preco_produto, desconto)
  p2 = preco_com_frete(p1, valor_frete)
  return p2

def preco_com_desconto(preco_produto, desconto):
  return preco_produto * (100 - desconto) / 100

def preco_com_frete(preco, valor_frete):
  return preco + valor_frete
 -->

## Parâmetros default

Implemente a função `segundo_grau(x, a, b, c)`, que retorna o resultado da expressão `ax² + bx + c`. Considere que os parâmetros `b` e `c` são opcionais e, se não forem passados, são iguais a 0.

<textarea class="code lang-python">
def segundo_grau(x, a, b, c):
  return 0

### Testes
assert segundo_grau(2, 1, 1, 1) == 7
assert segundo_grau(3, 4, -2) == segundo_grau(3, 4, -2, 0)
assert segundo_grau(-2, 7) == segundo_grau(-2, 7, 0, 0)
assert segundo_grau(-2, 7, c=8) == segundo_grau(-2, 7, 0, 8)
</textarea>

<!-- 
def segundo_grau(x, a, b=0, c=0):
  return a * x ** 2 + b * x + c
-->
