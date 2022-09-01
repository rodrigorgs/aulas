---
layout: triple-page
title: "Exercícios: classes em Python"
features: [code, python]
---

## Retângulo simples

Defina uma classe `Retangulo`, com um método, `altera_dimensoes`, que recebe dois números; o método atribui o primeiro número ao atributo `base` do objeto e o segundo número ao atributo `altura`

<textarea class="code lang-python">
class Retangulo:
  '''Representa um retângulo, com base e altura'''
  def altera_dimensoes(self, b, a):
    '''
    Altera base e altura para os
    valores fornecidos como parâmetro
    '''

### Testes
r = Retangulo()
r.altera_dimensoes(23, 76)
assert r.base == 23
assert r.altura == 76
</textarea>

## Área e perímetro

Continuando o exercício anterior, implemente dois métodos adicionais:

- `area`: retorna a área do retângulo
- `perimetro`: retorna o perímetro do retângulo

<textarea class="code lang-python">
class Retangulo:
  '''Representa um retângulo, com base e altura'''
  def altera_dimensoes(self, b, a):
    '''
    Altera base e altura para os
    valores fornecidos como parâmetro
    '''

### Testes
r = Retangulo()
r.base = 4
r.altura = 3
assert r.area() == 12
assert r.perimetro() == 14
r.base = 5
assert r.area() == 15
assert r.perimetro() == 16

</textarea>

## Retângulo com construtor

Perceba que, se você consultar a área de um retângulo sem antes definir suas medidas, ocorre um erro. Exemplo:

```python
r = Retangulo()
print(r.area())
# Resultado: "AttributeError: 'Retangulo' object has no attribute 'base'"
```

Para evitar esse problema, você deve criar um construtor/inicializador.

Copie sua solução do exercício anterior e cole aqui, fazendo uma modificação: defina a classe `Retangulo` de forma que, para instanciar um objeto, é necessário informar base e altura.

<textarea class="code lang-python">
class Retangulo:
  pass

### Testes
r = Retangulo(3, 4)
assert r.area() == 12
r.base = 5
assert r.area() == 20
</textarea>

## Aumentar retângulo

Implemente o método `aumenta` conforme a documentação. Consulte os testes para ver um exemplo de como o método é chamado e qual o resultado esperado.

<textarea class="code lang-python">
class Retangulo:
  def __init__(self, base, altura):
    self.base = base
    self.altura = altura
  def aumenta(self, outro):
    '''
    Redimensiona este retângulo, cujas dimensões
    passam a ser a soma das suas dimensões originais
    com as dimensões de outro retângulo, passado
    como parâmetro
    '''

### Testes
r1 = Retangulo(4, 5)
r2 = Retangulo(1, 2)
r1.aumenta(r2)
assert r1.base == 5 and r1.altura == 7
assert r2.base == 1 and r2.altura == 2
</textarea>

## Soma de retângulos

Implemente o método `mais` conforme a documentação. Consulte os testes para ver um exemplo de como o método é chamado e qual o resultado esperado.

<textarea class="code lang-python">
class Retangulo:
  def __init__(self, base, altura):
    self.base = base
    self.altura = altura
  def mais(self, outro):
    '''
    Cria um novo retângulo, cujas dimensões são
    a soma das dimensões deste retângulo com as
    dimensões de outro retângulo, passado como
    parâmetro
    '''

### Testes
r1 = Retangulo(4, 5)
r2 = Retangulo(1, 2)
r3 = r1.mais(r2)
assert r1.base == 4 and r1.altura == 5
assert r2.base == 1 and r2.altura == 2
assert r3.base == 5 and r3.altura == 7
</textarea>

## Retângulo com propriedades

Defina a classe `Retangulo` com dois atributos, `base` e `altura` (inicializados durante a criação do objeto), e uma propriedade, `area`, que é computada a partir dos dois atributos mas não pode ser alterada.

<textarea class="code lang-python">
class Retangulo:
  def __init__(self, base, altura):
    self.base = base
    self.altura = altura

### Testes
r1 = Retangulo(3, 4)
assert r1.area == 12

r1.base = 5
r1.altura = 3
assert r1.area == 15

houve_excecao = False
try:
  r1.area = 10
except AttributeError as e:
  houve_excecao = True
assert houve_excecao
</textarea>

## Retângulo com razão

Defina a classe `Retangulo` com dois atributos, `base` e `altura` (inicializados durante a criação do objeto), e uma propriedade, `razao`, que indica a razão `base / altura`. Além disso, deve ser possível alterar a razão de um retângulo; nesse caso, a altura é alterada para refletir a nova razão.

Por exemplo, um retângulo de 10x5 possui razão 2. Se alterarmos a razão para 4, o retângulo passará a ter dimensões 10x2.5.

<textarea class="code lang-python">
class Retangulo:
  def __init__(self, base, altura):
    self.base = base
    self.altura = altura

### Testes
r = Retangulo(10, 5)
assert r.razao == 2
r.base = 20
assert r.razao == 4
r.razao = 1
assert r.base == 20 and r.altura == 20
r.razao = 0.5
assert r.base == 20 and r.altura == 40
</textarea>
