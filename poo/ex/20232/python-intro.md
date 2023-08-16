---
layout: triple-page
title: Exercícios em Python
features: [code, python]
---

## Olá!

Nesta página você pode resolver exercícios de programação sem sair do navegador. Se você está aqui porque os exercícios são parte da avaliação de uma disciplina, clique no botão **Login**, no canto superior direito da página, e preencha os seus dados de acesso. Somente assim suas respostas serão enviadas para o professor.

Nestes exercícios você vai criar **funções** segundo alguma especificação. Os valores de entrada do seu algoritmo **não** serão digitados pelo usuário; em vez disso, os valores de entrada serão fornecidos como parâmetros na chamada da função.

Clique no botão **Avaliar** e, a seguir, no botão **Próximo**. Não altere nada no código ao lado!

<textarea class="code lang-python">
def voce_entendeu():
  return "sim"
</textarea>

<div class="testcode">
voce_entendeu().upper().strip() == 'SIM' or print('Você precisa responder sim para continuar')
</div>

## Retângulo

Crie uma função que recebe como medidas a base e altura de um retângulo e retorna a sua área.

Clique em **Rodar** para executar seu código, e em **Avaliar** para submeter e corrigir.

Se houver algum erro, ele aparecerá no painel à direita. Caso contrário, a saída do seu programa será vazia.

Se quiser testar o seu programa, existem duas opções:

- adicione instruções `print` ao final do programa para visualizar o resultado da função
- adicione instruções `assert` ao final do programa para verificar automaticamente o resultado da função

<textarea class="code lang-python">
def calcula_area(base, altura):
  return 0

### Se quiser ver o resultado da função,
### adicione alguns prints. Por exemplo:
#print(calcula_area(5, 0))   # deve imprimir 0
#print(calcula_area(20, 5))  # deve imprimir 100
#
### Você também pode usar assert CONDIÇÃO, que
### imprime um erro somente quando a condição
### é falsa. Por exemplo:
#
#assert calcula_area(5, 0) == 0
#assert calcula_area(20, 5) == 100
</textarea>
<div class="testcode">
assert calcula_area(0, 0) == 0
assert calcula_area(3, 4) == 12
</div>

## IMC

Crie uma função que determina se uma pessoa está obesa. Uma pessoa obesa é aquela que possui índice de massa corporal (IMC) igual ou superior a 30. O IMC é calculado pela razão entre o peso e o quadrado da altura de uma pessoa.

Lembre-se: a função não deve imprimir o resultado, e sim retorná-lo (com a palavra-chave `return`). Se quiser testar sua função antes de avaliar, adicione instruções `print` ou `assert` no final do programa, fora da função.

<textarea class="code lang-python">
def esta_obesa(peso, altura):
  return False
</textarea>
<div class="testcode">
assert esta_obesa(70, 1.70) == False
assert esta_obesa(170, 1.70) == True
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

Crie uma função que recebe um número inteiro, `N` e retorna uma lista com todos os números inteiros de 1 a `N`, em ordem crescente. Se `N` for zero ou negativo, deve ser retornada uma lista vazia.

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
