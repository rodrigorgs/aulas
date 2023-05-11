from tupy import *

class Carro(Image):
    def __init__(self):
        self.x = 50
        self.y = 200
        self.__velocidade = 0
        # visibilidade / acesso ---- sugestão para o programador
    
    def get_velocidade(self):
        return self.__velocidade

    def set_velocidade(self, v):
        if v >= 0 and v <= 40:
            self.__velocidade = v

    def acelerar(self):
        self.__velocidade += 5
        if self.__velocidade > 40:
            self.__velocidade = 40
    
    def freiar(self):
        self.__velocidade -= 5
        if self.__velocidade < 0:
            self.__velocidade = 0

    def update(self):
        self.x += self.__velocidade
        if self.x > 850:
            self.x = -50

carro = Carro()

run(globals())