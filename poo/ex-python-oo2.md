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

  def test_nao_pode_alterar_codigo(self):
    c = Conta('123', 50.0)
    self.assertRaises(AttributeError, lambda: (c.codigo := '456'))

  def test_nao_pode_alterar_saldo(self):
    c = Conta('123', 50.0)
    self.assertRaises(AttributeError, lambda: (c.saldo := 999.99))

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

## Aluno

Crie a classe `Aluno`, com as propriedades `matricula` e `nome` (ambas strings), além dos métodos relevantes de acordo com a seguinte especificação:

- O nome do aluno pode ser alterado, mas nunca o seu número de matrícula
- Duas instâncias de `Aluno` são consideradas iguais se possuem o mesmo número
de matrícula

Assuma, para este exercício, que a classe `Aluno` sempre será instanciada com um
número de matrícula e um nome válidos, passados nessa ordem.

<textarea class="code lang-python">
class Aluno:
  pass

### Testes
import unittest
class TestAluno(unittest.TestCase):
  def test_iguais(self):
    a = Aluno('123', 'abc')
    b = Aluno('123', 'abc')
    self.assertEqual(a, b)
  
  def test_mesma_matricula_nome_diferente(self):
    a = Aluno('123', 'abc')
    b = Aluno('123', 'def')
    self.assertEqual(a, b)
  
  def test_diferentes(self):
    a = Aluno('123', 'abc')
    b = Aluno('124', 'abc')
    self.assertNotEqual(a, b)

  def test_pode_mudar_nome(self):
    a = Aluno('123', 'abc')
    a.nome = 'def'
    self.assertEqual(a.nome, 'def')
  
  def test_nao_pode_mudar_nome(self):
    a = Aluno('123', 'abc')
    self.assertRaises(AttributeError, lambda: (a.matricula := '456'))

if __name__ == '__main__':
  import sys
  unittest.main(exit=False)
</textarea>

<!--

## Rede social

<!!!textarea class="code lang-python">
class Usuario:
  def __init__(self, nome):
    pass

class Grupo:
  '''Grupo de usuários na rede social.
  Um grupo possui um nome e um conjunto de membros.
  Além disso, ele possui exatamente um dono, que é um membro.
  Um grupo não pode estar vazio.
  '''
  def __init__(self, nome, dono):
    self.nome = nome
    self._dono = dono
    self._membros = set(dono)

  def adiciona(self, usuario):
    '''Adiciona usuário como membro do grupo'''
    pass
  
  def remove(self, usuario):
    '''Remove um usuário do grupo, se possível.
    Em alguns casos NÃO é possível remover o usuário do grupo:
    * Se o usuário é o único membro do grupo
    * Se o usuário é dono do grupo
    * Se o usuário não pertence ao grupo
    :return: `True` se o usuário foi removido ou `False` caso contrário
    '''
    pass

  def altera_dono(self, novo_dono):
    '''Destitui o dono atual e elege um novo dono.
    O dono deve ser membro do grupo.
    Retorna `True` se o usuário informado é o novo dono
    ou `False` caso contrário.
    '''
    pass

  def contem_membro(self, usuario):
    '''Indica se um usuário faz parte do grupo'''
    pass

  def membros(self):
    '''Retorna uma cópia da lista de membros'''
    pass

  def tamanho(self):
    '''Retorna quantidade de membros'''
    pass

### Testes
import unittest
class TestAluno(unittest.TestCase):
  pass
  # TODO

if __name__ == '__main__':
  import sys
  unittest.main(exit=False)
</textarea>
-->