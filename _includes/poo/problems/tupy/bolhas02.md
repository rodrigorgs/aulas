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

Precisa de uma imagem de criança? Pode usar essa:

<a href="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAB4AAAAoCAYAAADpE0oSAAAAAXNSR0IArs4c6QAAAOlJREFUWIXtltENgCAMRMU4iHEG95/AGYyb6JcJwZbelX6ooV9G2nsFTY80kLHM6ym9348tMTpwsgb0NgAlldBS3Fp3gXNRS5DJHS0wKoTmQGD0u3pqoR0zO0Fz4aOOjg4Wg/nJ0NwqmB2DTC181MhOmJN578jUxLUINQmkgf/YogTcjy3d7/NnpgF10RLLwWhNFYwWS2BGw9WtBUY0J6mgZWJJOi2+/ohlXs8WwXe7Uwd38KfArkHhMf4msDUwmAZcV58c4rFEE8yIsg2EiHhqq7dFBsg2oPpxlDVqug8/jgKWeqGe/Mm4ACi7tDx4TB2dAAAAAElFTkSuQmCC" download="crianca.png">
<img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAB4AAAAoCAYAAADpE0oSAAAAAXNSR0IArs4c6QAAAOlJREFUWIXtltENgCAMRMU4iHEG95/AGYyb6JcJwZbelX6ooV9G2nsFTY80kLHM6ym9348tMTpwsgb0NgAlldBS3Fp3gXNRS5DJHS0wKoTmQGD0u3pqoR0zO0Fz4aOOjg4Wg/nJ0NwqmB2DTC181MhOmJN578jUxLUINQmkgf/YogTcjy3d7/NnpgF10RLLwWhNFYwWS2BGw9WtBUY0J6mgZWJJOi2+/ohlXs8WwXe7Uwd38KfArkHhMf4msDUwmAZcV58c4rFEE8yIsg2EiHhqq7dFBsg2oPpxlDVqug8/jgKWeqGe/Mm4ACi7tDx4TB2dAAAAAElFTkSuQmCC">
</a>

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
{% include poo/problems/tupy/bolhas02.test.py %}
</div>