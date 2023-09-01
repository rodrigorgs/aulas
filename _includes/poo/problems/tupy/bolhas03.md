## Bolhas, crianças e pedras

Crianças adoram estourar bolhas de sabão!

Continuando o programa anterior, crie uma classe `Pedra`, de acordo com o diagrama de classes abaixo:

<div class="uml">
class Image {
  - x
  - y
  - _collides_with(obj): bool
}
class Pedra {
  + __init__(x, y)
  + update()
}
class Crianca {
  + __init__(x, y)
  + update()
  + lancar()
}
Crianca --> "pedra 1" Pedra
Image <|-- Pedra
</div>

Cada criança carrega no bolso uma pedra para estourar bolhas. Quando o usuário pressiona a tecla `space` (barra de espaço), a criança lança a pedra, que passa a se mover para a direita, a 20 pixels por `update`. Quando a pedra sai da tela (`x > 820`), ela volta para a criança, e só então pode ser lançada novamente.

Quando uma pedra atinge uma bolha, a bolha é removida. (Use o método `_collides_with(obj)` para verificar se o objeto atual está colidindo com o objeto `obj`.)

Crie atributos e métodos adicionais se necessário.

Consulte a [documentação do Tupy](https://rodrigorgs.github.io/tupy/) para mais detalhes.

Aqui está a imagem da pedra:

<a href="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAoAAAAKCAYAAACNMs+9AAAAAXNSR0IArs4c6QAAAJxJREFUGJVtkC0Og0AQhb8hKBoMIUHtAZCVFVynh+IQOE5QgUTW4KqabDCktVS9ZTdl1ezM+8l7RvTut+se//tpNs3ZGah1xd/OtNAR4Pn6AuCrjXot6afZTCxfbXSXJgELCJAfSgWPzxsgEOq1DOBcNgCda4Ja6w5iEkbKIsYCvtrIVIEOcSjZD+NioSeFElC2w7hYqOesS0gL/wHFs0cd8E/CsQAAAABJRU5ErkJggg==" download="pedra.png">
<img width="20" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAoAAAAKCAYAAACNMs+9AAAAAXNSR0IArs4c6QAAAJxJREFUGJVtkC0Og0AQhb8hKBoMIUHtAZCVFVynh+IQOE5QgUTW4KqabDCktVS9ZTdl1ezM+8l7RvTut+se//tpNs3ZGah1xd/OtNAR4Pn6AuCrjXot6afZTCxfbXSXJgELCJAfSgWPzxsgEOq1DOBcNgCda4Ja6w5iEkbKIsYCvtrIVIEOcSjZD+NioSeFElC2w7hYqOesS0gL/wHFs0cd8E/CsQAAAABJRU5ErkJggg==">
</a>

<textarea class="code lang-python">
from tupy import *

# ...

bolhas = [
  Bolha(710, 20, 5),
  Bolha(720, 30, 10),
  Bolha(730, 40, 15),
]

run(globals())
</textarea>

<div class="runtemplate">
{% include poo/problems/tupy/fake-tupy.py %}
[[[code]]]
</div>

<div class="testcode">
{% include poo/problems/tupy/fake-tupy.py %}
[[[code]]]
{% include poo/problems/tupy/bolhas03.test.py %}
</div>
