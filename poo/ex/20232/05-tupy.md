---
layout: triple-page
title: "Exercícios: Tupy"
features: [code, python, uml]
---

## Lâmpada (LISTA EM CONSTRUÇÃO)

Crie um programa para o ambiente Tupy que simule uma ou mais lâmpadas, usando como referência o diagrama UML abaixo:

<div class="uml">
class Image {
  - x, y, file
}
class Lampada {
  - ligada: bool
  + liga()
  + desliga()
}

Image <|-- Lampada
</div>

A lâmpada pode estar ligada ou desligada. Ao ligar, a lâmpada deve exibir a imagem `ligada.png`; ao desligar, a imagem `desligada.png`. Ao ser criada, uma lâmpada deve estar inicialmente desligada.

<textarea class="code lang-python">
from tupy import *

# Define a classe Lampada
class Lampada(Image):
  def __init__(self):
    self.file = 'desligada.png'

# Cria duas lâmpadas
lamp1 = Lampada()
lamp2 = Lampada()

run(globals())
</textarea>

<div class="runtemplate">
class Image:
  def __new__(cls, *args, **kwargs):
    self = super().__new__(cls)
    self.x = 0
    self.y = 0
    self.file = self.__class__.__name__.lower() + '.png'
    self.angle = 0
    return self

def run(x):
  pass
[[[code]]]
</div>

<div class="testcode">
class Image:
  def __new__(cls, *args, **kwargs):
    self = super().__new__(cls)
    self.x = 0
    self.y = 0
    self.file = self.__class__.__name__.lower() + '.png'
    self.angle = 0
    return self

def run(x):
  pass
[[[code]]]
import unittest
class TestLampada(unittest.TestCase):
  def test_liga_desliga(self):
    l = Lampada()
    self.assertEqual(l.file, 'desligada.png')
    self.assertEqual(l.ligada, False)
    l.liga()
    self.assertEqual(l.file, 'ligada.png')
    self.assertEqual(l.ligada, True)
    l.desliga()
    self.assertEqual(l.file, 'desligada.png')
    self.assertEqual(l.ligada, False)

    l2 = Lampada()
    l2.liga()
    self.assertEqual(l2.file, 'ligada.png')
    self.assertEqual(l2.ligada, True)
    self.assertEqual(l.file, 'desligada.png')
    self.assertEqual(l.ligada, False)

if __name__ == '__main__':
  import sys
  unittest.main(exit=False)
</div>

## Interruptor e lâmpada

Considere agora o seguinte diagrama UML:

<div class="uml">
class Lampada {
  - ligada: bool
  + liga()
  + desliga()
}

class Interruptor {
  - ligado: bool
  + conectar(lampada)
  + alterna()
}

Interruptor --> "lampadas *" Lampada
</div>

Ambas as classes devem estender a classe Image do Tupy (omitida do diagrama para não poluir).

Cada interruptor pode estar conectado a várias lâmpadas. Em um dado momento, um interruptor pode estar ligado ou desligado. Ao ser criado, um interruptor deve estar inicialmente desligado. Ao ser ligado, o interruptor deve ligar todas as lâmpadas a ele associadas; ao ser desligado, deve desligar todas as lâmpadas a ele associadas.

<textarea class="code lang-python">
from tupy import *

class Interruptor(Image):
  pass

class Lampada(Image):
  pass

# Exemplo de uso
l1 = Lampada()
l2 = Lampada()
l3 = Lampada()
l4 = Lampada()
i1 = Interruptor()
i1.conectar(l1)
i1.conectar(l3)
i1.conectar(l4)
i2 = Interruptor()
i2.conectar(l2)
i2.conectar(l3)
i3 = Interruptor()
i3.conectar(l4)

run(globals())
</textarea>

## Amarelinha



## Pular corda

