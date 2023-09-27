---
layout: triple-page
title: "Exercícios: sobrecarga de operadores em Python"
features: [code, python]
---

## Pessoa e strings

Complete a implementação da classe `Pessoa` para que, quando uma instância da classe for impressa com `print`, apareça o nome da pessoa, seguido de um espaço, seguido do CPF entre parênteses. Exemplo: `Fulano (11111111111)`.

<textarea class="code lang-python">
class Pessoa:
  def __init__(self, cpf, nome):
    self.cpf = cpf
    self.nome = nome
</textarea>

<textarea class="stdin">
# code
p = Pessoa('123', 'Fulano')
print(p)
</textarea>

<div class="testcode">
import unittest

class TestPessoa(unittest.TestCase):
  def setUp(self):
    self.p1 = Pessoa('111', 'Fulano')
    self.p2 = Pessoa('222', 'Sicrana')

  def test_string(self):
    self.assertEqual(str(self.p1), 'Fulano (111)')
    self.assertEqual(str(self.p2), 'Sicrana (222)')

if __name__ == '__main__':
  import sys
  unittest.main(exit=False)
</div>

## Pessoa e igualdade

Complete a implementação da classe `Pessoa` para permitir comparação de igualdade. Considere que duas pessoas são iguais se e somente se possuem o mesmo CPF.

Considere, ainda, que um objeto do tipo Pessoa é diferente de qualquer objeto que não é do tipo Pessoa.

<textarea class="code lang-python">
class Pessoa:
  def __init__(self, cpf, nome):
    self.cpf = cpf
    self.nome = nome
</textarea>

<textarea class="stdin">
# code
p1 = Pessoa('123', 'Fulana')
p2 = Pessoa('123', 'Sicrano')
print(p1 == p2)
</textarea>

<div class="testcode">
import unittest

class TestPessoa(unittest.TestCase):
  def setUp(self):
    self.p1 = Pessoa('111', 'Fulano')
    self.p1x = Pessoa('111', 'Fulanovski')
    self.p2 = Pessoa('222', 'Sicrana')
    self.p3 = Pessoa('333', 'Fulano')

  def test_pessoas_iguais(self):
    self.assertEqual(self.p1, self.p1)
    self.assertEqual(self.p1, self.p1x)
  
  def test_pessoas_diferentes(self):
    self.assertNotEqual(self.p1, self.p2)
    self.assertNotEqual(self.p1, self.p3)

  def test_compara_com_objeto_de_outro_tipo(self):
    self.assertNotEqual(self.p1, 'Fulano')
    self.assertNotEqual(self.p1, None)

if __name__ == '__main__':
  import sys
  unittest.main(exit=False)
</div>

## Conjunto de pessoas

Com base na questão anterior, complete a implementação da classe `Pessoa` para permitir que suas instâncias sejam inseridas em conjuntos (sets). Lembre-se que pessoas são identificadas unicamente por seu CPF, ou seja, não pode haver duas instâncias com o mesmo CPF dentro de um conjunto.

<textarea class="code lang-python">
class Pessoa:
  def __init__(self, cpf, nome):
    self.cpf = cpf
    self.nome = nome
</textarea>

<textarea class="stdin">
# code
p1 = Pessoa('123', 'Fulana')
p2 = Pessoa('123', 'Sicrano')
alunos = set()
alunos.add(p1)
alunos.add(p2)
print(p1)
</textarea>


<div class="testcode">
import unittest

class PessoaTest(unittest.TestCase):
  def test_conjunto_de_pessoas_com_repeticao(self):
    p1 = Pessoa('111', 'Fulano')
    p1x = Pessoa('111', 'Fulanovski')
    p3 = Pessoa('333', 'Fulano')
    s = set()
    s.add(p1)
    s.add(p1x)
    s.add(p3)
    self.assertEqual(len(s), 2)

if __name__ == '__main__':
  import sys
  unittest.main(exit=False)
</div>

## Frações

Complete a implementação da classe `Fracao`, que representa uma fração. Deve ser possível determinar se duas frações são equivalentes (usando o operador `==`) e ordenar frações pelo seu valor decimal (através do operador de comparação `<`). A fração deve ser representada como string no formato `numerador/denominador`; exemplos: `1/2`, `2/3`.

<textarea class="code lang-python">
class Fracao:
    def __init__(self, numerador, denominador):
        self.numerador = numerador
        self.denominador = denominador
    
    @property
    def valor_decimal(self):
        return self.numerador / self.denominador
    
</textarea>

<textarea class="stdin">
# code
f1 = Fracao(1, 2)
f2 = Fracao(3, 6)
f3 = Fracao(1, 3)
print(f1 == f2)
print(f3 < f2)
</textarea>

<div class="testcode">
import unittest
class FracaoTest(unittest.TestCase):
  def setUp(self):
    self.f1_2 = Fracao(1, 2)
    self.f3_6 = Fracao(3, 6)
    self.f3_4 = Fracao(3, 4)
  
  def test_fracoes_iguais(self):
    self.assertEqual(self.f1_2, self.f3_6)
  
  def test_fracoes_diferentes(self):
    self.assertNotEqual(self.f3_6, self.f3_4)
  
  def test_representacao_string(self):
    self.assertEqual(str(self.f1_2), '1/2')
    self.assertEqual(str(self.f3_6), '3/6')
  
  def test_ordenacao(self):
    l = [self.f1_2, self.f3_4, self.f3_6]
    self.assertEqual(sorted(l)[2], self.f3_4)

if __name__ == '__main__':
  import sys
  unittest.main(exit=False)
</div>

<!-- 
    def __eq__(self, o):
        if isinstance(o, Fracao):
            x = self.numerador * o.denominador
            y = self.denominador * o.numerador
            return x == y
        return False

    def __str__(self):
        return str(self.numerador) + '/' + str(self.denominador)

    def __lt__(self, o):
        return self.valor_decimal < o.valor_decimal
 -->