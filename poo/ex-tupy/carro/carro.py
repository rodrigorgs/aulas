from tupy import *

class Carro(BaseImage):
    def __init__(self):
        self._x = 50
        self._y = 200
        self._velocidade = 0
        # visibilidade / acesso ---- sugestão para o programador
    
    def get_velocidade(self):
        return self._velocidade

    def set_velocidade(self, v):
        if v >= 0 and v <= 40:
            self._velocidade = v

    def acelerar(self):
        self._velocidade += 5
        if self._velocidade > 40:
            self._velocidade = 40
    
    def frear(self):
        self._velocidade -= 5
        if self._velocidade < 0:
            self._velocidade = 0

    def update(self):
        self._x += self._velocidade
        if self._x > 850:
            self._x = -50

carro = Carro()

run(globals())
