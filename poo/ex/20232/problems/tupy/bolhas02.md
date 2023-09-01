## Bolhas e crianças

Onde há bolhas de sabão, há crianças!

Continuando o programa anterior, crie uma classe `Crianca`, de acordo com o diagrama de classes abaixo:

<div class="uml">
class Image {
  - x
  - y
}
class Crianca {
  + __init__(x, y)
  + update()
}
Image <|-- Criança
</div>

A criança é controlada pelas teclas direcionais do teclado. Cada vez que uma tecla direcional é pressionada, a criança se move 20 pixels na direção correspondente.

Consulte a [documentação do Tupy](https://rodrigorgs.github.io/tupy/) para mais detalhes.

<textarea class="code lang-python">
from tupy import *

# ...

run(globals())
</textarea>

<div class="runtemplate">
{% include_relative problems/tupy/fake-tupy.py %}
[[[code]]]
</div>

<div class="testcode">
{% include_relative problems/tupy/fake-tupy.py %}
[[[code]]]
{% include_relative problems/tupy/bolhas02.test.py %}
</div>