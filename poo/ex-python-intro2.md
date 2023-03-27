---
layout: triple-page
title: Exercícios em Python, com funções
features: [code, python]
---

## Vamos começar!

Nesta página você pode resolver exercícios de programação sem sair do navegador. Se você está aqui porque os exercícios são parte da avaliação de uma disciplina, clique no botão "Login", no canto superior direito da página, e preencha os seus dados de acesso. Somente assim suas respostas serão enviadas para o professor.

Você entendeu? Modifique o programa ao lado para que ele escreva "Sim", e em seguida clique no botão "Rodar". A saída do programa deve aparecer na caixa "Saída" (canto inferior direito).

Se os seus testes passarem, clique no botão "Próximo" para avançar para a próxima questão.

<textarea class="code lang-python">
print("Não")
</textarea>

<div class="testcases">
]]]Sim
</div>

## Olá!

O programa ao lado deveria ler o nome do usuário e então o cumprimentar, mas está com um erro.

Para testar, digite o seu nome na caixa "Entrada" (canto superior direito) e então clique no botão "Rodar". Quando o programa é executado, o `input()` lê a primeira linha que você digitou na caixa "Entrada", e o `print()` escreve na caixa "Saída".

Corrija o programa, clique no botão "Rodar" e avance para o próximo problema quando estiver tudo certo.

<textarea class="code lang-python">
nome = input()
print("Olá, " + Nome)
</textarea>

<div class="testcases">
Mundo]]]Olá, Mundo=====
Fulana]]]Olá, Fulana=====
Sicrano]]]Olá, Sicrano=====
</div>

## Funções

Nos exercícios anteriores, você usou `input()` e `print()` para lidar com entrada e saída de dados. Nos próximos exercícios, você vai criar **funções** segundo alguma especificação.

Os valores de **entrada** do seu algoritmo **não** serão digitados pelo usuário; em vez disso, eles serão fornecidos como parâmetros na chamada da função.

A **saída** do seu algoritmo **não** será impressa na tela; em vez disso, ela será retornada para o código que chama a sua função.

### Fatorial

O programa ao lado deveria definir uma função que...

- recebe como parâmetro um número inteiro positivo, `n`, e
- retorna o fatorial de `n`

O programa em si não faz nada; ao clicar em `Rodar`, no entanto, o ambiente executará alguns testes, chamando sua função diversas vezes, cada vez com um valor diferente de `n`.

Você pode criar os seus próprios testes de duas formas diferentes:

- adicionando instruções `print` *fora* da função
- adicionando instruções `assert` *fora* da função

Veja exemplos e explicação no código.

A propósito, o programa está errado. Você consegue corrigi-lo?

<textarea class="code lang-python">
def fatorial(n):
  resultado = 1
  i = 1
  while i < n:
    resultado *= i
    i += 1
  return resultado

# Se quiser testar sua função, descomente as linhas abaixo
print(fatorial(0))
print(fatorial(1))
print(fatorial(2))

# Melhor ainda é usar a instrução "assert CONDICAO",
# que resulta em erro quando a CONDICAO é falsa.
# Experimente adicionar outros asserts
assert fatorial(0) == 1
assert fatorial(1) == 1

</textarea>

<div class="testcode">
try:
  assert fatorial(0) == 1, 'fatorial(1) deve retornar 1'
  assert fatorial(1) == 1, 'fatorial(1) deve retornar 1'
  assert fatorial(2) == 2, 'fatorial(2) deve retornar 2, pois 1 * 2 == 2'
  assert fatorial(3) == 6, 'fatorial(3) deve retornar 6, pois 1 * 2 * 3 == 6'
  assert fatorial(4) == 24, 'fatorial(3) deve retornar 6, pois 1 * 2 * 3 * 4 == 24'
  assert fatorial(5) == 120, 'fatorial(3) deve retornar 6, pois 1 * 2 * 3 * 4 * 5 == 120'
  assert fatorial(6) == 720, 'fatorial(3) deve retornar 6, pois 1 * 2 * 3 * 4 * 5 * 6 == 720'
except AssertionError as e:
  print(e)
</div>

## Retângulo

Crie uma função que recebe como medidas a base e altura de um retângulo e retorna a sua área.

<textarea class="code lang-python">
def calcula_area(base, altura):
  return 0
</textarea>
<div class="testcode">
assert calcula_area(0, 0) == 0
assert calcula_area(3, 4) == 12
</div>

## Imposto

Crie uma função que classifique uma pessoa em uma das seguintes categorias, de acordo com a idade: "bebê", "criança", "adolescente", "adulta". Considere o seguinte:

- bebê: 0 a 1 ano
- criança: 2 a 11 anos
- adolescente: 12 a 17 anos
- adulta: 18 anos ou mais

<textarea class="code lang-python">
def faixa_etaria(idade):
  return "bebê"
</textarea>
<div class="testcode">
assert faixa_etaria(0) == "bebê"
assert faixa_etaria(1) == "bebê"
assert faixa_etaria(2) == "criança"
assert faixa_etaria(11) == "criança"
assert faixa_etaria(12) == "adolescente"
assert faixa_etaria(17) == "adolescente"
assert faixa_etaria(18) == "adulta"
assert faixa_etaria(81) == "adulta"
</div>

## Linha de caracteres

Crie uma função que recebe um caractere e um número inteiro, `N`, e retorna uma string consistindo do caractere repetido `N` vezes.

<textarea class="code lang-python">
def linha(c, n):
  s = "****"
  return s
</textarea>
<div class="testcode">
assert linha("*", 5) == "*****"
assert linha("#", 2) == "##"
assert linha("@", 0) == ""
</div>

## Retângulo desenhado

Crie uma função que recebe um caractere e dois inteiros, base e altura, e retorna uma string representando um retângulo com as dimensões fornecidas. Use a função `linha` desenvolvida anteriormente (você precisará copiar a função aqui).

Exemplo: para a chamada `retangulo('#', 4, 3)`, a função deve retornar a seguinte string:

```
####
####
####
```

<textarea class="code lang-python">
def retangulo(c, base, altura):
  s = "****"
  s += "****"
  return s
</textarea>
<div class="testcode">
assert retangulo("*", 4, 2).strip() == "****\n****"
assert retangulo("#", 5, 1).strip() == "#####"
</div>

## Lista sequencial

Crie uma função que recebe um número inteiro, `n` e retorna uma lista com todos os números inteiros de 1 a `n`, em ordem crescente. Se `n` for zero ou negativo, deve ser retornada uma lista vazia.

<textarea class="code lang-python">
def sequencia(n):
  return []
</textarea>
<div class="testcode">
assert sequencia(3) == [1, 2, 3]
assert sequencia(1) == [1]
assert sequencia(-1) == []
</div>

## Produtório

Crie uma função que recebe uma lista de números e retorna o seu produto ou 1 em caso de lista vazia.

<textarea class="code lang-python">
def produtorio(lista):
  resultado = 1
  return resultado
</textarea>
<div class="testcode">
assert produtorio([]) == 1
assert produtorio([1, 2, 3]) == 6
assert produtorio([1, 0, 3]) == 0
</div>

## Insere duas vezes

Crie uma função `insere2`, que recebe uma lista, `l`, e um valor, `v`, e insere o valor duas vezes no final da lista `l`. Sua função não deve retornar nada.

<textarea class="code lang-python">
def insere2(l, v):
  pass
</textarea>

<div class="testcode">
lista = [4, 2, 6]
ret = insere2(lista, 3)
assert ret is None
assert lista == [4, 2, 6, 3, 3]
#
lista = []
ret = insere2(lista, -8)
assert ret is None
assert lista == [-8, -8]
</div>

## 