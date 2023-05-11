import random

class Carta:
	def __init__(self, cor: str, valor: str):
		'''
		cor pode ser vermelha, amarela, azul, verde ou preta
		valor pode ser '0', '1', ..., '9',
		  'reverse', 'bloqueio', 'cava2', 'cava4', 'troca_cor'
		'''
		self.cor = cor
		self.valor = valor

class Baralho:
	def __init__(self):
		self.cartas = []
		for cor in ['vermelha', 'amarela', 'azul', 'verde']:
			for valor in ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'reverse', 'bloqueio', 'cava2']:
				self.cartas.append(Carta(cor, valor))

		for valor in ['cava4', 'troca_cor']:
			self.cartas.append(Carta('preta', valor))
			self.cartas.append(Carta('preta', valor))

	def embaralha(self):
		random.shuffle(self.cartas)

	def pega_carta_do_topo(self) -> Carta:
		return self.cartas.pop()

	def imprime(self):
		for carta in self.cartas:
			print(carta.cor, carta.valor)

class Mesa:
	def __init__(self, carta):
		self.carta = carta

	def joga_carta(self, carta) -> bool:
		if carta.cor == self.carta.cor:
			self.carta = carta
			return True
		else:
			return False

class Jogador:
	def __init__(self, nome, posicao):
		self.nome = nome
		self.posicao = posicao
		self.cartas = []

	def adiciona_carta(self, carta: Carta):
		self.cartas.append(carta)

	def imprime(self):
		print(f'Mão do jogador {self.nome}:')
		for carta in self.cartas:
			print(carta.cor, carta.valor)

baralho = Baralho()
baralho.embaralha()
jogador1 = Jogador('Fulana', 0)
jogador2 = Jogador('Sicrano', 1)

for i in range(7):
	jogador1.adiciona_carta(baralho.pega_carta_do_topo())
	jogador2.adiciona_carta(baralho.pega_carta_do_topo())

mesa = Mesa(baralho.pega_carta_do_topo())

while True:
	for jogador in [jogador1, jogador2]:
		print("Carta na mesa:")
		print("  ", mesa.carta.cor, mesa.carta.valor)
		print(f"Jogador {jogador.nome}, é sua vez!")
		print("Cartas:")
		for idx, carta in enumerate(jogador.cartas):
			print("  ", idx, carta.cor, carta.valor)
		print("Qual carta carta você deseja jogar?")
		opcao = int(input())
		jogada_valida = False
		while not jogada_valida:
			carta = jogador.cartas[opcao]
			jogada_valida = mesa.joga_carta(carta)
			if jogada_valida:
				del jogador.cartas[opcao]
			else:
				print('Jogada inválida')
				print()
				print("Qual carta carta você deseja jogar?")
				opcao = int(input())
		print()
		print()


