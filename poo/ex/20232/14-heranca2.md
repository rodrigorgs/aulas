---
layout: triple-page
title: "Exercícios: herança - parte 2"
features: [code, python]
---

## Usuário

O programa ao lado representa usuários de uma universidade pública federal, que podem ser alunos ou servidores (que inclui docentes e servidores técnico-administrativos). Do jeito que foi implementado, no entanto, é possível instanciar objetos da classe `Usuario`, o que não faz sentido, já que todos os usuários são alunos ou servidores.

Modifique o código para que a classe `Usuario` não possa ser instanciada, mas possa ser estendida, usando o conceito de classes abstratas.

<textarea class="code lang-python">
class Usuario:
  def __init__(self, matricula: str, nome):
    self._matricula = matricula
    self._nome = nome
  
  def valida(self):
    pass
  
  def nome_normalizado(self):
    return self._nome.title()

class Aluno(Usuario):
  def valida(self):
    return len(self._matricula) == 9 and all(c.isdigit() for c in self._matricula)

class Servidor(Usuario):
  def valida(self):
    return len(self._matricula) == 7 and all(c.isdigit() for c in self._matricula)
</textarea>

<textarea class="stdin">
# code
# O código abaixo deve
# dar erro, pois não deve
# ser possível instanciar
# usuário.
x = Usuario('123', 'ABC')
print(x.valida())
</textarea>

<div class="testcode">
### Testes
import unittest
from unittest import mock

class TestUsuario(unittest.TestCase):
  def test_validar_aluno(self):
    a = Aluno('200310593', 'Rodrigo')
    self.assertTrue(a.valida())
  
  def test_validar_servidor(self):
    s = Servidor('1973264', 'Rodrigo')
    self.assertTrue(s.valida())
  
  def test_nao_pode_instanciar_usuario(self):
    try:
      u = Usuario('123123', 'ABC')
      self.fail()
    except TypeError:
      pass

  def test_nova_classe_derivada(self):
    class AAA(Usuario):
        def __init__(self):
            pass
    try:
      u = AAA()
      self.fail()
    except TypeError:
      pass

if __name__ == '__main__':
  import sys
  unittest.main(exit=False)
</div>

<!--
## Transportadora

Uma empresa transportadora é especializada em transportar geladeiras, e cobra frete de acordo com a distância percorrida e o tamanho da geladeira, conforme código ao lado.

Agora, a empresa expandir os seus negócios e transportar também máquinas de lavar roupa. Altere o código, de forma a permitir que a empresa transporte máquinas de lavar, **sem alterar as classes Geladeiras e Lavadora**.

Para isso, altere o tipo do parâmetro `item` para `Caixa`, e crie as estruturas necessárias para que o código atual do método continue funcionando.

<textarea class="code lang-python">
from typing import Protocol, runtime_checkable

@runtime_checkable
class Caixa(Protocol):
  def volume(self):
    pass

class Geladeira:
  def __init__(self, inverse: bool, frost_free: bool, largura: float, altura: float, comprimento: float) -> None:
    self.inverse = inverse
    self.frost_free = frost_free
    self.largura = largura
    self.altura = altura
    self.comprimento = comprimento
  
  def volume(self):
    return self.largura * self.altura * self.comprimento

class Lavadora:
  def __init__(self, litros: int, largura: float, altura: float, comprimento: float) -> None:
    self.litros = litros
    self.largura = largura
    self.altura = altura
    self.comprimento = comprimento

  def volume(self):
    return self.largura * self.altura * self.comprimento


class Frete:
  def __init__(self, distancia: float) -> None:
    self.distancia = distancia
  
  def valor(self, item: Caixa) -> float:
    return self.distancia * item.volume() * 0.01
</textarea>

<textarea class="stdin">
# code
gel = Geladeira(True, True, 0.80, 1.80, 0.80)
lav = Lavadora(10, 1, 0.80, 1.20)
f = Frete(100)
print(f.valor(gel))
print(f.valor(lav))
</textarea>

<div class="testcode">
### Testes
import unittest
from unittest import mock

class TestFrete(unittest.TestCase):
  #def test_frete_geladeira(self):
  #  gel = Geladeira(True, True, 0.80, 1.80, 0.80)
  #  f = Frete(100)
  #  self.assertTrue(abs(f.valor(gel) - 1152.0) &lt; 0.01)
  
  def test_tipo_de_item_eh_caixa(self):
    self.assertEqual(Frete.valor.__annotations__['item'], Caixa)
  
  def test_geladeira_e_lavadora_nao_tem_superclasse(self):
    self.assertFalse(issubclass(Geladeira, Caixa))
    self.assertFalse(issubclass(Lavadora, Caixa))

  def test_protocol_caixa_define_metodo_volume(self):
    self.assertTrue(hasattr(Caixa, 'volume'))

if __name__ == '__main__':
  import sys
  unittest.main(exit=False)
</div>
-->

## Guerreiro e contador: herança vs. composição

Em um jogo de estratégia em tempo real, o jogador controla guerreiros, que atacam outros guerreiros até tirar-lhes a vida. A classe `Contador` implementa um contador regressivo. O guerreiro possui uma vida que vai diminuindo à medida que é atacado; para isso, a classe `Guerreiro` estende `Contador`, de forma a aproveitar o código de decrementar contador.

Essa solução possui alguns problemas:

- `Guerreiro` herda o método `reseta`, que retorna o contador para o seu valor inicial; no entanto, no jogo o Guerreiro não pode recuperar sua vida, e portanto não deve possuir métodos como `reseta`.
- Se no futuro `Guerreiro` precisar de outro contador regressivo (ex.: para representar fôlego), não é possível estender `Contador` duplamente.
- Do ponto de vista conceitual, `Guerreiro` não é um `Contador`; na verdade, `Guerreiro` possui um `Contador` de vida.

Re-escreva o código, de forma a substituir herança por composição. Ou seja, `Guerreiro` deve possuir um `Contador`, que representa a vida do guerreiro. Consulte os testes em caso de dúvida.

<textarea class="code lang-python">
class Contador:
  def __init__(self, inicial):
    self._inicial = inicial
    self._contagem = inicial
  
  def decrementa(self, qtd=1):
    self._contagem -= qtd
    if self._contagem < 0:
      self._contagem = 0
  
  def reseta(self):
    self._contagem = self._inicial
  
  @property
  def contagem(self):
    return self._contagem

class Guerreiro(Contador):
  def __init__(self):
    super().__init__(10)

  def recebe_dano(self):
    self.decrementa(4)
  
  def provoca_dano(self, outro_guerreiro):
    outro_guerreiro.recebe_dano()
  
  @property
  def vida(self):
    return self._contagem
</textarea>

<textarea class="stdin">
# code

</textarea>

<div class="testcode">
import unittest
from unittest import mock

class TestContaAuditada(unittest.TestCase):
  def test_guerreiro_tem_vida_10(self):
    g = Guerreiro()
    self.assertEqual(g.vida, 10)

  def test_guerreiro_nao_tem_vida_negativa(self):
    g = Guerreiro()
    g.recebe_dano()
    g.recebe_dano()
    g.recebe_dano()
    self.assertEqual(g.vida, 0)
    g.recebe_dano()
    self.assertEqual(g.vida, 0)

  def test_guerreiro_nao_reseta(self):
    g = Guerreiro()
    try:
      g.reseta()
      self.fail()
    except AttributeError:
      pass

  def test_guerreiro_nao_decrementa(self):
    g = Guerreiro()
    try:
      g.decrementa()
      self.fail()
    except AttributeError:
      pass

  @mock.patch('__main__.Contador.decrementa')
  def test_guerreiro_usa_contagem(self, decrementa):
    g = Guerreiro()
    g.recebe_dano()
    decrementa.assert_called()
  
  def test_guerreiro_nao_estende_contador(self):
    self.assertFalse(issubclass(Guerreiro, Contador))

if __name__ == '__main__':
  import sys
  unittest.main(exit=False)
</div>
