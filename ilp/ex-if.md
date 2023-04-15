---
layout: triple-page
title: "Exercícios: if/else/elif"
features: [code, python]
---

## Senha

O programa ao lado contém um erro. Corrija o programa para que ele aceite apenas a senha `12345`.

<textarea class="code lang-python">
senha = input()
if senha == '12345'
  print("Senha correta")
print("Fim")
</textarea>

<textarea class="stdin">senha123</textarea>

<div class="testcases">
12345]]]Senha correta\nFim=====
qwerty]]]Fim=====
</div>

## Desconto

O programa ao lado contém um erro. Dada uma quantidade e um preço unitário, o programa deveria imprimir o valor final da compra, concedendo 10% de desconto na compra de 20 ou mais unidades. Corrija o programa.

<textarea class="code lang-python">
qtd = int(input())
preco_unitario = float(input())
desconto = 0

if qtd >= 20:
desconto = 0.1

valor = preco_unitario * qtd * (1 - desconto)
print(f"{valor:.2f}")
</textarea>

<textarea class="stdin">10
15.0</textarea>

<div class="testcases">
10\n15.0]]]150.00=====
20\n0.50]]]9.00=====
</div>

## Adivinhe o número

O programa ao lado está errado. Corrija-o para imprimir `Correto` somente quando o número digitado for `42`.

<textarea class="code lang-python">
numero = int(input())

if numero = 42:
  print("Correto")
</textarea>

<textarea class="stdin">44</textarea>

<div class="testcases">
41]]]=====
42]]]Correto=====
43]]]=====
</div>

## Apenas para adultos

Determinada atividade é permitida apenas para adultos menores de 70 anos. Modifique o programa para escrever "permitido" ou "proibido", a depender da idade digitada. Ao final, o programa deve escrever "fim".

<textarea class="code lang-python">
idade = int(input())

print("corrija o programa")
</textarea>

<textarea class="stdin">15</textarea>

<div class="testcases">
15]]]proibido\nfim=====
18]]]permitido\nfim=====
69]]]permitido\nfim=====
70]]]proibido\nfim=====
71]]]proibido\nfim=====
</div>

## Faixa etária

Crie um programa que classifica uma pessoa em uma das seguintes categorias, de acordo com a idade: "bebê", "criança", "adolescente", "adulta". Considere o seguinte:

- bebê: 0 a 1 ano
- criança: 2 a 11 anos
- adolescente: 12 a 17 anos
- adulta: 18 anos ou mais

<textarea class="code lang-python">
idade = int(input())

if idade <= 1:
  print("bebê")
elif idade <= 11:
  print("criança")
</textarea>

<textarea class="stdin">1</textarea>

<div class="testcases">
0]]]bebê=====
1]]]bebê=====
2]]]criança=====
11]]]criança=====
12]]]adolescente=====
17]]]adolescente=====
18]]]adulta=====
81]]]adulta=====
</div>
