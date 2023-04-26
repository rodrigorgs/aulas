from tupy import *

class Semaforo(Image):
  def __init__(self):
    self.x = 320
    self.y = 240
    self.file = 'verde.png'

s = Semaforo()

run(globals())