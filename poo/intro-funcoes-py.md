---
layout: page
title: Funções em Python
features: [code, python]
---

## Um programa simples!

Com o objetivo de resolver um problema, um **algoritmo** recebe um conjunto de **entradas** e produz uma **saída**.

O programa abaixo implementa um algoritmo para calcular a média de um conjunto de notas:

```python
notas = input("Digite as notas (separadas por espaços): ").split()
notas = [float(x) for x in notas]

media = 0.0
for nota in notas:
	media += nota
media /= len(notas)

print("A média geral é", media)
```

Neste programa, temos:

- **entradas**: as notas (digitadas pelo usuário)
- **saída**: a média das notas (exibida na tela)

<div class="uml">
@startdot
digraph G {
  rankdir=LR;
  notas [shape=none]
  media [shape=none]
  programa [shape=rectangle]

  notas -> programa
  programa -> media

}
@enddot
</div>

Neste programa, as entradas são digitadas pelo usuário e a saída é escrita na tela pelo programa.

## Funções

Em programação, **função** é um bloco de código <span class="tooltip">com um nome<span class="tooltiptext">Existem funções sem nome (anônimas), mas isso é assunto para outro momento</span></span>, que pode receber entradas (chamadas de **parâmetros** da função) e produzir uma saída (chamada de **retorno** da função).

Python possui muitas funções prontas para serem usadas. Por exemplo, a função `len` pode receber uma string e produzir como resultado o número de caracteres:

```python
s = "Alo"
tamanho = len(s)
print(tamanho)
```

## Definição de funções

Você pode definir suas próprias funções usando a palavra-chave `def`, usando o seguinte padrão:

```python
def NOME_DA_FUNCAO(NOME_DO_PARAMETRO1, NOME_DO_PARAMETRO2):
  INSTRUCOES
```

Uma função pode ter 0, 1 ou mais parâmetros, cujos nomes aparecem separados por vírgulas.

No exemplo abaixo, criamos uma função chamada `calcula_media` que recebe um parâmetro (`notas`) e retorna a média das notas:

<textarea class="code lang-python">
def calcula_media(notas):
  media = 0.0
  for nota in notas:
    media += nota
  media /= len(notas)
  return media
</textarea>

A instrução `return` finaliza a execução da função e indica o valor retornado pela função, isto é, o resultado ou a saída da função.

Se você executar o código acima, nada vai acontecer. O código apenas **define** uma função. Para executar a função, é preciso escrever um programa que **chame** a função, fornecendo os valores dos parâmetros.

<div class="uml">
@startdot
digraph G {
  rankdir=LR;
  notas [shape=none]
  media [shape=none]
  "função calcula_media" [shape=rectangle]

  notas -> "função calcula_media"
  "função calcula_media" -> media
}
@enddot
</div>

<!-- Um programa pode definir várias funções. Nesse sentido, funções se parecem muito com programas, e é por isso que também podem ser chamadas de **subprogramas**. -->

## Programas vs. funções

Funções se parecem muito com programas, e é por isso que também podem ser chamadas de **subprogramas**. A diferença fundamental se dá na forma como as entradas e saídas são fornecidas.

Em um programa, é comum que entradas sejam fornecidas pelo usuário através do teclado (ou através de um arquivo, ou a partir da rede...). 

Já em uma função, as entradas são fornecidas pelo programa que usa a função. Assim, se quisermos usar a função `calcula_media`, precisamos criar um programa que **chama** a função com alguma lista de notas. Exemplos:

```python
x = calcula_media([8, 9, 10])
print(x)

notas1 = [5, 7]
notas2 = [10, 9]
y = calcula_media(notas1 + notas2)
print(y)
```

## Outros exemplos de função

Função que recebe dois números e retorna um número:

```python
def area_retangulo(base, altura):
  return a * b
```

Função que não recebe parâmetro, mas retorna um valor:

<textarea class="code lang-python">
from math import sqrt

def calcula_pi():
  root = 2 * (2 / sqrt(2))
  denominator = sqrt(2)
  pi = root
  while 2 / sqrt(2 + denominator) > 1:
      pi = pi * 2 / sqrt(2 + denominator)
      denominator = sqrt(2 + denominator)
  return pi

print(calcula_pi())
</textarea>

Na matemática, toda função produz um valor; na programação, pode-se criar <span class="tooltip">funções que não retornam nada<span class="tooltiptext">Também chamadas de <b>procedimentos</b></span></span>:

```python
def cumprimenta(nome):
  print("Oi,", nome)
  print("Tudo bem com você?")
```

## Funções ajudam a organizar o programa

Ao criar a função `calcula_media`, podemos reescrever nosso programa original de forma mais organizada:

```python
# Algoritmo de cálculo de média
def calcula_media(notas):
  media = 0.0
  for nota in notas:
    media += nota
  media /= len(notas)
  return media

# Entrada/saída
notas = input("Digite as notas (separadas por espaços): ").split()
notas = [float(x) for x in notas]
media = calcula_media(notas)
print("A média geral é", media)
```

Desta forma, o programa lida apenas com tratamento de entradas e saídas, enquanto a função fica responsável por implementar a lógica do cálculo da média.

## Funções podem chamar outras funções

Vamos criar uma função para determinar a situação de um aluno em uma disciplina: `AP` para aprovado e `RE` para reprovado. Consideramos que um aluno está aprovado se a média de suas notas é maior ou igual à média mínima. Poderíamos definir a função desse jeito:

```python
def determina_situacao(notas, media_minima):
  media = 0.0
  for nota in notas:
    media += nota
  media /= len(notas)
  
  if media >= media_minima:
    return "AP"
  else:
    return "RE"
```

As linhas 2--5 são idênticas ao código da função `calcular_media`. Isso é o que chamamos de **[código duplicado](duplicacao-de-codigo)** (o famoso copy &amp; paste). Obviamente, se já temos uma função para calcular a média, não precisamos reinventar a roda. Assim, podemos reescrever a função `determina_situacao` de forma muito mais simples:

```python
def determina_situacao(notas, media_minima):
  media = calcula_media(notas)
  
  if media >= media_minima:
    return "AP"
  else:
    return "RE"
```

> Além de ajudar a **organizar** o programa, funções proporcionam o **reúso**, diminuindo assim a **duplicação de código**.

## Funções tagarelas

É um erro comum de iniciante definir funções que chamam `input()` e `print()` (vamos chamá-las aqui de **funções tagarelas**). Embora isso seja adequado em alguns casos, lembre-se de que funções possuem seus próprios mecanismos para obter e produzir dados: parâmetros e retorno.

É uma boa prática escrever funções que realizam uma **única tarefa**. Funções tagarelas fazem duas coisas: interagem com o usuário e implementam um algoritmo. Isso diminui as possibilidades de **reúso** da função, ou seja, faz com que essas funções sejam úteis para alguns programas, mas inúteis para outros -- por exemplo, um programa que obtém os dados de um arquivo, e não do usuário.

Considere o exemplo a seguir. A função `calcula_media` é tagarela. A função `determina_situacao` recebe notas como parâmetro e as usa para calcular a situação do aluno; para isso, ela depende do cálculo da média. Mas ela não pode chamar `calcula_media` para isso, pois `calcula_media` obtém as notas do usuário. Veja o que acontece se tentarmos:

<textarea class="code lang-python">
def calcula_media(notas):
  notas = input("Digite as notas (separadas por espaços): ").split()
  notas = [float(x) for x in notas]

  media = 0.0
  for nota in notas:
    media += nota
  media /= len(notas)

  print("A média geral é", media)
  return media

def determina_situacao(notas, media_minima):
  media = calcula_media(notas)
  
  if media >= media_minima:
    return "AP"
  else:
    return "RE"

# Programa principal
# Aqui as notas estão fixas, mas elas poderiam ter vindo de um arquivo
notas_finais = [8.0, 9.0, 10.0]
situacao = determina_situacao(notas_finais, 5.0)
print("A situação é", situacao)
</textarea>

## Exercícios

- Crie uma função `imc(peso, altura)`, que calcula o índice de massa corporal de uma pessoa
- Crie uma função uma função `maior(lista)`, que retorna o maior elemento de uma lista de números e uma função `media_justa(lista)`, que retorna a média dos números da lista desconsiderando o seu maior elemento.
- Escreva uma função `desenha_retangulo(largura, altura)`, que imprime um retângulo contendo apenas caracteres `#`. Por exemplo, a chamada `desenha_retangulo(5, 3)` deve imprimir o seguinte:

```
#####
#####
#####
```

- Escreva um programa para calcular o valor final de uma compra. Ele deve pedir ao usuário o preço do produto, o desconto (em porcentagem) e o frete (valor fixo). O desconto é aplicado sobre o preço do produto e o frete é somado ao final. Depois de implementar o programa, reorganize o código criando as seguintes funções:
  - `preco_com_desconto(preco_produto, desconto)`
  - `preco_com_frete(preco, valor_frete)`
  - `preco_final(preco_produto, desconto, valor_frete)`

## Revisão

Consulte [este glossário](https://mange.ifrn.edu.br/python/aprenda-com-py3/capitulo_03.html#glossario).