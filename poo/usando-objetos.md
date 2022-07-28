---
layout: page
title: Usando objetos
features: [code, python, uml]
---

## Atributos e métodos

Vimos anteriormente que, em Python, variáveis referenciam objetos. Isso significa que números, strings e listas são objetos, dentre outros. Vimos também que todo objeto é de um tipo (ex.: `int`, `string`, `list`).

Além disso, objetos podem possuir **atributos** e **métodos**:

- **atributo**: variável que pertence a um objeto
- **método**: função que pertence a um objeto e pode acessar as variáveis do objeto

Suponha que `obj` é uma variável que referencia um objeto qualquer. Para acessar um atributo ou chamar um método desse objeto, escrevemos assim:

- `obj.nome_do_atributo`
- `obj.nome_do_metodo(param1, param2)`

# Exemplo: objetos do tipo date

```python
from datetime import date

### Cria objeto do tipo date
niver = date(2000, 12, 31)

### Acessa atributos
print(niver.day)
print(niver.month)
print(niver.year)

### Chama métodos
# Calcula e imprime dia da semana
print(niver.weekday())
# Troca ano
niver.replace(year=2030)
print(niver)
```

# Exemplo: objetos do tipo list

Listas não possuem atributos, mas possuem vários métodos.

```python
### Cria objeto do tipo list
l = list()

### Chama métodos
l.append("A")
l.append("B")
l.reverse()
print(l.__getitem__(0))
l.__setitem__(0, "X")
print(l.__getitem__(0))
print(l.count())
```

## Métodos especiais

No exemplo anterior, você deve ter visto a chamada de método `l.__getitem__(0)`, que retorna o item na posição 0 da lista. Isso é equivalente a `l[0]`. Da mesma forma, `l.__setitem__(0, "X")` seria mais comumente escrito como `l[0] = "X"`.

Métodos como `__setitem__` e `__getitem__` são **métodos especiais**. Eles são chamados quando certos operadores são usados.

Outro exemplo:

```python
x = 1
y = 2
print(x + y)
# É equivalente a
print(x.__add__(y))
```

Seguem alguns operadores e métodos especiais correspondentes:

| Expressão | Chamada de método equivalente |
|-----------|--------------------------|
| `x + y`   | `x.__add__(y)`           |
| `x - y`   | `x.__sub__(y)`           |
| `x * y`   | `x.__mul__(y)`           |
| `x / y`   | `x.__truediv__(y)`       |
| `x == y`  | `x.__eq__(y)`            |
| `x > y`   | `x.__gt__(y)`            |
| `str(x)`  | `x.__str__()`            |

Operadores como `+` e `==` podem ter significados diferentes a depender do tipo. Isso acontece porque cada tipo pode implementar métodos especiais de maneiras diferentes. Isso é chamado de **sobrecarga de operadores**. 

Por exemplo, o código do método `__add__` do tipo `int` realiza uma soma; já o método `__add__` do tipo `list` realiza a concatenção de listas. Por isso podemos escrever código como `[1, 2] + [3, 4]` (resultado: `[1, 2, 3, 4]`).

- Todo objeto é instância de uma classe
- Objetos podem possuir
  - atributos (variáveis que pertencem a um objeto)
  - métodos (funções que pertencem a um objeto)
- Para acessar atributos e métodos, usa-se a dot notation
- Até operadores como + são métodos. Ex.: `(1).__add__(2)`

> Objetos contém outros objetos, através de **atributos**, e podem ser manipulados através de **métodos**. Em Python, tudo são objetos, e toda interação com objetos se dá através de chamada de **métodos** e <span class="tooltip">acesso a atributos<span class="tooltiptext">Tecnicamente, o acesso a atributos é feito através da chamada de métodos especiais como __getattribute__ e __setattr__</span></span>. Até mesmo operadores, como `+` e `==`, são traduzidos em chamadas de métodos.

