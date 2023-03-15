---
layout: triple-page
title: Demonstração
features: [code,cpp,python]
---

## Correção com entrada e saída

Exemplo: Escreva um programa que lê um inteiro e imprime seu dobro. Para testar, digite um número inteiro na caixa "Entrada" e o programa deve imprimir o seu dobro.

Para especificar os casos de teste, crie um elemento com a classe `testcases`. Os testes são separados pela string `=====`. Cada teste é composto de entrada e saída, separados pela string `]]]`. Exemplo:

```html
<textarea class="stdin">2</textarea>
<div class="testcases">
  2
]]]
O dobro é 4
=====
3
]]]
O dobro é 6
</div>
```

O resultado dos testes aparece abaixo da caixa de saída.

<textarea class="code lang-python">
x = int(input())
print("O dobro é", x * 2)
</textarea>

<textarea class="stdin">2</textarea>
<div class="testcases">
2
]]]
O dobro é 4
=====
3
]]]
O dobro é 6
</div>

## Correção com código de testes

Exemplo: Escreva uma função, `dobro` que recebe um inteiro e retorna o seu dobro. Para testar, digite um número inteiro na caixa "Entrada" e o programa deve imprimir o seu dobro.

Para especificar o código de teste, esse código deve estar dentro de um elemento com a classe `testcode`.

Exemplo:

```html
<div class="testcode">
import unittest
class TestDobro(unittest.TestCase):
  def test2(self):
    self.assertEqual(dobro(2), 4)
  def test3(self):
    self.assertEqual(dobro(3), 6)

if __name__ == '__main__':
  import sys
  unittest.main(exit=False)
</div>
```

A primeira linha da saída deve conter um caractere para cada teste executado, que pode ser: 

- `.` em caso de sucesso
- `F` em caso de falha (resultado errado)
- `E` em caso de erro na execução do teste

Esse formato é usado por muitos frameworks de teste. Caso a saída não siga o formato, considera-se que os testes foram bem sucedidos somente se a saída for vazia. Exemplos de código de teste mais simples, que não segue o formato:

```html
<div class="testcode">
assert dobro(2) == 4, 'O dobro de 2 é 4'
assert dobro(3) == 6, 'O dobro de 3 é 6'
</div>
```

```html
<div class="testcode">
try:
  assert dobro(2) == 4, 'O dobro de 2 é 4'
  assert dobro(3) == 6, 'O dobro de 3 é 6'
except AssertionError as e:
  print(e)
</div>
```

```html
<div class="testcode">
dobro(2) == 4 or print('O dobro de 2 é 4')
dobro(3) == 6 or print('O dobro de 3 é 6')
</div>
```

O resultado dos testes aparece abaixo da caixa de saída.

<textarea class="code lang-python">
def dobro(x):
  return 4
</textarea>

<div class="testcode">
import unittest
class TestDobro(unittest.TestCase):
  def test2(self):
    self.assertEqual(dobro(2), 4)
  def test3(self):
    self.assertEqual(dobro(3), 6)

if __name__ == '__main__':
  import sys
  unittest.main(exit=False)
</div>

## Correção com entrada e saída em C++

Agora você deve digitar um número na caixa "Entrada" e o programa deve imprimir o seu dobro.

<textarea class="code lang-cpp">
#include &lt;iostream&gt;

using namespace std;

int main() {
  int x;
  cin >> x; 
  cout &lt;&lt; "O dobro é " &lt;&lt; (x * 2) &lt;&lt; endl;
  return 0;
}</textarea>

<textarea class="stdin">2</textarea>

<div class="testcases">
2
]]]
O dobro é 4
=====
3
]]]
O dobro é 6
</div>

## Fim

Parabéns, você finalizou a lição

