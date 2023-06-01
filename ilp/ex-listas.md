---
layout: triple-page
title: "Exercícios: listas"
features: [code, python]
---

## Lista de números

Escreva um programa que cria uma lista com os números inteiros de 1 a 4, em ordem crescente, e armazena a lista em uma variável chamada `opcoes`.

<textarea class="code lang-python">
opcoes = ............
</textarea>

<div class="runtemplate">
[[[code]]]
print('opcoes:')
print(opcoes)
</div>

<div class="testcode">
try:
  assert opcoes == [1, 2, 3, 4]
except AssertionError as e:
  print('[ERRO]', e)
</div>

## Segundo

Complete o programa a seguir de forma que ele imprima o segundo elemento da lista `palavras`.

<textarea class="code lang-python">
palavras = input().split()
print('substitua esta linha')

</textarea>

<textarea class="stdin">a b c d e</textarea>

<div class="testcases">
a b c d e]]]b=====
x y]]]y=====
Z X R]]]X=====
</div>

## Lista de zeros

Complete o programa a seguir. Ele deve ler um número inteiro, `N`, e imprimir uma lista de tamanho `N`, contendo exatamente `N` zeros.

Exemplo:

- Entrada: `4`
- Saída esperada: `[0, 0, 0, 0]`

<textarea class="code lang-python">
N = int(input())
lista = [0, 0, 0]
print(lista)
</textarea>

<textarea class="stdin">4</textarea>

<div class="testcases">
4]]][0, 0, 0, 0]=====
1]]][0]=====
3]]][0, 0, 0]=====
0]]][]=====
</div>

## Lista aumentada

Considere o seguinte programa:

```python
palavras = ["Obrigado", "por", "tudo"]
# Escreva uma linha de código abaixo
# para completar o programa...
```

Que linha de código você deve escrever ao final do programa para inserir a palavra "fim" no final da lista?

<textarea class="code lang-python">
# escreva aqui
</textarea>

<textarea class="stdin">Obrigado por tudo</textarea>

<div class="runtemplate">
palavras = ["Obrigado", "por", "tudo"]
[[[code]]]
print('palavras:')
print(palavras)
</div>

<div class="testcode">
palavras = ["Obrigado", "por", "tudo"]
[[[code]]]
assert palavras == ["Obrigado", "por", "tudo", "fim"], 'erro'
palavras = []
[[[code]]]
assert palavras == ["fim"], 'erro'
palavras = ['a', 'b', 'c']
[[[code]]]
assert palavras == ['a', 'b', 'c', 'fim'], 'erro'
</div>

## Filtro par

Complete o programa ao lado de forma que ele imprima uma lista formada apenas pelos números pares da lista `numeros`.

Exemplo:

- **Entrada**: `1 2 3 4 6`
- **Saída esperada**: `[2, 4, 6]`

<textarea class="code lang-python">
numeros = [int(x) for x in input().split()]
pares = []
print(pares)
</textarea>

<textarea class="stdin">1 2 3 4 6</textarea>

<div class="testcases">
1 2 3 4 6]]][2, 4, 6]=====
1 3 5]]][]=====
2 4 6]]][2, 4, 6]=====
</div>


