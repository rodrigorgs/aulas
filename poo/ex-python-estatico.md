---
layout: triple-page
title: "Exercícios: membros estáticos"
features: [code, python]
---

## Vídeos

Complete a implementação de acordo com seu conhecimento sobre membros estáticos.

<textarea class="code lang-python">
class Video:
  '''Defina dois atributos estáticos:
  TIPO_FILME, com valor "filme"
  TIPO_SERIE, com valor "serie"
  '''

  def __init__(self, id, tipo):
    self.id = id
    self.tipo = tipo

  def tipos():
    '''Implemente para retornar uma lista contendo
    os elementos TIPO_FILME e TIPO_SERIE, nessa ordem.
    Este método deve poder ser acessado mesmo sem
    uma referência para um objeto do tipo Filme'''
    pass

### Testes
assert Video.TIPO_FILME == 'filme'
assert Video.TIPO_SERIE == 'serie'
assert Video.tipos == ['filme', 'serie']
Video.TIPO_FILME = 'f'
Video.TIPO_SERIE = 's'
assert Video.tipos == ['f', 's']
</textarea>