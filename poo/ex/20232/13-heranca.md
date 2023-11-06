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
</textarea>

<textarea class="stdin">
# code
c = ContaPoupanca('555', 50.0)
c.rende()
print(c.saldo)
</textarea>

<div class="testcode">
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
</div>

## Conta auditada

Considere a classe `Conta` ao lado. Crie uma subclasse, `ContaAuditada`, que registra a quantidade de operações de depósito e retirada que recebeu (atributos `qtd_depositos` e `qtd_retiradas`). Implemente também o método `quantidade_operacoes()`, que retorna o total de operações. Não copie e cole código da classe `Conta` para a classe `ContaAuditada`.

OBS.: Deve-se contabilizar também as tentativas de retirada que não foram efetivadas por falta de saldo.

<textarea class="code lang-python">
class Conta:
  def __init__(self):
    self.saldo = 0

  def deposita(self, quantia):
    self.saldo += quantia

  def retira(self, quantia):
    if self.saldo >= quantia:
      self.saldo -= quantia
</textarea>

<textarea class="stdin">
# code
c = ContaAuditada()
c.deposita(20)
c.deposita(5)
c.retira(3)
print(c.qtd_depositos)
print(c.qtd_retiradas)
print(c.quantidade_operacoes())
</textarea>

<div class="testcode">
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
</div>
