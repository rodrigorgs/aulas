---
layout: page
title: Definindo classes
features: [code, python, uml]
---

## Definindo um novo tipo a partir de uma classe

Como vimos anteriormente, **todo objeto é de um tipo**, que é uma **classe**. Por exemplo:

- `5` é do tipo (classe) `int`
- `3.14` é do tipo (classe) `float`
- `"oi"` é do tipo (classe) `str`
- `[1, 2]` é do tipo (classe) `list`
- `date(2000, 12, 31)` é do tipo (classe) `date`

Podemos definir um novo tipo usando a palavra-chave `class`. Exemplos:

```python
class AlunoUniversitario:
  pass

# Classes também podem ser documentadas
# com docstrings:
class Vetor2d:
  '''Representa um vetor bidimensional (x, y)'''
```

Assim como funções, classes possuem um bloco de instruções. Não queremos escrever nada nesse bloco por enquanto, mas Python obriga que exista um bloco de instruções (caso contrário, dá erro ao executar o programa). Por isso escrevemos `pass`, que é uma instrução que não faz nada.

> Em Python, nomes de classes definidas pelo programador devem seguir a convenção de nomeação UpperCamelCase (primeira letra de cada palavra maiúscula). Isso não vale para classes embutidas na linguagem, como `int` e `list`.

## Instanciando a classe e criando atributos

Agora que definimos o tipo `Vetor2d`, vamos criar alguns objetos desse tipo:

<textarea class="code lang-python">
class Vetor2d:
  '''Representa um vetor bidimensional (x, y)'''

nulo = Vetor2d()
nulo.x = 0.0
nulo.y = 0.0

cima = Vetor2d()
cima.x = 0.0
cima.y = 1.0

print(cima)
print(type(cima))
</textarea>

> Criar um objeto a partir de uma classe é chamado de **instanciar a classe** ou **instanciar um objeto da classe**. Dizemos que o **objeto é uma instância da classe**. A partir de uma classe pode-se obter várias instâncias.

No exemplo de código, instanciamos a classe `Vetor2d` duas vezes. Como resultado, obtemos duas *instâncias* de `Vetor2d`, que são o objeto `(0, 0)` e o objeto `(0, 1)`.

## Definindo operações (forma ingênua)

Toda classe define as operações que seus objetos podem realizar. Por exemplo, no caso de listas, é possível inserir um elemento no final (`append`), remover um elemento (`remove`), obter o tamanho (`count`), dentre outras operações, No caso de vetores, podemos pensar nas seguintes operações:

- obter o tamanho
- normalizar (reduzir ou ampliar de forma a ficar com tamanho 1)
- somar com outro vetor

Depois vamos ver uma forma melhor, mas por enquanto podemos implementar essas operações através de funções:

<textarea class="code lang-python">
import math

class Vetor2d:
  '''Representa um vetor bidimensional (x, y)'''

def tamanho_vetor(v):
  return math.sqrt(v.x ** 2 + v.y ** 2)

def normalizar_vetor(v):
  tam = tamanho_vetor(v)
  v.x = v.x / tam
  v.y = v.y / tam

def soma_vetores(v, outro):
  novo = Vetor2d()
  novo.x = v.x + outro.x
  novo.y = v.y + outro.y
  return novo

# Exemplo de uso
cima = Vetor2d()
cima.x = 0.0
cima.y = 1.0

direita = Vetor2d()
direita.x = 1.0
direita.y = 0.0

inclinado = soma_vetores(cima, direita)
print(tamanho_vetor(inclinado))
normalizar_vetor(inclinado)
print(inclinado.x, inclinado.y)
</textarea>

Terminamos de definir o tipo `Vetor2d`, que possui dois atributos (`x` e `y`) e três operações (`tamanho_vetor`, `normalizar_vetor` e `soma_vetores`). Mas ainda podemos melhorar algumas coisas:

- A classe define o tipo. As funções estão fora da classe, então nada no programa indica explicitamente que as três funções que implementamos são as operações do tipo.
  - Um problema relacionado é que não conseguimos usar a notação `objeto.operacao()` para realizar operações. Isso ocorre porque criamos funções, não métodos.
- Podemos criar vetores inválidos, que não possuem o atributo `x` ou o atributo `y` (basta esquecer de atribuir um valor a um deles), e nesse caso todas as operações vão dar erro (experimente modificar o programa).

Vamos tratar um problema de cada vez.

## Transformando funções em métodos

Quando movemos funções para dentro de uma classe, elas se transformam em métodos, e a forma de chamar os métodos é diferente. Vamos começar com a função `tamanho_vetor`:

<textarea class="code lang-python">
import math

class Vetor2d:
  '''Representa um vetor bidimensional (x, y)'''

  def tamanho_vetor(v):
    return math.sqrt(v.x ** 2 + v.y ** 2)

# Cria vetor
inclinado = Vetor2d()
inclinado.x = 1.0
inclinado.y = 1.0
# Calcula tamanho
tam = inclinado.tamanho_vetor()
print(tam)
</textarea>

Note a diferença na hora de chamar a função e o método:

- Chamada da função: `tamanho_vetor(inclinado)`
- Chamada do método: `inclinado.tamanho_vetor()`

Vamos transformar a soma de vetores em método:

<textarea class="code lang-python">
import math

class Vetor2d:
  '''Representa um vetor bidimensional (x, y)'''

  def tamanho_vetor(v):
    return math.sqrt(v.x ** 2 + v.y ** 2)

  def soma_vetores(v, outro):
    novo = Vetor2d()
    novo.x = v.x + outro.x
    novo.y = v.y + outro.y
    return novo

# Cria vetor
cima = Vetor2d()
cima.x = 0.0
cima.y = 1.0

direita = Vetor2d()
direita.x = 1.0
direita.y = 0.0
# Cria vetor com a soma dos dois
inclinado = cima.soma_vetores(direita)
print(inclinado.x, inclinado.y)
</textarea>

Note a diferença na hora de chamar a função e o método:

- Chamada da função: `soma_vetores(cima, direita)`
- Chamada do método: `cima.soma_vetores(direita)`

> Ao chamar um método, usando o formato `objeto.metodo(param1, param2)`, o objeto é implicitamente passado como primeiro parâmetro do método; dessa forma, o método consegue acessar atributos e métodos do objeto.

## Self

Por convenção, quando criamos um método em Python, *sempre* <span class="tooltip">usamos o nome `self`<span class="tooltiptext">Como vimos, funciona com qualquer nome, mas é fortemente recomendado que se use o mesmo nome que todo mundo usa</span></span> (traduzindo, "o próprio") para o primeiro parâmetro. Desta forma, ao ler o código de um método, fica fácil saber quando estamos acessando atributos e métodos do próprio objeto a partir do qual o método foi chamado.

Então vamos alterar o nome do primeiro parâmetro para `self` e adicionar o último método, `normalizar_vetor`:

```python
import math

class Vetor2d:

  # ...

  def normalizar_vetor(self):
    tam = self.tamanho_vetor()
    self.x = self.x / tam
    self.y = self.y / tam
```

Vale uma observação: na hora de transformar a função `normalizar_vetor` em método, substituímos a chamada `tamanho_vetor(v)` por `self.tamanho_vetor()`.

## Melhorando os nomes dos métodos

Os nomes das funções continham a palavra `vetor` para deixar claro que eram funções de vetores, mas não faz sentido manter esses nomes em métodos da classe `Vetor2d`. Assim, podemos renomeá-los:

```python
import math

class Vetor2d:
  def tamanho(self):
    # ...
  def soma(self, outro):
    # ...
  def normalizar(self):
    # ...
```

## Resolvendo o problema dos vetores não-inicializados

Existe um método especial que sempre é chamado quando um objeto é criado: o método `__init__`. Nesse método devemos inicializar todos os atributos do objeto, de forma a evitar a criação de objetos incompletos. Veja o exemplo abaixo (estamos omitindo os demais métodos para fins didáticos):

<textarea class="code lang-python">
import math

class Vetor2d:
  '''Representa um vetor bidimensional (x, y)'''
  
  def __init__(self):
    self.x = 0.0
    self.y = 0.0

vec = Vetor2d()
print(vec.x, vec.y)
</textarea>

No exemplo, ao executar a expressão `Vetor2d()`, é criado um objeto da classe `Vetor2d`, e então é executado o método `__init__` do objeto, o que efetivamente inicializa os atributos `x` e `y`.

> O método `__init__` é chamado durante a instanciação de um objeto da classe; ele é chamado de <span class="tooltip">construtor<span class="tooltiptext">Em Python, ele é chamado de inicializador, mas a maioria das linguagens usa o termo construtor</span></span> da classe

## Construtor com parâmetros

Podemos adicionar parâmetros ao método `__init__`; isso obriga o programador a fornecer esses parâmetros durante a criação do objeto:

<textarea class="code lang-python">
class Vetor2d:
  '''Representa um vetor bidimensional (x, y)'''
  def __init__(self, x, y):
    self.x = x
    self.y = y

vec = Vetor2d(3.0, 4.0)
print(vec.x, vec.y)
vec.x = 5.0
print(vec.x, vec.y)
</textarea>

A expressão `Vetor2d(3.0, 4.0)` cria o objeto e implicitamente chama o método `__init__`, passando os valores `3.0` e `4.0` como parâmetro. Note que os atributos podem ser alterados normalmente depois da instanciação.

Experimente alterar o código acima de forma a não passar nenhum parâmetro e veja o que acontece.

## Parâmetros com valor default no construtor

Se você quiser dar ao programador a flexibilidade de informar ou não as coordenadas do vetor durante sua criação, você pode usar parâmetros com valor default:

<textarea class="code lang-python">
class Vetor2d:
  '''Representa um vetor bidimensional (x, y)'''
  def __init__(self, x=0.0, y=0.0):
    self.x = x
    self.y = y

zero = Vetor2d()
direita = Vetor2d(1.0)
cima = Vetor2d(0.0, 1.0)
print(zero.x, zero.y)
print(direita.x, direita.y)
print(cima.x, cima.y)
</textarea>