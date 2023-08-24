---
layout: triple-page
title: "Exercícios: classes em Python"
features: [code, python]
---

## Construindo casas

Considere que, em algum ponto do programa, foi definida uma classe `Casa`. Modifique o código de forma a instanciar a classe e criar uma variável c1, que referencia o novo objeto.

**Atenção**: você **não** deve definir a classe `Casa`. Considere que ela já foi definida. Seu código deve apenas instanciar a classe e atribuir a instância à variável `c1`.

<textarea class="code lang-python">
c1 = None
</textarea>

<textarea class="stdin">
# code
print('c1 =', c1)
</textarea>

<div class="runtemplate">
class Casa:
  pass
[[[code]]]
</div>

<div class="testcode">
class Casa:
  pass
[[[code]]]
try:
  assert type(c1) == Casa, 'c1 deve referenciar um objeto da classe Casa'
except AssertionError as e:
  print('[ERRO]', e)
</div>

## Construindo prédios

Considere agora que **já foi definida** a classe `Predio`, cujo construtor recebe como parâmetro o número de andares do prédio. Escreva um código para construir um prédio de 5 andares, e o atribua à variável `p`.

**Atenção**: você **não** deve definir a classe `Predio`. Essa classe será definida pelo ambiente de desenvolvimento quando você executar o programa.

<textarea class="code lang-python">
</textarea>

<textarea class="stdin">
# code
print('p =', p)
</textarea>

<div class="runtemplate">
class Predio:
  def __init__(self, n):
    self.n = n
  def __repr__(self):
    return f'prédio de {self.n} andares'
[[[code]]]
</div>

<div class="testcode">
class Predio:
  def __init__(self, n):
    self.n = n
[[[code]]]
try:
  assert type(p) == Predio, 'p deve referenciar um objeto da classe Predio'
  assert p.n == 5, 'O prédio deve ter 5 andares'
except AssertionError as e:
  print('[ERRO]', e)
</div>

## Acelerando

Considere **já foi definida** a classe `Carro`, que possui o atributo `velocidade` e o método `acelerar`. O método `acelerar` recebe como parâmetro a quantidade de segundos durante a qual o carro será acelerado. Considere agora que **já foi definida** uma variável `fusca`, que referencia um objeto da classe `Carro`, representando um carro do modelo Fusca.

Escreva um código que acelera o Fusca por 5 segundos, guardando a velocidade inicial na variável `inicial`, e a velocidade final na variável `final`.

**Atenção**: você **não** deve definir a classe `Carro` e nem a variável `fusca`. O ambiente de desenvolvimento já definiu ambos para você.

<textarea class="code lang-python">
</textarea>

<textarea class="stdin">
# code
print('inicial =', inicial)
print('final =', final)
</textarea>

<div class="runtemplate">
import random
class Carro:
  def __init__(self, v, a):
    self.velocidade = v
    self.aceleracao = a
  def acelerar(self, s):
    self.velocidade += self.aceleracao * s

fusca = Carro(random.randrange(0, 50), random.randrange(1, 5))
[[[code]]]
</div>

<div class="testcode">
import random
class Carro:
  def __init__(self, v, a):
    self.velocidade = v
    self.aceleracao = a
    self.acelerou = False
  def acelerar(self, s):
    self.velocidade += self.aceleracao * s
    self.acelerou = True

fusca_inicial = random.randrange(0, 50)
fusca = Carro(fusca_inicial, random.randrange(1, 5))
[[[code]]]
try:
  assert inicial == fusca_inicial, 'Variável inicial incorreta'
  assert final == fusca_inicial + fusca.aceleracao * 5, 'Variável final incorreta'
  assert fusca.acelerou, 'O fusca precisa ser acelerado'  
except AssertionError as e:
  print('[ERRO]', e)
</div>

## Retângulo simples

Defina uma classe `Retangulo`, cujo construtor (`__init__`) recebe dois números e atribui o primeiro número ao atributo `base` do objeto e o segundo número ao atributo `altura`

<textarea class="code lang-python">
class Retangulo:
  '''Representa um retângulo, com base e altura'''

  def __init__(self, b, a):
    '''
    Altera base e altura para os
    valores fornecidos como parâmetro
    '''
</textarea>

<textarea class="stdin">
# code
r = Retagulo(3, 4)
print('Base: ', r.base)
print('Altura: ', r.altura)
</textarea>


<div class="testcode">
try:  
  r = Retangulo(23, 76)
  assert r.base == 23
  assert r.altura == 76
  r = Retangulo(99, 33)
  assert r.base == 99
  assert r.altura == 33
except AssertionError as e:
  print('[ERRO]', e)
</div>

</textarea>

## Área e perímetro

Copie aqui o código do exercício anterior e adicione dois métodos:

- `area`: retorna a área do retângulo
- `perimetro`: retorna o perímetro do retângulo

<textarea class="code lang-python">
</textarea>

<textarea class="stdin">
# code
ret = Retangulo(3, 3)
print('Área: ', ret.area())
print('Perímetro: ', ret.perimetro())
</textarea>

<div class="testcode">
try:
  r = Retangulo(4, 3)
  assert r.area() == 12
  assert r.perimetro() == 14
  r.base = 5
  assert r.area() == 15
  assert r.perimetro() == 16
except AssertionError as e:
  print('[ERRO]', e)
</div>

## Aumentar retângulo

Implemente o método `aumenta` conforme a documentação. Consulte os testes para ver um exemplo de como o método é chamado e qual o resultado esperado.

<textarea class="code lang-python">
class Retangulo:
  def __init__(self, base, altura):
    self.base = base
    self.altura = altura
  def aumenta(self, outro):
    '''
    Redimensiona este retângulo, cujas dimensões
    passam a ser a soma das suas dimensões originais
    com as dimensões de outro retângulo, passado
    como parâmetro
    '''

    
</textarea>

<textarea class="stdin">
# code
r1 = Retangulo(2, 3)
r2 = Retangulo(1, 2)
r1.aumenta(r2)
print('Base: ', r1.base) # 3
print('Altura: ', r1.altura) # 5
</textarea>

<div class="testcode">
try:
  r1 = Retangulo(4, 5)
  r2 = Retangulo(1, 2)
  r1.aumenta(r2)
  assert r1.base == 5 and r1.altura == 7
  assert r2.base == 1 and r2.altura == 2
except AssertionError as e:
  print('[ERRO]', e)
</div>

## Soma de retângulos

Implemente o método `mais` conforme a documentação. Consulte os testes para ver um exemplo de como o método é chamado e qual o resultado esperado. Note que o método `mais` não deve alterar o retângulo atual, e sim criar um novo retângulo.

<textarea class="code lang-python">
class Retangulo:
  def __init__(self, base, altura):
    self.base = base
    self.altura = altura
  def mais(self, outro):
    '''
    Retorna um novo retângulo, cujas dimensões são
    a soma das dimensões deste retângulo com as
    dimensões de outro retângulo, passado como
    parâmetro
    '''

</textarea>

<textarea class="stdin">
# code
r1 = Retangulo(2, 3)
r2 = Retangulo(1, 2)
r = r1.mais(r2)
print('Base: ', r.base) # 3
print('Altura: ', r.altura) # 5
</textarea>


<div class="testcode">
try:
  r1 = Retangulo(4, 5)
  r2 = Retangulo(1, 2)
  r3 = r1.mais(r2)
  assert r1.base == 4 and r1.altura == 5
  assert r2.base == 1 and r2.altura == 2
  assert r3.base == 5 and r3.altura == 7
except AssertionError as e:
  print('[ERRO]', e)
</div>

## Conta bancária

Crie uma classe `Conta` para representar uma conta bancária.

Toda conta possui um código (string) que a identifica e um saldo (número).

Ao criar uma conta, deve-se sempre informar o código e, opcionalmente, o saldo; se o saldo não for informado, ele deve ser zero.

Ao movimentar dinheiro na conta, o saldo nunca deve ficar negativo.

+ Considere que a classe deve possuir as seguintes propriedades:
  - `codigo`
  - `saldo`

Complete a implementação da classe.

<textarea class="code lang-python">
class Conta:
  '''ATENÇÃO: Crie o construtor da classe'''

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



</textarea>

<textarea class="stdin">
# code
c = Conta('123')
c.deposita(50.0)
print(c.retira(20.0)) # True
print(c.saldo) # 30.0

outra = Conta('456')
print(c.transfere(30.0, outra)) # True
print(c.saldo) # 0.0
print(outra.saldo) # 30.0
</textarea>


<div class="testcode">
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
</div>

