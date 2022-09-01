---
layout: triple-page
title: "Exercícios: classes em Python (2)"
features: [code, python]
---

## Conta bancária

Crie uma classe `Conta` para representar uma conta bancária.

Toda conta possui um código (string) que a identifica e um saldo (número).

Ao criar uma conta, deve-se sempre informar o código e, opcionalmente, o saldo; se o saldo não for informado, ele deve ser zero.

Ao movimentar dinheiro na conta, o saldo nunca deve ficar negativo.

+ Considere que a classe deve possuir as seguintes propriedades, que não podem ser alteradas diretamente após a criação da conta:
  - `codigo`
  - `saldo` (pode ser alterado através dos métodos `retira`, `deposita` e `transfere`)

Complete a implementação da classe.

<textarea class="code lang-python">
class Conta:  
  def deposita(self, quantia):
    '''
    Adiciona a quantia ao saldo da conta.
    :param quantia: quantia a ser depositada
    '''
  
  def retira(self, quantia):
    '''
    Subtrai a quantia do saldo da conta, a menos que o saldo seja insuficiente
    (isto é, menor que a quantia).
    :param quantia: quantia a ser retirada
    :return: `True` se a quantia foi retirada, `False` caso contrário
    '''
  
  def transfere(self, quantia, beneficiario):
    '''
    Transfere a quantia da conta atual para a conta do beneficiário,
    a menos que o saldo da conta atual seja insuficiente (ou ainda se
    o parâmetro `beneficiario` for `None`). 
    :param quantia: quantia a ser retirada
    :param beneficiario: conta do beneficiário
    :return: `True` se a transferência foi realizada, `False` caso contrário
    '''

### Testes
import unittest
class TestConta(unittest.TestCase):
  def test_cria_conta_sem_informar_saldo(self):
    c = Conta('123')
    self.assertEqual(c.codigo, '123')
    self.assertEqual(c.saldo, 0)
  
  def test_cria_conta_com_saldo(self):
    c = Conta('123', 50)
    self.assertEqual(c.saldo, 50)
  
  def test_retira_com_saldo_suficiente(self):
    c = Conta('123', 100.0)
    self.assertTrue(c.retira(40.0))
    self.assertAlmostEqual(c.saldo, 60.0)
  
  def test_retira_com_saldo_insuficiente(self):
    c = Conta('123', 30.0)
    self.assertFalse(c.retira(40.0))
    self.assertAlmostEqual(c.saldo, 30.0)

  def test_deposita(self):
    c = Conta('123', 50.0)
    c.deposita(40.0)
    c.deposita(10.5)
    self.assertAlmostEqual(c.saldo, 100.5)
  
  def test_transfere_com_saldo_suficiente(self):
    conta = Conta("123", 50.0)
    beneficiario = Conta("999", 10.0)
    
    self.assertTrue(conta.transfere(30.0, beneficiario))
    self.assertAlmostEqual(40.0, beneficiario.saldo)
    self.assertAlmostEqual(20.0, conta.saldo)

  def test_transfere_com_saldo_insuficiente(self):
    conta = Conta("123", 5.0)
    beneficiario = Conta("999", 10.0)
    
    self.assertFalse(conta.transfere(30.0, beneficiario))
    self.assertAlmostEqual(10.0, beneficiario.saldo)
    self.assertAlmostEqual(5.0, conta.saldo)

  
  def test_transfere_para_beneficiario_inexistente(self):
    conta = Conta("123", 5.0)
    beneficiario = None
    
    self.assertFalse(conta.transfere(2.0, beneficiario))
    self.assertAlmostEqual(5.0, conta.saldo)

if __name__ == '__main__':
  import sys
  unittest.main(exit=False)

</textarea>