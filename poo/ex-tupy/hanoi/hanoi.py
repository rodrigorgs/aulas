from tupy import *

class Disco(Image):
  def __init__(self, tamanho):
    self.file = 'disco1.png'

class Torre(Image):
  def __init__(self, x, y, discos):
    pass

  def disco_do_topo(self):
    return None

  def move_disco_para_torre(self, destino):
    return False

disco3 = Disco(3)
disco2 = Disco(2)
disco1 = Disco(1)
torre1 = Torre(200, 300, [disco3, disco2, disco1])
torre2 = Torre(300, 300, [])
torre3 = Torre(400, 300, [])

run(globals())