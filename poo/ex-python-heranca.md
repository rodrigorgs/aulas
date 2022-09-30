---
layout: triple-page
title: "Exercícios: herança"
features: [code, python]
---

## Conta poupança

Crie uma classe `ContaPoupanca`, que estende a classe `Conta` e adiciona o método `rende()`, que aumenta o saldo em 1%.

<textarea class="code lang-python">
class Conta:
  def __init__(self, numero, saldo):
    self.numero = numero
    self.saldo = saldo
  
  def deposita(self, quantia):
    self.saldo += quantia

### Testes
import unittest
from unittest import mock

class TestConta(unittest.TestCase):
  def test_instanciar_conta_poupanca(self):
    c = ContaPoupanca('123', 100.0)
    self.assertEqual(c.numero, '123')
    self.assertEqual(c.saldo, 100.0)
  
  def test_conta_normal_nao_rende(self):
    c = Conta('123', 123)
    self.assertFalse(hasattr(c, 'rende'))

  def test_conta_poupanca_rende(self):
    c = ContaPoupanca('123', 200.0)
    c.rende()
    self.assertEqual(c.saldo, 202.0)

  @mock.patch('__main__.Conta.__init__')
  def test_herda_init(self, mock_super_init):
    mock_super_init.return_value = None
    c = ContaPoupanca('123', 200.0)
    self.assertTrue(mock_super_init.called)

  @mock.patch('__main__.Conta.deposita')
  def test_herda_deposita(self, mock_super_deposita):
    c = ContaPoupanca('123', 200.0)
    c.deposita(1)
    self.assertTrue(mock_super_deposita.called)

if __name__ == '__main__':
  import sys
  unittest.main(exit=False)
</textarea>

## Robô aspirador

Uma empresa fabrica robôs aspiradores para consumidores domésticos. São três os robôs:

- robô básico: move-se em quatro direções (frente, trás, esquerda e direita)
- robô plus: além de mover-se em quatro direções, possui a função `explora`, que é uma programação que faz o robô mover-se em quadrados (frente, direita, trás, esquerda)
- robô smart: além de mover-se em quatro direções, possui a função `retorna_a_base`, que posiciona o robô na posição da base (definida na inicialização do robô)

O código do robô básico já está implementado. Implemente os outros dois robôs, usando o recurso de herança. Consulte os testes em caso de dúvida.

<textarea class="code lang-python">
class RoboBasico:
  DIRECOES = {'frente': (0, -1), 'tras': (0, 1),
      'esquerda': (-1, 0), 'direita': (1, 0)}
  def __init__(self, x, y):
    self.x = x
    self.y = y

  def move(self, direcao):
    dx, dy = RoboBasico.DIRECOES[direcao]
    self.x += dx
    self.y += dy

### Testes
import unittest
from unittest import mock

def declared_methods(klass):
  return list(filter(lambda x: x[0:2] != '__', klass.__dict__.keys()))

class TestRobo(unittest.TestCase):
  def test_heranca(self):
    self.assertTrue(issubclass(RoboSmart, RoboBasico))
    self.assertTrue(issubclass(RoboPlus, RoboBasico))
  
  def test_metodos_declarados(self):
    self.assertEqual(declared_methods(RoboSmart), ['retorna_a_base'])
    self.assertEqual(declared_methods(RoboPlus), ['explora'])

  @mock.patch('__main__.RoboBasico.move')
  def test_robo_plus(self, mock_move):
    r = RoboPlus(5, 5)
    r.explora()
    mock_move.assert_any_call('frente')
    mock_move.assert_any_call('tras')
    mock_move.assert_any_call('esquerda')
    mock_move.assert_any_call('direita')
  
  def test_robo_smart(self):
    r = RoboSmart(5, 5, 1, 2)
    r.retorna_a_base()
    self.assertEqual(r.x, 1)
    self.assertEqual(r.y, 2)
    r = RoboSmart(5, 5, 2, 3)
    r.retorna_a_base()
    self.assertEqual(r.x, 2)
    self.assertEqual(r.y, 3)


if __name__ == '__main__':
  import sys
  unittest.main(exit=False)
</textarea>

## Conta Auditada

Considere a classe `Conta` ao lado. Crie uma subclasse, `ContaAuditada`, que registra a quantidade de operações de depósito e retirada que recebeu (atributos `qtd_depositos` e `qtd_retiradas`). Implemente também o método `quantidade_operacoes()`, que retorna o total de operações. Não copie e cole código da classe `Conta` para a classe `ContaAuditada`.

<textarea class="code lang-python">
class Conta:
  def __init__(self):
    self.saldo = 0

  def deposita(self, quantia):
    self.saldo += quantia

  def retira(self, quantia):
    if self.saldo >= quantia:
      self.saldo -= quantia

### Testes
import unittest
from unittest import mock

class TestContaAuditada(unittest.TestCase):
  def test_heranca(self):
    self.assertTrue(issubclass(ContaAuditada, Conta))
  
  @mock.patch('__main__.Conta.__init__')
  @mock.patch('__main__.Conta.deposita')
  @mock.patch('__main__.Conta.retira')
  def test_auditoria(self, retira, deposita, init):
    init.return_value = None
    c = ContaAuditada()
    init.assert_called()
    c.deposita(5)
    deposita.assert_called_with(5)
    c.deposita(3)
    deposita.assert_called_with(3)
    c.retira(2)
    retira.assert_called_with(2)
    c.retira(1)
    retira.assert_called_with(1)
    c.retira(3)
    retira.assert_called_with(3)
    self.assertEqual(c.quantidade_operacoes(), 5)
    self.assertEqual(c.qtd_depositos, 2)
    self.assertEqual(c.qtd_retiradas, 3)

if __name__ == '__main__':
  import sys
  unittest.main(exit=False)
</textarea>
