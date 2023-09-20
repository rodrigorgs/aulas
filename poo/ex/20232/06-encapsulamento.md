---
layout: triple-page
title: "Exercícios: Encapsulamento"
features: [code, python]
---

## Contador privado

A classe `Contador` permite contar quantas vezes um evento ocorreu. Para isso, ela possui um atributo `valor`, que é incrementado pelo método `incrementa` e pode ser consultado pelo método `quantidade`.

O problema é que o atributo `valor` pode ser alterado diretamente, sem passar pelo método `incrementa`. Isso pode levar a resultados inesperados, como o contador ser decrementado ou ter seu valor alterado diretamente.

Altere o código para tornar o atributo `valor` privado, indicando aos usuários da classe que ele não deve ser acessado diretamente.

<textarea class="code lang-python">
class Contador:
  def __init__(self) -> None:
    self.valor = 0
  def incrementa(self, qtd: int) -> None:
    if qtd > 0:
      self.valor += qtd
  def quantidade(self) -> int:
    return self.valor

</textarea>

<div class="testcode">
import unittest
class TestContador(unittest.TestCase):
  def test_contador_comeca_em_zero(self):
    c = Contador()
    self.assertEqual(c.quantidade(), 0)
  def test_incrementa_uma_vez(self):
    c = Contador()
    c.incrementa(3)
    self.assertEqual(c.quantidade(), 3)
  def test_incrementa_duas_vezes(self):
    c = Contador()
    c.incrementa(2)
    self.assertEqual(c.quantidade(), 2)
    c.incrementa(4)
    self.assertEqual(c.quantidade(), 6)
  def test_incrementa_numero_negativo(self):
    c = Contador()
    c.incrementa(5)
    c.incrementa(-2)
    self.assertEqual(c.quantidade(), 5)
  def test_nao_pode_acessar_atributo_valor(self):
    c = Contador()
    with self.assertRaises(AttributeError):
      c.valor
if __name__ == '__main__':
  import sys
  unittest.main(exit=False)
</div>

## Nome completo

Crie a classe `NomeCompleto`, com `nome`, `sobrenome` e `nome_completo` (todos strings), além dos métodos relevantes de acordo com a seguinte especificação:

- Um objeto do tipo `NomeCompleto` sempre é criado com um nome e um sobrenome
- O nome completo é a concatenação do nome e do sobrenome, separados por um espaço
- O nome completo não pode ser alterado diretamente, e sim através da alteração do nome ou do sobrenome

Veja exemplo de como a classe deve ser usada no código ao lado.

<textarea class="code lang-python">
class NomeCompleto:
  def __init__(self, nome: str, sobrenome: str) -> None:
    pass
</textarea>

<textarea class="stdin">
# code
n = NomeCompleto('João', 'Silva')
print(n.nome) # João
print(n.sobrenome) # Silva
print(n.nome_completo) # João Silva
n.nome = 'Maria'
n.sobrenome = 'Santos'
print(n.nome_completo) # Maria Santos
</textarea>

<div class="testcode">
import unittest
class TestNome(unittest.TestCase):
  def test_atributos(self):
    n = NomeCompleto('João', 'Silva')
    self.assertEqual(n.nome, 'João')
    self.assertEqual(n.sobrenome, 'Silva')
    self.assertEqual(n.nome_completo, 'João Silva')
  def test_altera_nome(self):
    n = NomeCompleto('João', 'Silva')
    n.nome = 'Fulano'
    n.sobrenome = 'de Tal'
    self.assertEqual(n.nome_completo, 'Fulano de Tal')
  def test_altera_nome_completo(self):
    n = NomeCompleto('Beltrana', 'Santos')
    with self.assertRaises(AttributeError):
      n.nome_completo = 'Fulano de Tal'

if __name__ == '__main__':
  import sys
  unittest.main(exit=False)
</div>

## Vende-se uma casa

A classe `Casa` representa uma casa à venda. Ao criar uma casa à venda, é criada uma placa informando o preço de venda. O preço de venda pode ser alterado, mas o endereço não. O problema é que, se altermos o preço de venda, a placa fica desatualizada. Altere o código para que, ao mudar o preço, a informação na placa seja atualizada automaticamente. Veja o código de exemplo ao lado.

<textarea class="code lang-python">
class Casa:
  def __init__(self, endereco: str, preco: int) -> None:
    self._endereco = endereco
    self._preco = preco
    self.placa = Placa(f'Vende-se. Preço: {preco}', 12)

  @property
  def endereco(self):
    return self._endereco

class Placa:
  def __init__(self, texto: str, tamanho: int) -> None:
    self.texto = texto
    self.tamanho = tamanho
  
  def imprime(self) -> None:
    print(f'[{self.texto}]')
</textarea>

<textarea class="stdin">
# code
casa = Casa('rua dos bobos, 0', 150123)
casa.placa.imprime() # Vende-se. Preço: 150123
casa.preco = 140100
casa.placa.imprime() # Vende-se. Preço: 140100
</textarea>

<div class="testcode">
import unittest
class TestCasa(unittest.TestCase):
  def test_casa_cria_placa_com_texto_correto(self):
    c = Casa('', 123)
    self.assertEqual(c.placa.texto, 'Vende-se. Preço: 123')
    c = Casa('', 456)
    self.assertEqual(c.placa.texto, 'Vende-se. Preço: 456')

  def test_preco_pode_ser_atualizado(self):
    c = Casa('', 123)
    c.preco = 456
    self.assertEqual(c.preco, 456)

  def test_ao_alterar_preco_placa_atualiza(self):
    c = Casa('', 789)
    self.assertEqual(c.placa.texto, 'Vende-se. Preço: 789')
    c.preco = 555
    self.assertEqual(c.placa.texto, 'Vende-se. Preço: 555')
  
  def test_nao_pode_alterar_endereco(self):
    c = Casa('rua dos bobos, 0', 123)
    with self.assertRaises(AttributeError):
      c.endereco = 'rua dos espertos, 1'
if __name__ == '__main__':
  import sys
  unittest.main(exit=False)
</div>

