---
layout: page
title: Python e objetos
features: [code, python, quiz, uml]
---

## Um programa simples

Vamos começar com um dos programas mais simples em Python:

```python
mensagem = "Alô"
print(mensagem)
```

Nesse programa...

- `mensagem` é uma **variável**
- `"Alô"` é um **objeto** do tipo `str`
- `print` é uma **função**

## Objetos

Em Python, **variáveis são referências para objetos**. Isso significa que qualquer coisa que possa ser atribuída a uma variável é um **objeto**.

Eis alguns exemplos de objetos em Python:

- A string `"Alô"`
- O número `3.14`
- A lista `[1, 2, 3]` (os elementos de uma lista também são objetos)


<div class="quizdown">
### Identifique todos os objetos no programa abaixo

---
shuffleAnswers: false
---

```
x = "A" + "B"
```

- [ ] `x`
  > é uma **variável** que referencia um objeto
- [ ] `=`
  > é um operador de atribuição
- [x] `"A"`
- [ ] `+`
  > é um operador de concatenação de strings
- [x] `"B"`
</div>

## Variáveis referenciam objetos

Considere o seguinte programa:

```python
x = 1
y = x
```

As variáveis e objetos podem ser assim representados:

<div class="uml">
@startdot
digraph G {
  x [shape=none]
  y [shape=none]

  x -> 1
  y -> 1
}
@enddot
</div>

Nessa situação, considere agora a execução do seguinte código:

```python
y = y + 1
```

A expressão `y + 1` resulta em um outro objeto, o número `2`, e `y` passa a referenciar esse objeto. A variável `x` continua referenciando o objeto `1`:

<div class="uml">
@startdot
digraph G {
  x [shape=none]
  y [shape=none]

  x -> 1
  y -> 2
}
@enddot
</div>

> Dica: você pode visualizar as variáveis e objetos de qualquer programa Python no site [Python Tutor](https://pythontutor.com/). Para uma visualização mais próxima desta que apresentamos aqui, escolha a opção "render all objects on the heap" ao editar o código.

## Todo objeto é de um tipo

O **tipo** de um objeto determina...

- os valores que ele pode assumir 
- as operações que podem ser realizadas sobre ele

Por exemplo, o tipo `int` admite valores como `3` e `-8`, mas não valores como `4.5` ou `"livro"`.

Além disso, é possível realizar uma subtração entre dois objetos do tipo `int` usando o operador `-`, mas não é possível subtrair dois objetos do tipo `str` (strings).

### type()

Em Python, podemos determinar o **tipo** de um objeto através da função `type()`:

<textarea class="code lang-python">
print(type(-8))
print(type("Python"))
print(type(3.14 * 2))
print(type(True))
print(type([1, 2, 3]))
idade = 18
print(type(idade))
</textarea>

Note que

- `type(3.14 * 2)` significa "o tipo do objeto `6.28`"
- `type(idade)` significa "o tipo do objeto referenciado pela variável `idade`"

### dir()

Para ver quais operações podem ser realizadas sobre um objeto, use a função `dir()`:

<textarea class="code lang-python">
lista = ["a", "b"]
print(dir(lista))
</textarea>

Operações iniciadas por `__` são especiais; por exemplo:

- `__add__` significa adição usando o operador `+`
- `__gt__` significa comparação com o operador `>` (em inglês, *greater than*).

Você pode verificar que objetos do tipo `int` possuem a operação `__sub__` (subtração com `-`), enquanto objetos do tipo `list` não possuem essa operação.
