## Bolhas

Você já brincou com bolhas de sabão?

(Atenção: para estes exercícios, não adianta rodar o código no navegador. Você precisa rodar no seu computador.)

Crie um script do Tupy no seu computador e defina a classe `Bolha`, de acordo com o diagrama de classes abaixo:

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

Ah, e você pode usar esta imagem de bolha (clique para salvar):

<a href="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACgAAAAoCAYAAACM/rhtAAAAAXNSR0IArs4c6QAAATNJREFUWIXtmdERgyAMQANzuIX72Nl0H7dwD/sVjyDBRBBir++uPwrmXSJciQ4K+KzbLhk3j4O7G0M9USrFoZUVD86ILRdTp9RFqahoUELuSoqDyEokswMqisWIRdkbD8ohIsnkxUiutljMIZqSPF1oLIewkj4zSSo3Bb+7sLGIoHKPi6WqZDt2cMwN7d5WfXVjqVMl1sgtgvEaTs/yAKrSVi8pBzrFGcwFbSVHnp1bxSHNMhfjlSu3qdxn3fYwg1zwkv3tLoeLtMRkUks0gl34C5YiFezy/gH8SAa7ZQ+ACvbY7zgOF19yqH6aeRzc695BC2UmDh6grHfyFLl/1D2zeIpNMtfpyIkkj54kgxZKrTkXtyw1G+t9rQ/EdPMIMd1+CzHbwAwx3QIOMdtET9HiM8QXIN98QLSGIS4AAAAASUVORK5CYII=" download="bolha.png">
<img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACgAAAAoCAYAAACM/rhtAAAAAXNSR0IArs4c6QAAATNJREFUWIXtmdERgyAMQANzuIX72Nl0H7dwD/sVjyDBRBBir++uPwrmXSJciQ4K+KzbLhk3j4O7G0M9USrFoZUVD86ILRdTp9RFqahoUELuSoqDyEokswMqisWIRdkbD8ohIsnkxUiutljMIZqSPF1oLIewkj4zSSo3Bb+7sLGIoHKPi6WqZDt2cMwN7d5WfXVjqVMl1sgtgvEaTs/yAKrSVi8pBzrFGcwFbSVHnp1bxSHNMhfjlSu3qdxn3fYwg1zwkv3tLoeLtMRkUks0gl34C5YiFezy/gH8SAa7ZQ+ACvbY7zgOF19yqH6aeRzc695BC2UmDh6grHfyFLl/1D2zeIpNMtfpyIkkj54kgxZKrTkXtyw1G+t9rQ/EdPMIMd1+CzHbwAwx3QIOMdtET9HiM8QXIN98QLSGIS4AAAAASUVORK5CYII=">
</a>

Salve a imagem na mesma pasta de seu script, com o nome `bolha.png`.

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