---
layout: page
# title: Classes em Python
features: [code, python]
---

## Retângulo

Crie uma classe `Retangulo` com três propriedades:

- `largura`
- `altura`
- `area` (somente leitura)

A `area` deve sempre refletir quaisquer alterações de `largura` e `altura`

Todo retângulo deve ser criado com uma largura e uma altura informada pelo cliente da classe.

<textarea class="code lang-python">
class Retangulo:
  def __init__(self, largura, altura):
    self.largura = largura
    self.altura = altura
  
  @property
  def area(self):
    return self.largura * self.altura

# Testes
class Retangulo:
  def __init__(self, largura, altura):
    self.largura = largura
    self.altura = altura
  
  @property
  def area(self):
    return self.largura * self.altura

# Testes
r1 = Retangulo(3, 4)
assert r1.area == 12

r1.largura = 5
r1.altura = 3
assert r1.area == 15

houve_excecao = False
try:
  r1.area = 10
except AttributeError as e:
  houve_excecao = True
assert houve_excecao

print("Fim")
</textarea>

## Seilá