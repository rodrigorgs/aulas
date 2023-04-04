---
layout: triple-page
title: Exercícios de introdução
features: [code,python]
---

## Olá!

Nesta página você pode resolver exercícios de programação sem sair do navegador. Se você está aqui porque os exercícios são parte da avaliação de uma disciplina, clique no botão `Login`, no canto superior direito da página, e preencha os seus dados de acesso. Somente assim suas respostas serão enviadas para o professor.

Você entendeu? Modifique o programa ao lado para que ele escreva **"Entendido!"**, e em seguida clique no botão "Rodar". A saída do programa deve aparecer na caixa "Saída" (canto inferior direito).

Ao rodar seu programa, também serão executados alguns testes para verificar se seu programa está correto. Se os seus testes passarem, clique no botão "Próximo" para avançar para a próxima questão.

<textarea class="code lang-python">
print("Não entendi!")
</textarea>

<div class="testcases">
]]]Entendido!
</div>

Clique no botão `Rodar` e, a seguir, no botão `Avançar`. Não altere nada no código ao lado!

## Alô mundo

Modifique o programa para que ele escreva `Alô, mundo!`

Passe o mouse <span class="tooltip">aqui
<span class="tooltiptext">Atenção com a pontuação!</span></span> se precisar de dica.


> Ao clicar no botão `Rodar`, você pode ver a saída do seu programa na caixa `Saída`. Além disso, serão executados alguns testes para verificar se seu programa está correto; os resultados dos testes aparecem abaixo da caixa `Saída`.

<textarea class="code lang-python">
print("Alô mundo")
</textarea>

<div class="testcases">
]]]Alô, mundo!
</div>

## Estudando programação

Corrija o programa ao lado para que ele imprima as duas linhas de texto a seguir:

```
Eu estudo
na UFBA
```

Passe o mouse <span class="tooltip">aqui
<span class="tooltiptext">Em Python, textos são sempre representados entre aspas.</span></span> se precisar de dica

<textarea class="code lang-python">
print(Eu estudo)
print(na UFBA)
</textarea>

<div class="testcases">
]]]Eu estudo\nna UFBA
</div>

## Idade

Escreva um programa que define uma variável chamada `idade`, com o valor `18`.

<textarea class="code lang-python">
</textarea>

<div class="testcode">
try:
  assert 'idade' in locals() or 'idade' in globals(), 'Você precisa definir uma variável chamada idade'
  assert idade == 18, 'A variável idade deve valer 18'
except AssertionError as e:
  print(e)
</div>

<div>
<span class="tooltip">Dica 1
<span class="tooltiptext">Escreva variavel = valor para definir uma variável com determinado valor (substitua "variável" e "valor" pelo que a questão pede)</span></span>
</div>
<div>
<span class="tooltip">Dica 2
<span class="tooltiptext">Em Python, números não são representados entre aspas.</span></span>
</div>
<div></div>

## O número pi

O programa ao lado deveria guardar na variável `pi` o valor de π (pi) com duas casas decimais. O que está errado? Corrija o programa.

<textarea class="code lang-python">
pi = 3,14
</textarea>

<div class="testcode">
try:
  assert 'pi' in locals() or 'pi' in globals(), 'Você precisa definir uma variável chamada pi'
  assert abs(pi - 3.14) < 0.00001, 'A variável pi não está com o valor correto'
except AssertionError as e:
  print(e)
</div>

## Arredonda

Complete o código ao lado, guardando na variável `arredondado` a parte inteira do valor de `por_pessoa`.

OBS.: Seu programa vai passar nos testes se você escrever `arredondado = 50`, mas o objetivo aqui é você tentar fazer o seu programa calcular a parte decimal a partir dos valores disponíveis.

<textarea class="code lang-python">
por_pessoa = 350 / 7
arredondado = ????????
</textarea>

<div class="testcode">
try:
  assert 'arredondado' in locals() or 'arredondado' in globals(), 'Você precisa definir uma variável chamada arredondado'
  assert arredondado == int(350 / 7), 'A variável arredondado não está com o valor correto'
except AssertionError as e:
  print(e)
</div>

## Centavos

Complete o código ao lado, guardando na variável `centavos` a parte decimal do valor de `por_pessoa`.

OBS.: Seu programa vai passar nos testes se você escrever `centavos = 0.42`, mas o objetivo aqui é você tentar fazer o seu programa calcular a parte decimal a partir dos valores disponíveis.

<textarea class="code lang-python">
por_pessoa = 256.42
centavos = ????????
</textarea>

<div class="testcode">
try:
  assert 'centavos' in locals() or 'centavos' in globals(), 'Você precisa definir uma variável chamada centavos'
  assert abs(centavos - 0.42) < 0.00001, 'A variável centavos não está com o valor correto'
except AssertionError as e:
  print(e)
</div>

## Papagaio (versão 1)

Corrija o programa para que ele leia um nome e imprima esse nome duas vezes, uma em cada linha.

> Para testar seu programa, você pode digitar um nome na caixa `Entrada`. Esse nome será lido pelo seu programa através do `input()`.

<span class="tooltip">Dica
<span class="tooltiptext">O programa é executado linha a linha, de cima para baixo. Garanta que você lê o nome ANTES de escrevê-lo.</span></span>

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

> Para testar seu programa, você pode digitar um nome na caixa `Entrada`.

<span class="tooltip">Dica<span class="tooltiptext">Muita atenção ao usar o input()</span></span>

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

<span class="tooltip">Dica<span class="tooltiptext">input sempre retorna uma string; para fazer cálculos, você deve converter o que foi digitado para um tipo inteiro, como int ou float.</span></span>

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
