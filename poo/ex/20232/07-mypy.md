---
layout: triple-page
title: "Exercícios: tipagem estática"
features: [code, python]
---

## Registra participante

Adicione anotações de tipo à função `registra` abaixo, de modo que ela possa ser usada com qualquer nome e sobrenome, mas não com outros tipos de dados.

Orientações para esta e as próximas questões da lista:

- Para obter mais informações sobre possíveis erros de tipo em seu código, analise-o através do **mypy** sem erros. Para isso, você deve usar a opção `--strict` do mypy, que ativa todas as verificações disponíveis.
- Você pode instalar o mypy com `pip install mypy` ou então testar online no [myPy Playground (strict)](https://mypy-play.net/?mypy=latest&python=3.11&flags=strict)

<textarea class="code lang-python">
def registra(nome, sobrenome) -> None:
  print(f"{nome} {sobrenome} registrado.")
</textarea>

<textarea class="stdin">
# code
registra("João", "Silva")
registra("Maria", "Santos")
</textarea>

<div class="mypy">
--strict
</div>

<div class="testcode">
try:
  assert registra.__annotations__ == {'nome': str, 'sobrenome': str, 'return': None}, 'Anotações de tipo incorretas'

  output = ''
  def new_print(x):
    global output
    output = x
  print = new_print

  assert registra("João", "Silva") is None
  registra("João", "Silva")
  assert output == "João Silva registrado."
  registra("Maria", "Santos")
  assert output == "Maria Santos registrado."
except AssertionError as e:
  print('[ERRO]', e)
</div>

## Retângulo

Adicione anotações de tipo nos parâmetros e no retorno dos métodos.

<textarea class="code lang-python">
class Ponto:
  def __init__(self, x, y):
    self.x = x
    self.y = y

class Retangulo:
  def __init__(self, canto_sup_esq, canto_inf_dir):
    self.canto_sup_esq = canto_sup_esq
    self.canto_inf_dir = canto_inf_dir

  def area(self):
    return (self.canto_inf_dir.x - self.canto_sup_esq.x) * (self.canto_inf_dir.y - self.canto_sup_esq.y)

</textarea>

<textarea class="stdin">
# code
r = Retangulo(Ponto(0, 0), Ponto(9.5, 10.5))
print(r.area())
</textarea>


<div class="mypy">
--strict
</div>

<div class="testcode">
try:
  assert Ponto.__init__.__annotations__ == {'x': float, 'y': float, 'return': None}, 'Anotações de tipo incorretas em Ponto'
  assert Retangulo.__init__.__annotations__ == {'canto_sup_esq': Ponto, 'canto_inf_dir': Ponto, 'return': None},'Anotações de tipo incorretas em Retangulo'
  assert Retangulo.area.__annotations__ == {'return': float}, 'Anotações de tipo incorretas em area()'
  p = Ponto(1, 2)
  assert p.x == 1 and p.y == 2
  p = Ponto(3, -3)
  assert p.x == 3 and p.y == -3
  r = Retangulo(Ponto(1, 1), Ponto(11, 11.5))
  assert abs(r.area() - 105.0) < 1e-6
  r = Retangulo(Ponto(0, 0), Ponto(10, 10))
  assert abs(r.area() - 100.0) < 1e-6
except AssertionError as e:
  print('[ERRO]', e)
</div>

## Caça ao tesouro

Em uma competição de caça ao tesouro, os participantes, acompanhados ou não de seus bichos de estimação, devem encontrar o maior número de objetos escondidos. A função ao lado realiza a inscrição de um participante e de seu pet, se houver. Identifique e corrija o erro de tipo na função.

<textarea class="code lang-python">
class Pessoa:
  def __init__(self, nome: str) -> None:
    self.nome = nome

class Pet:
  def __init__(self, nome: str, tipo: str) -> None:
    self.nome = nome
    self.tipo = tipo

def inscreve(dono: Pessoa, pet: Pet = None) -> str:
  if pet is None:
    return f'Inscrição realizada: {dono.nome}'
  else:
    return f'Inscrição realizada: {dono.nome} e {pet.nome}'

</textarea>

<textarea class="stdin">
# code
f = Pessoa('Fulano')
r = Pet('Rex', 'cachorro')
print(inscreve(f, r))
print(inscreve(Pessoa('Sozinho')))
</textarea>

<div class="mypy">
--strict
</div>

<div class="testcode">
try:
  from typing import Optional
  assert inscreve.__annotations__ == {'dono': Pessoa, 'pet': Optional[Pet], 'return': str}, 'Anotações de tipo incorretas'

  assert inscreve(Pessoa('Fulano'), Pet('Rex', 'cachorro')) == 'Inscrição realizada: Fulano e Rex'
  assert inscreve(Pessoa('Sozinho')) == 'Inscrição realizada: Sozinho'
except AssertionError as e:
  print('[ERRO]', e)
</div>

## Lista de números

A função `adiciona_elementos_sorteados` abaixo adiciona elementos sorteados a uma lista de inteiros. Identifique e corrija o erro de tipo na função.

<textarea class="code lang-python">
import random
def adiciona_elementos_sorteados(lista: list, n: int) -> None:  
  for i in range(n):
    lista.append(random.randint(0, 100))
</textarea>

<textarea class="stdin">
# code
l = []
adiciona_elementos_sorteados(l, 3)
print(l)
</textarea>

<div class="mypy">
--strict
</div>

<div class="testcode">
try:
  an = adiciona_elementos_sorteados.__annotations__
  assert an == {'lista': list[int], 'n': int, 'return': None}, 'Anotações de tipo incorretas'
except AssertionError as e:
  print('[ERRO]', e)
</div>

## Lista sortida

A função `adiciona_elementos_sorteados` abaixo adiciona elementos sorteados a uma lista, que só pode conter elementos do tipo `str` ou do tipo `int`. Identifique e corrija o erro de tipo na função.

<textarea class="code lang-python">
import random
import string
def adiciona_elementos_sorteados(lista: list, n: int) -> None:  
  for i in range(n):
    if random.randint(0, 100) % 2 == 0:
      lista.append(random.randint(0, 100))
    else:
      lista.append(random.choice(string.ascii_letters))
</textarea>

<textarea class="stdin">
# code
l = []
adiciona_elementos_sorteados(l, 3)
print(l)
</textarea>


<div class="mypy">
--strict
</div>

<div class="testcode">
from typing import Union
try:
  an = adiciona_elementos_sorteados.__annotations__
  assert an == {'lista': list[Union[str, int]], 'n': int, 'return': None}, 'Anotações de tipo incorretas'
except AssertionError as e:
  print('[ERRO]', e)
</div>