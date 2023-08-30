---
layout: triple-page
title: "Exercícios: classes em Python"
features: [code, python, uml]
---

## Ponto

Considere o seguinte diagrama:

<div class="uml">
class Ponto {
  - x: float
  - y: float
  + __init__(x: float, y: float)
  + distancia(p: Ponto): float
}
</div>

Implemente a classe usando a linguagem Python.

Considere que a distância entre dois pontos é dada pela fórmula:

```python
d = sqrt((x2-x1)**2 + (y2-y1)**2)
```

<textarea class="code lang-python">
from math import sqrt

class Ponto:
  pass
</textarea>

<textarea class="stdin">
# code
p1 = Ponto(0, 0)
p2 = Ponto(3, 4)
print(p1.distancia(p2)) # 5
</textarea>

<div class="testcode">
try:
  p = Ponto(1, 2)
  assert p.x == 1
  assert p.y == 2
  assert p.distancia(Ponto(1, 2)) == 0
  assert p.distancia(Ponto(1, 3)) == 1
  assert p.distancia(Ponto(2, 2)) == 1
  assert p.distancia(Ponto(2, 3)) == sqrt(2)
except AssertionError as e:
  print('[ERRO]', e)
</div>

## Carrinho de compras

Considere o seguinte diagrama:

<div class="uml">
top to bottom direction

class Carrinho {
  - encerrado: bool
  + adicionar(item: Item)
  + encerrar()
  + total(): float
}

class Item {
  - nome: str
  - preco: float
  + __init__(nome: str, preco: float)
}

Carrinho --> "itens *" Item
</div>

Implemente as classes usando a linguagem Python. Considere que:

- O carrinho começa vazio e aberto.
- O método `adicionar` adiciona um item ao carrinho.
- O método `encerrar` fecha o carrinho.
- Novos itens não podem ser adicionados a um carrinho fechado.
- O método `total` retorna a soma dos preços dos itens.
- O carrinho deve armazenar seus itens em um objeto do tipo `list` (`[]`)

OBS.: Neste momento não se preocupe com ocultação de informação (atributos privados) ou com exceções. Esses assuntos serão abordados mais adiante.

<textarea class="code lang-python">

</textarea>

<textarea class="stdin">
# code
c = Carrinho()
c.adicionar(Item('tv', 500))
c.adicionar(Item('sofá', 2000))
c.encerrar()
c.adicionar(Item('chiclete', 5))
print(c.total()) # 2500
# 2500, pois o carrinho já estava
# fechado ao adicionar o chiclete
</textarea>

<div class="testcode">
import unittest
from unittest import mock

# Add __eq__ to Item (monkey patching)
def item_eq(self, other):
  return self.nome == other.nome and self.preco == other.preco
Item.__eq__ = item_eq

class TestCarrinho(unittest.TestCase):
  def test_carrinho(self):
    c = Carrinho()
    self.assertEqual(c.itens, [])
    self.assertFalse(c.encerrado)
    c.adicionar(Item('banana', 2))
    self.assertEqual(c.itens, [Item('banana', 2)])
    c.adicionar(Item('maçã', 3))
    self.assertEqual(c.itens, [Item('banana', 2), Item('maçã', 3)])
    self.assertFalse(c.encerrado)
    c.encerrar()
    self.assertTrue(c.encerrado)
    c.adicionar(Item('laranja', 1))
    self.assertEqual(c.itens, [Item('banana', 2), Item('maçã', 3)])
    self.assertEqual(c.total(), 5)

if __name__ == '__main__':
  import sys
  unittest.main(exit=False)
</div>

<!--
{% comment %}
class Carrinho:
  def __init__(self):
    self.encerrado = False
    self.itens = []
    
  def adicionar(self, item):
    if not self.encerrado:
      self.itens.append(item)
  
  def encerrar(self):
    self.encerrado = True
  def total(self):
    soma = 0.0
    for item in self.itens:
      soma += item.preco
    return soma

class Item:
  def __init__(self, nome, preco):
    self.nome = nome
    self.preco = preco
{% endcomment %}
-->

## Inscrição em disciplinas

Considere o seguinte diagrama:

<div class="uml">
class Inscricao {
  - nota: float
  + __init__(aluno: Aluno, disciplina: Disciplina)
}

class Aluno {
  - nome: str
  - matricula: int
  + __init__(nome, matr)
}

class Disciplina {
  - nome: str
  - codigo: str
  + __init__(nome, codigo)
  + inscrever(aluno: Aluno)
  + registrar_nota(matricula, nota)
  + taxa_aprovacao(): float
}

Disciplina --> "inscritos *" Inscricao
Inscricao --> "aluno 1" Aluno
Inscricao --> "disciplina 1" Disciplina
</div>

Implemente as classes usando a linguagem Python. Considere que:

- A nota de um aluno em uma disciplina é 0,0 até que seja alterada.
- A taxa de aprovação de uma disciplina é a proporção de alunos (entre 0,0 e 1,0) cuja nota final na disciplina é maior ou igual a 5,0.
- O método `inscrever` cria uma inscrição para o aluno na disciplina.
- A disciplina guarda uma lista de inscrições, representada como uma lista da linguagem Python (`[]`). Ao inscrever um aluno, a inscrição é inserida no final da lista.
- Para este exemplo, ao tentar inscrever um aluno em uma disciplina, não é necessário verificar se ele já está inscrito (esse caso não será testado).

<textarea class="code lang-python">
</textarea>

<textarea class="stdin">
# code
disc = Disciplina('POO', 'MATA55')
maria = Aluno('Maria', 123)
disc.inscrever(maria)
disc.inscrever(Aluno('João', 456))
disc.registrar_nota(123, 7)
print(disc.taxa_aprovacao()) # 0.5
</textarea>

<div class="testcode">
import unittest
from unittest import mock

def aluno_eq(self, other):
  return self.nome == other.nome and self.matricula == other.matricula
Aluno.__eq__ = aluno_eq

def inscricao_eq(self, other):
  return self.aluno == other.aluno and self.disciplina == other.disciplina
Inscricao.__eq__ = inscricao_eq

def disciplina_eq(self, other):
  return self.nome == other.nome and self.codigo == other.codigo and self.inscritos == other.inscritos
Disciplina.__eq__ = disciplina_eq

class TestDisciplina(unittest.TestCase):
  def test_disciplina(self):
    d = Disciplina('POO', 'MATA55')
    self.assertEqual(d.nome, 'POO')
    self.assertEqual(d.codigo, 'MATA55')
    self.assertEqual(d.inscritos, [])
    self.assertEqual(d.taxa_aprovacao(), 0)
    d.inscrever(Aluno('Maria', 123))
    self.assertEqual(d.inscritos, [Inscricao(Aluno('Maria', 123), d)])
    d.inscrever(Aluno('João', 456))
    self.assertEqual(d.inscritos, [Inscricao(Aluno('Maria', 123), d), Inscricao(Aluno('João', 456), d)])
    d.registrar_nota(123, 7)
    self.assertEqual(d.taxa_aprovacao(), 0.5)
    d.registrar_nota(456, 3)
    self.assertEqual(d.taxa_aprovacao(), 0.5)
    d.registrar_nota(456, 7)
    self.assertEqual(d.taxa_aprovacao(), 1)

if __name__ == '__main__':
  import sys
  unittest.main(exit=False)
</div>

<!--
{% comment %}
class Aluno:
  def __init__(self, nome, matr):
    self.nome = nome
    self.matricula = matr

class Inscricao:
  def __init__(self, aluno, disciplina):
    self.aluno = aluno
    self.disciplina = disciplina
    self.nota = 0.0
    
class Disciplina:
  def __init__(self, nome, codigo):
    self.nome = nome
    self.codigo = codigo
    self.inscritos = []

  def inscrever(self, aluno):
    self.inscritos.append(Inscricao(aluno, self))

  def registrar_nota(self, matricula, nota):
    for insc in self.inscritos:
      if insc.aluno.matricula == matricula:
        insc.nota = nota

  def taxa_aprovacao(self):
    if len(self.inscritos) == 0:
      return 0
    qtd = 0
    for insc in self.inscritos:
      if insc.nota >= 5.0:
        qtd += 1
    return qtd / len(self.inscritos)
    
{% endcomment %}
-->