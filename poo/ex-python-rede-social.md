---
layout: triple-page
title: "Exercícios: rede social"
features: [code, python]
---

## Rede social

Uma rede social é formada por usuários, identificados unicamente pelo seu número de telefone e grupos de usuários, que possuem um único dono. Complemente a implementação de acordo com o que está especificado nas docstrings.

<textarea class="code lang-python">
class Usuario:
  '''Um usuário da rede social é unicamente identificado
  pelo seu número de telefone.'''
  def __init__(self, telefone, nome):
    pass

class Grupo:
  '''Grupo de usuários na rede social.
  Um grupo possui um nome e um conjunto de membros.
  Além disso, ele possui exatamente um dono, que é um membro.
  Um grupo não pode estar vazio.
  '''
  def __init__(self, nome, dono):
    pass

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

class TestUsuario(unittest.TestCase):
  def test_iguais(self):
    a = Usuario('123', 'abc')
    b = Usuario('123', 'abc')
    self.assertEqual(a, b)
  
  def test_mesmo_telefone_nome_diferente(self):
    a = Usuario('123', 'abc')
    b = Usuario('123', 'def')
    self.assertEqual(a, b)
  
  def test_diferentes(self):
    a = Usuario('123', 'abc')
    b = Usuario('124', 'abc')
    self.assertNotEqual(a, b)


class TestGrupo(unittest.TestCase):
  def test_cria_grupo(self):
    u = Usuario('71993009831', 'Caio')
    g = Grupo('POO', u)
    self.assertEqual(g.nome, 'POO')
    self.assertEqual(g.dono, u)
    self.assertIn(u, g.usuarios)

  def test_adiciona_usuario(self):
    u = Usuario('71993009831', 'Caio')
    g = Grupo('POO', u)
    a = Usuario('71993009830', 'Felipe')
    g.adiciona(a)
    self.assertIn(a, g.usuarios)

  def test_remove_usuario_sucesso(self):
    u = Usuario('71993009831', 'Caio')
    g = Grupo('POO', u)
    a = Usuario('71993009830', 'Felipe')
    g.adiciona(a)
    self.assertEqual(g.remove(u), False)
    g.remove(a)
    self.assertNotIn(a, g.usuarios)
  
  def test_remove_usuario_falha_dono_tamanho(self):
    u = Usuario('71993009831', 'Caio')
    g = Grupo('POO', u)
    a = Usuario('71993009830', 'Felipe')
    g.adiciona(a)
    self.assertEqual(g.remove(u), False)
    g.remove(u)
    self.assertIn(u, g.usuarios)
  
  def test_remove_usuario_falha_usuario(self):
    u = Usuario('71993009831', 'Caio')
    g = Grupo('POO', u)
    a = Usuario('71993009830', 'Felipe')
    d = Usuario('71993009833', 'Pedro')
    g.adiciona(a)
    self.assertEqual(g.remove(d), False)
    g.remove(d)
    self.assertNotIn(d, g.usuarios)

  def test_altera_dono(self):
    u = Usuario('71993009831', 'Caio')
    g = Grupo('POO', u)
    a = Usuario('71993009830', 'Felipe')
    d = Usuario('71993009833', 'Pedro')
    g.adiciona(a)
    g.altera_dono(a)
    self.assertEqual(g.dono, a)
    self.assertEqual(g.altera_dono(d), False)

  def test_contem_membro(self):
    u = Usuario('71993009831', 'Caio')
    g = Grupo('POO', u)
    a = Usuario('71993009830', 'Felipe')
    d = Usuario('71993009833', 'Pedro')
    g.adiciona(a)
    self.assertEqual(g.contem_membro(a), True)
    self.assertEqual(g.contem_membro(d), False)

  def test_membros(self):
    a = Usuario('71993009830', 'Felipe')
    d = Usuario('71993009833', 'Pedro')
    g = Grupo('POO', a)
    g.adiciona(d)
    
    u = Usuario('71993009831', 'Caio')
    membros = g.membros()
    membros.append(u)
    self.assertIn(d, g.membros())
    self.assertIn(a, g.membros())
    self.assertNotIn(u, g.membros())

  def test_tamanho(self):
    u = Usuario('71993009831', 'Caio')
    g = Grupo('POO', u)
    a = Usuario('71993009830', 'Felipe')
    d = Usuario('71993009833', 'Pedro')
    g.adiciona(a)
    g.adiciona(d)
    self.assertEqual(g.tamanho(), 3)

if __name__ == '__main__':
  import sys
  unittest.main(exit=False)
</textarea>