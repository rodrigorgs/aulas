---
layout: triple-page
title: "Exercícios: funções em Python"
features: [code, python]
---

## Valor total

O programa ao lado calcula o valor total de uma compra. Transforme esse programa em uma função, chamada `calcula_total`, que recebe os dados de entrada como parâmetros e retorna o valor total. Sua função não deve conter instruções como `print` e `input`, mas você pode manter essas instruções *fora* da função se quiser testá-la.

<textarea class="code lang-python">
qtd = int(input())
valor_unitario = float(input())
desconto = float(input()) # Entre 0.0 e 1.0
print((qtd * valor_unitario) * (1 - desconto))
</textarea>

<textarea class="stdin">10
100
0.4
</textarea>

<div class="testcode">
try:
  assert abs(calcula_total(10, 100, 0.4) - 600) < 0.01, 'calcula_total(10, 100, 0.4) deve retornar 600.0'
  assert abs(calcula_total(3, 4, 0.0) - 12) < 0.01, 'calcula_total(3, 4, 0.0) deve retornar 12.0'
  assert abs(calcula_total(9, 10.50, 1.0) - 0) < 0.01, 'calcula_total(9, 10.50, 1.0) deve retornar 0.0'
except AssertionError as e:
  print('[ERRO] ', e)
</div>

<!-- {% comment %}
def calcula_total(qtd, valor_unitario, desconto):
  return (qtd * valor_unitario) * (1 - desconto)
{% endcomment %}
-->

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
  print('[ERRO] ', e)
</div>

<!-- {% comment %}
def distancia(x1, y1, x2, y2):
  '''Calcula a distância entre os pontos (x1, y1) e (x2, y2)'''
  dx = x2 - x1
  dy = y2 - y1
  return math.sqrt(dx ** 2 + dy ** 2)
{% endcomment %} -->

## Parâmetros default

Implemente a função `segundo_grau(x, a, b, c)`, que retorna o resultado da expressão `ax² + bx + c`. Considere que os parâmetros `b` e `c` são opcionais e, se não forem passados, são iguais a 0.

<textarea class="code lang-python">
def segundo_grau(x, a, b, c):
  return 0
</textarea>

<textarea class="stdin">
# code
# x² + bx + 1, para x = 2
print(segundo_grau(2, 1, 1, 1))
</textarea>

<div class="testcode">
try:
  assert segundo_grau(2, 1, 1, 1) == 7, 'Erro'
  assert segundo_grau(3, 4, -2) == segundo_grau(3, 4, -2, 0), 'Erro'
  assert segundo_grau(-2, 7) == segundo_grau(-2, 7, 0, 0), 'Erro'
  assert segundo_grau(-2, 7, c=8) == segundo_grau(-2, 7, 0, 8), 'Erro'
except AssertionError as e:
    print('[ERRO] ', e)
</div>

<!-- {% comment %} 
def segundo_grau(x, a, b=0, c=0):
  return a * x ** 2 + b * x + c
{% endcomment %} -->

## Saudação

No programa ao lado há um função `saudacao`. Em vez de dizer o que ela deve fazer, adicionamos alguns testes no final do programa, que mostram como a função deve funcionar.

Corrija a função `saudacao` de forma que ela passe nos testes (`asserts`).

<textarea class="code lang-python">
def saudacao():
  return f"Oi, pessoal!"

assert saudacao('pessoal', 'Oi') == 'Oi, pessoal!'
assert saudacao('Mundo') == 'Alô, Mundo!'
assert saudacao(saudacao='Olá', nome='galera') == 'Olá, galera!'
assert saudacao(nome='galera') == 'Alô, galera!'
</textarea>

<textarea class="stdin">
# code
print(saudacao('mundo', 'Alô'))
</textarea>

<div class="testcode">
try:
  assert saudacao('turma', 'Eita') == 'Eita, turma!', 'Erro ao chamar a função com dois parâmetros posicionais'
  assert saudacao('planeta') == 'Alô, planeta!', 'Erro ao chamar a função com um parâmetro posicional'
  assert saudacao(saudacao='Oba', nome='pessoal') == 'Oba, pessoal!', 'Erro ao chamar a função com dois parâmetros nomeados'
  assert saudacao(nome='você') == 'Alô, você!', 'Erro ao chamar a função com um parâmetro nomeado'
except AssertionError as e:
  print('[ERRO] ', e)
</div>

## Maiúsculas

Crie uma função, maiusculizada, que recebe uma lista de strings e retorna uma lista com as strings convertidas para maiúsculas (use `s.upper()` para converter uma string `s` para maiúsculas).

<textarea class="code lang-python">
def maiusculizada(lista):
  pass
</textarea>

<textarea class="stdin">
# code
print(maiusculizada(['a', 'b', 'c']))
</textarea>

<div class="testcode">
try:
  assert maiusculizada([]) == [], 'Erro com lista vazia'
  assert maiusculizada(['d']) == ['D'], 'Erro com lista de um elemento'
  assert maiusculizada(['d', 'Aba', 'CaRRO']) == ['D', 'ABA', 'CARRO'], 'Erro com lista de 3 elementos'
  l = ['qwe', 'asd', 'zxc']
  maiusculizada(l)
  assert l == ['qwe', 'asd', 'zxc'], 'Não modifique a lista passada como parâmetro!'
except AssertionError as e:
  print('[ERRO] ', e)
</div>

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

<textarea class="stdin">
# code
print(maior([2, 7, 5])) # 7
print(media_justa([2, 9, 4])) # 3
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
  assert media_justa([5, 10]) == 10, 'Erro em media_justa()'
  assert maior.called, 'O método media_justa deve chamar o método maior'
except AssertionError as e:
  print('Erro:', e)
</div>

<!-- {% comment %} 
def maior(lista):
  if len(lista) == 0:
    return 0
  return max(lista)

def media_justa(lista):
  if len(lista) <= 1:
    return 0
  return (sum(lista) - maior(lista)) / (len(lista) - 1)
{% endcomment %} -->

