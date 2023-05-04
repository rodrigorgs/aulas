---
layout: triple-page
title: "Exercícios: for/while"
features: [code, python]
---

## Repetindo N vezes

O programa ao lado imprime "Oi" 3 vezes. Modifique-o para que imprima "Oi" `n` vezes, onde `n` é um número inteiro lido do teclado.

<textarea class="code lang-python">
n = int(input())

for i in range(3):
  print("Oi")
</textarea>

<textarea class="stdin">4</textarea>

<div class="testcases">
3]]]Oi\nOi\nOi=====
5]]]Oi\nOi\nOi\nOi\nOi=====
</div>

## Valor total de cada item

O programa ao lado 1) lê um número `qtd` e depois 2) lê um par de números inteiros representando a quantidade e o preço unitário de um item e 3) imprime o valor dos itens. Modifique o programa para que ele repita os passos (2) e (3) `qtd` vezes; ou seja, o programa deve calcular o valor final de `qtd` itens, descritos na entrada pela sua quantidade e preço unitário .

<textarea class="code lang-python">
qtd = int(input())

unidades, preco = map(int, input().split())
print(unidades * preco)
</textarea>

<textarea class="stdin">1
2 3</textarea>

<div class="testcases">
1\n2 3]]]6=====
2\n3 5\n4 3]]]15\n12\n=====
3\n2 10\n3 10\n10 5]]]20\n30\n50\n=====
</div>

## Contando até n

O programa ao lado imprime os números de 0 a 9. Modifique-o de forma que ele imprima os números de 0 a `n` - 1, onde `n` é um número inteiro lido do teclado.

<textarea class="code lang-python">
for numero in range(10):
  print(numero)
</textarea>

<textarea class="stdin">6</textarea>

<div class="testcases">
10]]]0\n1\n2\n3\n4\n5\n6\n7\n8\n9=====
5]]]0\n1\n2\n3\n4=====
</div>

## Contando ao contrário, de dois em dois

Crie um programa que lê um número inteiro `n` e imprime os números de `n` até 0, de dois em dois (um número em cada linha).

<textarea class="code lang-python">
n = int(input())
</textarea>

<textarea class="stdin">4</textarea>

<div class="testcases">
6]]]6\n4\n2\n0=====
5]]]5\n3\n1=====
</div>

## Enquanto houver ingredientes

Um bolo leva 3 ovos, 2 xícaras de farinha, 1 xícara de leite e 1 colher de fermento. Escreva um programa que lê a quantidade de ovos, farinha, leite e fermento disponíveis e imprime "bolo" enquanto houver ingredientes suficientes para fazer um bolo.

Atenção: cuidado para não criar um loop infinito! Se isso acontecer, seu navegador poderá travar.

<textarea class="code lang-python">
ovos = int(input())
farinha = int(input())
leite = int(input())
fermento = int(input())

print("bolo")
print("bolo")
print("bolo")
</textarea>

<textarea class="stdin">3
2
1
1</textarea>

<div class="testcases">
3\n2\n1\n1]]]bolo=====
7\n20\n10\n10]]]bolo\nbolo=====
</div>

## Contador de alunos

Crie um programa que lê os números de matrícula dos alunos de uma turma, um número por linha, e imprime o número de alunos lidos. O número 0 indica fim da entrada, e não representa um aluno.

<textarea class="code lang-python">
matricula = int(input())
qtd = 0

# ...

print(qtd)
</textarea>

<textarea class="stdin">111
222
333
0</textarea>

<div class="testcases">
123\n456\n789\n0]]]3=====
123\n456\n789\n111\n222\n0]]]5=====
0]]]0=====
</div>

## Quebra de linha

Crie um programa que lê uma linha de texto e imprime cada palavra em uma linha.

<textarea class="code lang-python">

</textarea>

<textarea class="stdin">O rato roeu a roupa do rei de Roma</textarea>

<div class="testcases">
um dois tres]]]um\ndois\ntres=====
a b c d e]]]a\nb\nc\nd\ne=====
xyz]]]xyz=====
</div>

## Menor

Crie um programa que lê uma sequência de números inteiros positivos, um número por linha, e imprime o menor deles. A sequência termina quando o número 0 é lido. A sequência possuirá pelo menos um número.

Atenção: cuidado para não criar um loop infinito! Se isso acontecer, seu navegador poderá travar.

<textarea class="code lang-python">
n = int(input()
menor = n

# ...

print(n)
</textarea>

<textarea class="stdin">1
2
3
0</textarea>

<div class="testcases">
3\n5\n9\n0]]]3=====
5\n4\n3\n2\n1\n0]]]1=====
6\n2\n8\n0]]]2=====
</div>

## Combinações

Crie um programa que lê dois números inteiros `n` e `k`, separados por espaço, e imprime todos os pares de números inteiros `i` e `j` tais que `1 <= i <= n`, `1 <= j <= k`, em ordem crescente, variando primeiro `j`, e depois `i`. Cada par deve ser impresso em uma linha, com os números separados por espaço. Exemplo:

Entrada:

```
2 3
```

Saída:

```
1 1
1 2
1 3
2 1
2 2
2 3
```

<textarea class="code lang-python">
n, k = map(int, input().split())

print(1, 1)
</textarea>

<textarea class="stdin">2 3</textarea>

<div class="testcases">
2 3]]]1 1\n1 2\n1 3\n2 1\n2 2\n2 3=====
3 2]]]1 1\n1 2\n2 1\n2 2\n3 1\n3 2=====
4 1]]]1 1\n2 1\n3 1\n4 1=====
1 4]]]1 1\n1 2\n1 3\n1 4=====
</div>
