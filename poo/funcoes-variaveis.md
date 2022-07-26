---
layout: page
title: Funções em Python - variáveis
features: [code, python]
---

## Exemplo motivador

Uma função tem acesso a variáveis que foram criadas fora da função:

<textarea class="code lang-python">
desconto = 5

def valor_final(preco):
  multiplicador = (100 - desconto) / 100
  return preco * multiplicador

print(valor_final(10.0))
</textarea>

No exemplo, a função `valor_final` usa a variável `desconto`, que foi definida fora da função.

Agora insira uma linha de código no final do programa: `print(multiplicador)`. O que aconteceu?

Note que fora da função não é possível acessar a variável `multiplicador`. Por que isso acontece?

## Escopo

**Escopo** de uma variável se refere à **região de um programa** que pode acessar uma variável.

No exemplo anterior:

- o escopo da variável `desconto` é o programa todo; ou seja, essa variável pode ser acessada em qualquer parte do programa, inclusive dentro de funções.
- o escopo da variável `multiplicador` é apenas o corpo da função `valor_final`; fora da função ela não pode ser acessada

Dizemos também que cada função **define um escopo**, ou seja, uma **região de código** na qual as variáveis ali definidas podem ser acessadas.

## Variáveis globais e locais

Variáveis **globais** são aquelas definidas *fora* de qualquer função. Após definidas, elas podem ser acessadas por qualquer parte do programa.

Variáveis **locais** são aquelas definidas *dentro* de uma função. Elas só podem ser acessadas dentro da função que a definiu.

No exemplo, dizemos que `multiplicador` é uma variável local à função `valor_final`.

## Parâmetros são variáveis locais

Um parâmetro de função é uma variável local à função que é inicializado no momento em que a função é chamada.

<textarea class="code lang-python">
desconto = 5

def valor_final(preco):
  multiplicador = (100 - desconto) / 100
  return preco * multiplicador

print(valor_final(10.0))
</textarea>

No exemplo acima, quando a função `valor_final` é chamada com o valor `10.0`, é criada uma variável `preco`, local à função, que passa a referenciar o valor `10.0`. A seguir é executado o código da função.

Concluindo, na função `valor_final`, as variáveis `preco` e `multiplicador` são locais; a variável `desconto` é global.

## Variável local mascara variável global de mesmo nome

Uma função pode definir uma variável local com o mesmo nome de uma variável global. Nesse caso dizemos que a variável local **sombreia** (ou **mascara**) a variável global.

Tente adivinhar a saída do código abaixo antes de executá-lo:

<textarea class="code lang-python">
glob = 5

def funcao():
  glob = 8
  print('Dentro da funcao:', glob)

funcao()
print('Fora da funcao:', glob)
</textarea>

No exemplo, qualquer referência ao nome `glob` dentro da função se refere à variável *local* `glob`; qualquer referência feita fora da função se refere à variável *global* `glob`.

### Palavra-chave global

Em Python, se quisermos atribuir um novo valor a uma variável global, devemos usar a palavra-chave `global`. Exemplo:

<textarea class="code lang-python">
glob = 5

def funcao():
  global glob
  glob = 8
  print('Dentro da funcao:', glob)

funcao()
print('Fora da funcao:', glob)
</textarea>

Note que, em geral, programadores não esperam que funções modifiquem variáveis globais, portanto use esse recurso com parcimônia para evitar surpresas.

## Não complique

É importante saber todas essas regras da linguagem, mas, quando for escrever código, o melhor é não complicar. Assim:

- *evite* definir uma variável local com o mesmo nome de uma variável global
- *evite* atribuir um novo valor para um parâmetro; prefira criar uma outra variável

## Evite variáveis globais

Variáveis globais tornam mais difícil a tarefa de compreender o que um programa faz. Considere novamente o exemplo:

```
desconto = 5

def valor_final(preco):
  multiplicador = (100 - desconto) / 100
  return preco * multiplicador

print(valor_final(10.0))
```

No exemplo, `valor_final(10.0)` resulta no valor `9.5`.

Vamos supor que um amigo seu escreveu mais linhas de código no final do programa, de forma a atender a novas funcionalides. Em algum outro ponto do código, ele escreveu `valor_final(10.0)` novamente. Pergunta: qual o resultado dessa chamada de função?

O resultado pode ser `9.5` novamente, mas, só olhando a linha de código que chama a função, não dá pra saber. Seu amigo pode ter mudado o valor da variável `desconto` em algum momento antes de chamar a função:

```python
desconto = 5

def valor_final(preco):
  multiplicador = (100 - desconto) / 100
  return preco * multiplicador

print(valor_final(10.0))   
# ...
# ...
desconto = desconto * 2
# ...
# ...
print(valor_final(10.0))
```

Para ter certeza, é preciso rodar todo o programa, linha a linha, para determinar o valor da variável global `desconto` no momento em que é feita a chamada a `valor_final`.

Portanto, evite definir funções que <span class="tooltip">dependam de variáveis globais<span class="tooltiptext">Constantes globais não são tão problemáticas. O problema é que Python não possui o conceito de constante.</span></span>.

O melhor a fazer nesse caso é passar como parâmetro todas as informações das quais a função depende:

```python
def valor_final(preco, desconto):
  multiplicador = (100 - desconto) / 100
  return preco * multiplicador
```

</textarea>

## Reatribuição de parâmetros

Considere o seguinte código:

<textarea class="code lang-python">
### CUIDADO: CÓDIGO ENGANOSO! ###
def troca_pelo_dobro(x):
  x = x * 2

numero = 5
troca_pelo_dobro(numero)
print(numero)
</textarea>

Por que a variável `numero` não mudou para `10`?

Quando realizamos a chamada `troca_pelo_dobro(numero)`, o que está sendo passado como parâmetro é o número `5`, e a variável local `x` passa a referenciar esse número. Ao executar `x = x * 2`, `x` passa a referenciar o número `10`. A variável número não é afetada.

Visualize a [execução do código passo-a-passo](https://pythontutor.com/render.html#code=def%20troca_pelo_dobro%28x%29%3A%0A%20%20x%20%3D%20x%20*%202%0A%0Anumero%20%3D%205%0Atroca_pelo_dobro%28numero%29%0Aprint%28numero%29&cumulative=false&curInstr=7&heapPrimitives=true&mode=display&origin=opt-frontend.js&py=3&rawInputLstJSON=%5B%5D&textReferences=false).

## Objetos mutáveis como parâmetro

Considere o seguinte código:

<textarea class="code lang-python">
def troca_pelo_dobro(x):
  x = x * 2

numero = 5
troca_pelo_dobro(numero)
print(numero)

def dobra_lista(l):
  for i in range(len(l)):
    l[i] = l[i] * 2

lista = [1, 2, 3]
dobra_lista(lista)
print(lista)
</textarea>

Por que `lista` muda para `[2, 4, 6]` enquanto `numero` não se altera?

Observe que, em Python, objetos do tipo `int` são imutáveis. A expressão `x = x * 2` não modifica o número, e sim cria um novo número e faz `x` referenciar esse novo número.

Já objetos do tipo `list` são mutáveis. Em particular, a instrução `l[i] = l[i] * 2` *modifica a lista*, fazendo a posição `i` da lista referenciar um novo número. Como tanto `l` quanto `lista` referenciam a mesma lista, modificar o objeto referenciado por `l` tem impacto sobre `lista`.

Considere agora o código a seguir. Você sabe explicar por que ele não funciona?

<textarea class="code lang-python">
### CUIDADO: CÓDIGO ENGANOSO! ###
def limpa_lista(l):
  l = []

lista = [1, 2, 3]
limpa_lista(lista)
print(lista)
</textarea>

> Funções podem modificar objetos mutáveis que recebem como parâmetro, mas reatribuir um parâmetro dentro de uma função não altera a variável passada como parâmetro.
