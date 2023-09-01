## Lâmpada

Crie um programa para o ambiente Tupy que simule uma ou mais lâmpadas, usando como referência o diagrama UML abaixo:

<div class="uml">
class Image {
  - x
  - y
  - file
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