---
layout: triple-page
title: "Exercícios: membros estáticos"
features: [code, python]
---

## Cores

Uma cor é formada por três componentes (`r`, `g` e `b`, ou vermelho, verde e azul), variando de 0 a 255, e é representada pela classe `Cor`. Como conveniência para os clientes da classe, crie uma classe `Paleta` com atributos estáticos representando as seguintes cores:

- `AZUL`: (0, 0, 255)
- `VERMELHA`: (255, 0, 0)
- `AMARELA`: (255, 255, 0)

<textarea class="code lang-python">
class Paleta:
  pass

class Cor:
  def __init__(self, r, g, b):
    self.r = r
    self.g = g
    self.b = b
  
  def __eq__(self, o):
    return self.r == o.r and self.g == o.g and self.b == o.b

### Testes

assert Paleta.AZUL.b == 255 and Paleta.AZUL.r == 0 and Paleta.AZUL.g == 0
assert Paleta.VERMELHA == Paleta(255, 0, 0)
assert Paleta.AMARELA == Paleta(255, 255, 0)
</textarea>

## Vetor

Um vetor em duas dimensões é um segmento de reta orientado, que pode ser representado por duas coordenadas, `x` e `y`. Um vetor também pode ser determinado por um ângulo (θ) e um tamanho (t), através das seguintes relações:

- x = t * cos(θ)
- y = t * sen(θ)

A classe `Vetor` representa um vetor com coordenadas `x` e `y`. Para conveniência dos clientes da classe, crie os seguintes métodos estáticos:

- `comAnguloETamanho(θ, t)`: retorna um novo vetor, com ângulo `θ` (em radianos) e tamanho `t`
- `vertical(t)`: retorna um vetor sobre o eixo y com tamanho `t`
- `horizontal(t)`: retorna um vetor sobre o eixo x com tamanho `t`

<textarea class="code lang-python">
import math

class Vetor:
  def __init__(self, x, y):
    self.x = x
    self.y = y
  
  def __eq__(self, o):
    return math.abs(self.x - o.x) < 0.001 and math.abs(self.y - o.y) < 0.001

assert Vetor.comAnguloETamanho(math.pi / 3, 10) == Vetor(5, 8.66025)
assert Vetor.comAnguloETamanho(math.pi, 10) == Vetor.horizontal(-10)
assert Vetor.vertical(5) == Vetor(0, 5)
assert Vetor.horizontal(-3) == Vetor(-3, 0)
</textarea>

## Pedido

Quando um cliente realiza um pedido em uma loja, o pedido passa por uma série de situações (status) até ser entregue ao cliente. Inicialmente o pedido possui o status `RECEBIDO`. Então, o cliente informa uma forma de pagamento e efetua o pagamento; o pedido passa para o status `PAGO`. A partir daí o produto é recolhido pela transportadora e passa para o status `ENVIADO`. Por fim, o produto chega ao cliente e adquire o status `ENTREGUE`.

A classe `Pedido` representa o valor e o status de um pedido. O status é representado por um número inteiro, de acordo com a seguinte lista:

- `RECEBIDO`: 0
- `PAGO`: 1
- `ENVIADO`: 2
- `ENTREGUE`: 3

Crie atributos estáticos representando os status e então implemente os métodos da classe `Pedido` de forma a alterar o status. Considere que um produto só pode ser pago se for recebido, só pode ser enviado se tiver sido pago, e só pode ter sido entregue se foi enviado.

<textarea class="code lang-python">
class Pedido:
  def __init__(self, valor):
    self.valor = valor
    self.status = 0

  def pagar(self, forma_de_pagamento):
    pass
  
  def enviar(self, transportadora):
    pass
  
  def entregar(self):
    pass

### Testes
import unittest

class TestPedido(unittest.TestCase):
  def test_pedido_novo(self):
    p = Pedido()
    self.assertEqual(p.status, Pedido.RECEBIDO)
  
  def test_pedido_pago(self):
    p = Pedido()
    p.pagar('pix')
    self.assertEqual(p.status, Pedido.PAGO)

  def test_pedido_enviado(self):
    p = Pedido()
    p.enviar('ufbalog')
    self.assertEqual(p.status, Pedido.RECEBIDO)
    p.pagar('pix')
    p.enviar('ufbalog')
    self.assertEqual(p.status, Pedido.ENVIADO)

  def test_pedido_entregue(self):
    p = Pedido()
    p.entregar()
    self.assertEqual(p.status, Pedido.RECEBIDO)
    p.pagar('pix')
    p.entregar()
    self.assertEqual(p.status, Pedido.PAGO)
    p.enviar('ufbalog')
    p.entregar()
    self.assertEqual(p.status, Pedido.ENTREGUE)

  def test_codigos_numericos(self):
    self.assertEqual(Pedido.RECEBIDO, 0)
    self.assertEqual(Pedido.PAGO, 1)
    self.assertEqual(Pedido.ENVIADO, 2)
    self.assertEqual(Pedido.ENTREGUE, 3)

if __name__ == '__main__':
  import sys
  unittest.main(exit=False)
</textarea>
