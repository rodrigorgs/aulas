---
layout: triple-page
title: "Exercícios: exceções"
features: [code, python]
---

## Preço do ingresso
<!-- raise -->

Complete a implementação do método `preco_ingresso`.

<textarea class="code lang-python">
def preco_ingresso(idade):
  '''
  Retorna o preço do ingresso para um comprador
  com determinada idade. Ingressos só podem ser
  vendidos para pessoas com idade entre 18 e 140
  anos. Caso uma idade fora dessa faixa seja
  passada, é lançada uma exceção ValueError.
  '''
  if idade >= 18 and idade <= 60:
    return 30.0
  elif idade > 60 and idade <= 140:
    return 15.0
</textarea>

<div class="testcode">
import unittest
from unittest import mock

class TestResumo(unittest.TestCase):
  def test_valores_validos(self):
    self.assertEqual(preco_ingresso(18), 30.0)
    self.assertEqual(preco_ingresso(60), 30.0)
    self.assertEqual(preco_ingresso(61), 15.0)
    self.assertEqual(preco_ingresso(140), 15.0)

  def test_valores_invalidos(self):
    with self.assertRaises(ValueError):
      preco_ingresso(17)
    with self.assertRaises(ValueError):
      preco_ingresso(0)
    with self.assertRaises(ValueError):
      preco_ingresso(141)

if __name__ == '__main__':
  import sys
  unittest.main(exit=False)
</div>

## Resumo do arquivo
<!-- try/except -->

Complete a implementação da função `resumo`, de acordo com a documentação embutida no código.

A função `resumo` usa a função `le_arquivo` para retornar um subconjunto das linhas de um arquivo texto. No código ao lado, assuma que a função `le_arquivo` está implementada corretamente.

<textarea class="code lang-python">
# não altere esta função
def le_arquivo(nome):
  '''Retorna uma lista de linhas de um arquivo.
  Se o arquivo não existir, lança a exceção
  FileNotFoundError.

  :param nome: nome do arquivo
  '''
  if nome == 'ajuda.txt':
    return ['ajuda', '===', '', 'fim']
  else:
    raise FileNotFoundError()

# Complete a implementação desta função
def resumo(nome_arquivo, n):
  '''Retorna as n primeiras linhas de um
  arquivo, se existir. Se o arquivo não
  existir, retorna a string "Não
  encontrado".

  :param nome_arquivo: nome do arquivo
  :param n: número de linhas
  '''
  linhas = le_arquivo(nome_arquivo)
  return linhas[0:n]

</textarea>

<textarea class="stdin">
# code
r = resumo('ajuda.txt', 2)
print(r)
</textarea>

<div class="testcode">
import unittest
from unittest import mock

class TestResumo(unittest.TestCase):
  def test_le_arquivo_nao_foi_alterada(self):
    exp = ['ajuda', '===', '', 'fim']
    res = le_arquivo('ajuda.txt')
    self.assertEqual(res, exp)

    try:
      le_arquivo('ajuda123.txt')
      self.fail()
    except FileNotFoundError:
      pass
  
  @mock.patch('__main__.le_arquivo',
      return_value=[32,6,7,4,67,8,4])
  def test_resumo_ok(self, _):
    ret = resumo('seila.md', 5)
    self.assertEqual(ret, [32,6,7,4,67])

  @mock.patch('__main__.le_arquivo',
      side_effect=FileNotFoundError())
  def test_resumo_file_not_found(self, _):
    ret = resumo('seila.md', 5)
    self.assertEqual(ret, 'Não encontrado')

  @mock.patch('__main__.le_arquivo',
      side_effect=PermissionError())
  def test_resumo_outra_excecao(self, _):
    try:
      ret = resumo('seila.md', 5)
    except Exception:
      pass
    else:
      self.fail('Outras exceções não devem ser tratadas')

if __name__ == '__main__':
  import sys
  unittest.main(exit=False)
</div>

