## Bolhas

Você já brincou com bolhas de sabão?

Crie um script do Tupy e defina a classe `Bolha`, de acordo com o diagrama de classes abaixo:

<div class="uml">
class Image {
  - x
  - y
}
class Bolha {
  - velocidade: int
  + __init__(x, y, velocidade)
  + update()
}
Image <|-- Bolha
</div>

A bolha se move para cima ou para baixo, de acordo com sua velocidade. Mais especificamente, a cada chamada a `update()`, sua posição `y` deve ser alterada para `y - velocidade`. Quando a bolha sai da tela por cima (`y < -20`), ela reaparece na parte inferior da tela (`y = 520`), e quando sai da tela por baixo (`y > 520`), reaparece por cima (`y = -20`).

Experimente criar várias bolhas em diferentes posições e com diferentes velocidades, inclusive negativas. Nesse caso, a bolha deve se mover para baixo.

<textarea class="code lang-python">
from tupy import *

# ...

run(globals())
</textarea>

<div class="runtemplate">
{% include poo/problems/tupy/fake-tupy.py %}
[[[code]]]
</div>

<div class="testcode">
{% include poo/problems/tupy/fake-tupy.py %}
[[[code]]]
{% include poo/problems/tupy/bolhas01.test.py %}
</div>