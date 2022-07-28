---
layout: page
title: Funções em Python - recursos da linguagem
features: [code, python]
---

## Parâmetros default

É possível chamar uma função sem passar todos os parâmetros, contanto que a função defina **valores default** para os parâmetrods que não forem passados. Exemplo:


<textarea class="code lang-python">
def valor_final(preco, desconto=5):
  multiplicador = (100 - desconto) / 100
  return preco * multiplicador

print(valor_final(10.0))
print(valor_final(10.0, 5))
print(valor_final(10.0, 30))
</textarea>

No exemplo, as duas primeiras chamadas são equivalentes.

## Argumentos nomeados

Chama-se de **argumento** um valor passado para um parâmetro ao se chamar uma função.

No exemplo anterior, ao chamar `valor_final(10.0, 30)`, sabemos que o argumento `10.0` é passado para o parâmetro `preco`, enquanto o argumento `30` é passado para o parâmetro `desconto`. A associação entre argumentos e parâmetros é **posicional**: primeiro com primeiro, segundo com segundo e assim por diante.

Existe, no entanto, outra forma de passar argumentos na chamada de uma função: especificando o nome do parâmetro. Assim, as linhas de código a seguir são equivalentes:

```python
print(valor_final(10.0, 30))
print(valor_final(preco=10.0, desconto=30))
print(valor_final(desconto=30, preco=10.0))
print(valor_final(10.0, desconto=30))
```

Argumentos nomeados são especialmente úteis ao se chamar funções que possuem muitos parâmetros, o que torna difícil lembrar a ordem dos parâmetros. Exemplo fictício:

```python
cria_janela(
  titulo="Calculadora",
  maximizavel=False,
  menu=["Arquivo", "Sair"],
  flutuante=True,
  transparente=False)
```

## Docstring

Docstring é uma string que aparece como primeira instrução em uma função, e serve para documentá-la. Essa string pode ser acessada através do atributo especial `__doc__`. Exemplo:

<textarea class="code lang-python">
def soma(a, b):
  """
  Soma dois números, a e b.
  Retorna um número, que é a soma dos dois números.
  """
  return a + b

print(soma.__doc__)
</textarea>

Docstrings também são usadas por ferramentas como [pydoc](https://docs.python.org/pt-br/3/library/pydoc.html) para gerar um documento com a lista de funções de um programa e suas respectivas documentações.