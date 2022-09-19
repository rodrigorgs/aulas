---
layout: triple-page
title: "Exercícios: enums"
features: [code, python]
---

## Cores e componentes

Uma cor é formada por três componentes (`r`, `g` e `b`, ou vermelho, verde e azul), variando de 0 a 255, e é representada pela classe `Cor`. 

Crie a enumeração `Componente`, tendo como membros `RED`, `GREEN` e `BLUE`, e então implemente o método `altera` da classe `Cor`, que altera um dos componentes da cor atual.

<textarea class="code lang-python">
from enum import Enum

class Componente:
  pass

class Cor:
  def __init__(self, r, g, b):
    self.r = r
    self.g = g
    self.b = b
  
  def altera(self, componente, valor):
    pass

  def __eq__(self, o):
    return self.r == o.r and self.g == o.g and self.b == o.b

### Testes
c = Cor(1, 2, 3)
c.altera(Componente.RED, 128)
assert c.r == 128 and c.g == 2 and c.b == 3

c = Cor(1, 2, 3)
c.altera(Componente.GREEN, 100)
assert c.r == 1 and c.g == 100 and c.b == 3

c = Cor(1, 2, 3)
c.altera(Componente.BLUE, 255)
assert c.r == 1 and c.g == 2 and c.b == 255

assert isinstance(Componente.RED, Enum)
</textarea>

## Status do Pedido

Quando um cliente realiza um pedido em uma loja, o pedido passa por uma série de situações (status) até ser entregue ao cliente. Inicialmente o pedido possui o status `RECEBIDO`. Então, o cliente informa uma forma de pagamento e efetua o pagamento; o pedido passa para o status `PAGO`. A partir daí o produto é recolhido pela transportadora e passa para o status `ENVIADO`. Por fim, o produto chega ao cliente e adquire o status `ENTREGUE`.

Complete o código:

- Implemente a enumeração `Status`, tendo como membro os status apresentados anteriormente.
- Adicione um atributo `status` a `Pedido` e implemente a lógica dos métodos `pagar`, `enviar` e `entregar`
- Implemente o método `situacao()`, que retorna o status do pedido como string, em letras minúsculas (podendo ser `recebido`, `pago`, `enviado` ou `entregue`).

<textarea class="code lang-python">
from enum import Enum

class Status:
  pass

class Pedido:
  def __init__(self, valor=0.0):
    self.valor = valor

  def pagar(self, forma_de_pagamento):
    pass
  
  def enviar(self, transportadora):
    pass
  
  def entregar(self):
    pass
  
  def situacao(self):
    return ''

### Testes
import unittest

class TestPedido(unittest.TestCase):
  def test_pedido_novo(self):
    p = Pedido()
    self.assertEqual(p.status, Status.RECEBIDO)
  
  def test_pedido_pago(self):
    p = Pedido()
    p.pagar('pix')
    self.assertEqual(p.status, Status.PAGO)

  def test_pedido_enviado(self):
    p = Pedido()
    p.enviar('ufbalog')
    self.assertEqual(p.status, Status.RECEBIDO)
    p.pagar('pix')
    p.enviar('ufbalog')
    self.assertEqual(p.status, Status.ENVIADO)

  def test_pedido_entregue(self):
    p = Pedido()
    p.entregar()
    self.assertEqual(p.status, Status.RECEBIDO)
    p.pagar('pix')
    p.entregar()
    self.assertEqual(p.status, Status.PAGO)
    p.enviar('ufbalog')
    p.entregar()
    self.assertEqual(p.status, Status.ENTREGUE)

  def test_situacao(self):
    p = Pedido()
    self.assertEqual(p.situacao(), 'recebido')
    p.pagar('pix')
    self.assertEqual(p.situacao(), 'pago')
    p.enviar('ufbalog')
    self.assertEqual(p.situacao(), 'enviado')
    p.entregar()
    self.assertEqual(p.situacao(), 'entregue')

  def test_enum(self):
    self.assertTrue(isinstance(Status.RECEBIDO, Status))
    self.assertTrue(isinstance(Status.RECEBIDO, Enum))

if __name__ == '__main__':
  import sys
  unittest.main(exit=False)
</textarea>
