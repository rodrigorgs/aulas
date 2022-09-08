---
layout: triple-page
title: "Exercícios: rede social"
features: [code, python]
---

## Rede social

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
class TestGrupo(unittest.TestCase):
  pass
  # TODO

if __name__ == '__main__':
  import sys
  unittest.main(exit=False)
</textarea>