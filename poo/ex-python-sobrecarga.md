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

### Testes
x = Pessoa('111', 'Fulana')
y = Pessoa('222', 'Sicrana')
assert str(x) == 'Fulana (111)'
assert str(y) == 'Sicrana (222)'
</textarea>

## Pessoa e igualdade

Complete a implementação da classe `Pessoa` para permitir comparação de igualdade. Considere que duas pessoas são iguais se e somente se possuem o mesmo CPF.

<textarea class="code lang-python">
class Pessoa:
  def __init__(self, cpf, nome):
    self.cpf = cpf
    self.nome = nome

### Testes
p1 = Pessoa('111', 'Fulano')
p1x = Pessoa('111', 'Fulanovski')
p2 = Pessoa('222', 'Sicrana')
p3 = Pessoa('333', 'Fulano')
assert p1 == p1 and p2 == p2 and p3 == p3
assert p1 == p1x
assert p1 != p2 and p1 != p3
assert p1 != 'Fulano'
assert p1 != None
</textarea>

## Conjunto de pessoas

Com base na questão anterior, complete a implementação da classe `Pessoa` para permitir que suas instâncias sejam inseridas em conjuntos (sets). Lembre-se que pessoas são identificadas unicamente por seu CPF, ou seja, não pode haver duas instâncias com o mesmo CPF dentro de um conjunto.

<textarea class="code lang-python">
class Pessoa:
  def __init__(self, cpf, nome):
    self.cpf = cpf
    self.nome = nome

### Testes
p1 = Pessoa('111', 'Fulano')
p1x = Pessoa('111', 'Fulanovski')
p3 = Pessoa('333', 'Fulano')
s = set()
s.add(p1)
s.add(p1x)
s.add(p3)
assert len(s) == 2
</textarea>

## Frações

Complete a implementação da classe `Fracao`, que representa uma fração. Deve ser possível determinar se duas frações são equivalentes (usando o operador `==`) e ordenar frações pelo seu valor decimal. A fração deve ser representada como string no formato `numerador/denominador`; exemplos: `1/2`, `2/3`.

<textarea class="code lang-python">
class Fracao:
    def __init__(self, numerador, denominador):
        self.numerador = numerador
        self.denominador = denominador
    
    @property
    def valor_decimal(self):
        return self.numerador / self.denominador

### Testes
f1_2 = Fracao(1, 2)
f3_6 = Fracao(3, 6)
f3_4 = Fracao(3, 4)
assert f1_2 == f3_6
assert f3_6 != f3_4
assert str(f1_2) == '1/2'
assert str(f3_6) == '3/6'
l = [f1_2, f3_4, f3_6]
assert sorted(l)[2] == f3_4
</textarea>

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