---
layout: page
title: Identidade e mutabilidade
features: [code, python, quiz, uml]
---

## Todo objeto tem uma identidade

Digamos que você e seu amigo são donos de uma **mesma** barra de chocolate. Se você comer o chocolate todo, seu amigo fica sem.

Se, por outro lado, você e seu amigo possuem barras de chocolate **iguais** (mas não a mesma), você pode comer seu chocolate sem prejudicar seu amigo.

Outro exemplo: cada pessoa possui um número de CPF, que a identifica unicamente na população. Gêmeos idênticos, mesmo que sejam iguais em tudo, possuem CPFs diferentes. São **iguais**, mas não são a **mesma** pessoa.

Da mesma forma, **cada objeto possui uma identidade**.

### id()

A função `id()` retorna a **identidade** de um objeto, que é um número inteiro.

Esse número é o endereço na memória onde o objeto foi alocado, e por isso pode mudar cada vez que o programa é executado.

<textarea class="code lang-python">
x = [1, 2, 3]
y = [1, 2, 3]
z = y
print(id(x))
print(id(y))
print(id(z))</textarea>

Você pode perceber que neste programa existem dois objetos do tipo lista, e ambos possuem a sequência 1, 2, 3. São objetos iguais, mas não são o mesmo objeto. Veja o diagrama de variáveis e objetos:

<div class="uml">
@startdot
digraph G {
  x [shape=none]
  y [shape=none]
  z [shape=none]

  x -> "[1, 2, 3]"
  y -> "[1, 2, 3] "
  z -> "[1, 2, 3] "
}
@enddot
</div>

### Operadores == e is

Dois objetos podem ser comparados com os operadores `==` ou `is`:

- `x == y` determina se `x` e `y` são objetos **iguais**.
- `x is y` determina se `x` e `y` são o **mesmo** objeto.

<div class="quizdown">

### Qual é a saída deste programa?

> Duas listas são iguais se possuem os mesmos elementos, na mesma ordem e quantidade

```python
x = [1, 2, 3]
y = [1, 2, 3]
print(x == y)
```

1. [x] True
2. [ ] False

### E qual é a saída deste outro programa?

```python
x = [1, 2, 3]
y = [1, 2, 3]
print(x is y)
```

1. [ ] True
    > `x` e `y` não referenciam o mesmo objeto, ainda que eles sejam iguais
2. [x] False
</div>

## Mutabilidade

Por que é importante saber se duas variáveis referenciam o mesmo objeto? Essa informação pode ser importante quando estamos **modificando** um objeto.

Por exemplo, se as variáveis `v1` e `v2` referenciam o mesmo objeto, isso significa que podemos modificar o objeto referenciado `v1` sem manipular a variável `v1`, o que pode causar surpresas.

Considere o quiz a seguir:

<div class="quizdown">

### Qual é a saída deste programa?

```python
a = [1, 2, 3]
b = [1, 2, 3]
b.append(4)  # insere 4 no final da lista
print(a)
```

1. [x] [1, 2, 3]
2. [ ] [1, 2, 3, 4]
    > `a` e `b` referenciam listas diferentes; apenas a lista referenciada por `b` foi modificada.

### E qual é a saída deste outro programa?

```python
a = [1, 2, 3]
b = a
b.append(4)  # insere 4 no final da lista
print(a)
```

1. [ ] [1, 2, 3]
    > `a` e `b` referenciam a mesma lista, e essa lista foi modificada
2. [x] [1, 2, 3, 4]
</div>

### Objetos mutáveis e imutáveis

Alguns objetos podem ser modificados, outros não. Os primeiros são chamados de **mutáveis**; o contrário de mutável é **imutável**.

### list

Objetos do tipo `list` são **mutáveis**. Listas podem ser modificadas a partir de operações como `append`, `extend` e `remove` (chamadas de **operações destrutivas**). Existem, no entanto, operações que não modificam a lista (chamadas de **operações não-destrutivas**), e sim constroem uma nova lista.

Considere o seguinte programa:

<textarea class="code lang-python">
a = [1, 2, 3]
b = a
b = b + [4, 5]
print(a)
print(b)
</textarea>

(Se quiser, pode [visualizar a execução deste programa passo-a-passo](https://pythontutor.com/render.html#code=a%20%3D%20%5B1,%202,%203%5D%0Ab%20%3D%20a%0Ab%20%3D%20b%20%2B%20%5B4,%205%5D%0Aprint%28a%29%0Aprint%28b%29&cumulative=false&curInstr=5&heapPrimitives=nevernest&mode=display&origin=opt-frontend.js&py=3&rawInputLstJSON=%5B%5D&textReferences=false))

Note que a lista `a` não foi modificada. Isso acontece porque `b + [4, 5]` é uma expressão que cria uma nova lista, e `b` passa a referenciar essa nova lista. A operação `+` é não-destrutiva.

### int

Objetos do tipo `int` são imutáveis. Isso ocorre porque o tipo `int` possui *somente* operações não-destrutivas.

Considere o seguinte código:

```python
a = 1
b = a
```

As variáveis `a` e `b` referenciam o mesmo objeto. Como objetos do tipo `int` são imutáveis, qualquer operação sobre a variável `b` não vai ter nenhum impacto sobre a variável `a`. Por exemplo, se fizermos `b = b + 1`, o objeto `1`, referenciado por `a`, vai se manter; um novo objeto, `2`, será criado, e `b` referenciará esse novo objeto.

### Outros tipos

Como vimos, `list` é mutável. Outros tipos mutáveis incluem `dict` (dicionários) e `set` (conjuntos).

Como vimos, `int` é imutável. Outros tipos imutáveis incluem `float` (número decimal), `str` (strings), `bool` (booleano), e `tuple` (tuplas).
