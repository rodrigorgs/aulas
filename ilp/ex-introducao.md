---
layout: triple-page
title: Exercícios de introdução
features: [code,python]
---

## Alô mundo

Modifique o programa para que ele escreva `Alô, mundo!`

> Ao clicar no botão `Rodar`, você pode ver a saída do seu programa na caixa `Saída`. Além disso, serão executados alguns testes para verificar se seu programa está correto; o resultados dos testes aparece abaixo da caixa `Saída`.

<textarea class="code lang-python">
print("Alô mundo")
</textarea>

<div class="testcases">
]]]Alô, mundo!
</div>

## Papagaio (versão 1)

Corrija o programa para que ele leia um nome e imprima esse nome duas vezes, uma em cada linha.

> Para testar seu programa, você pode digitar uma entrada na caixa `Entrada`.

<textarea class="code lang-python">
print(nome)
print(nome)
nome = input()
</textarea>

<textarea class="stdin">Fulano</textarea>
<div class="testcases">
abc]]]abc\nabc=====
qwerty]]]qwerty\nqwerty
</div>

## Papagaio (versão 2)

Corrija o programa para que ele leia um nome e imprima esse nome duas vezes, uma em cada linha.

> Para testar seu programa, você pode digitar uma entrada na caixa `Entrada`.

<textarea class="code lang-python">
nome = input
print(nome)
print(nome)
</textarea>

<textarea class="stdin">Fulano</textarea>
<div class="testcases">
abc]]]abc\nabc=====
qwerty]]]qwerty\nqwerty
</div>


## Dobro

Corrija o programa para que ele leia um número inteiro e imprima o dobro desse número.

<textarea class="code lang-python">
numero = input()
print(numero * 2)
</textarea>

<textarea class="stdin">2</textarea>
<div class="testcases">
0]]]0=====
-3]]]-6=====
1]]]2=====
2]]]4=====
123]]]246=====
</div>

## IMC

Complete o programa para que ele imprima o índice de massa corporal (IMC) de uma pessoa, com duas casas decimais. O IMC é calculado como a razão entre o peso e o quadrado da altura.

<textarea class="code lang-python">
peso = float(input())
altura = float(input())
# troque o valor 3.1415 pelo cálculo do IMC
imc = 3.1415 
print(f'{imc:.2f}')
</textarea>

<div class="testcases">
80\n1.80]]]24.69=====
77\n1.60]]]30.08
</div>

## Conta maluca

Corrija o programa. Ele deve ler dois números inteiros e imprimir o triplo da soma dos números.

<textarea class="code lang-python">
a = int(input())
b = int(input())
print(a + b * 3)
</textarea>

<textarea class="stdin">0
5</textarea>
<div class="testcases">
0\n5]]]15=====
1\n2]]]9=====
3\n3]]]18
</div>

## Endereço

Corrija o programa. Ele deve ler os componentes de um endereço, `rua`, `número`, `complemento` e `cep`, um em cada linha, e imprimir o endereço no seguinte formato:

> Rua `rua`, n. `número`, `complemento` - `cep`

Exemplo:

> Rua Milton Santos, n. 2000, sala 101 - 40170-110

<textarea class="code lang-python">
rua = input()
numero = input()
complemento = input()
cep = input()
print(rua, numero, complemento, cep)
</textarea>

<textarea class="stdin">Milton Santos
2000
sala 101
40170-110</textarea>

<div class="testcases">
a\nb\nc\nd]]]Rua a, n. b, c - d=====
qwe\n222\nsala 3\n41000-000]]]Rua qwe, n. 222, sala 3 - 41000-000=====
</div>

## Produto de 2

Corrija o programa. Ele deve ler dois números inteiros separados por espaço e imprimir o seu produto.

<textarea class="code lang-python">
a, b = input()
print(a * b)
</textarea>

<textarea class="stdin">3 4</textarea>
<div class="testcases">
3 4]]]12=====
-2 5]]]-10=====
823 0]]]0=====
-827 294]]]-243138=====
</div>
