from tupy import *

class Pessoa(Image):
  def __init__(self, sombra):
    pass

class Sombra(Image):
  def __init__(self):
    pass

s = Sombra()
p = Pessoa(s)

run(globals())