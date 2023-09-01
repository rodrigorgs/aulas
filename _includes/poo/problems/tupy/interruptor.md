
## Interruptor e lâmpada

Considere agora o seguinte diagrama UML:

<div class="uml">
class Lampada {
  - ligada: bool
  + liga()
  + desliga()
}

class Interruptor {
  - ligado: bool
  + conectar(lampada)
  + alterna()
}

Interruptor --> "lampadas *" Lampada
</div>

Ambas as classes devem estender a classe Image do Tupy (omitida do diagrama para não poluir).

Cada interruptor pode estar conectado a várias lâmpadas. Em um dado momento, um interruptor pode estar ligado ou desligado. Ao ser criado, um interruptor deve estar inicialmente desligado. Ao ser ligado, o interruptor deve ligar todas as lâmpadas a ele associadas; ao ser desligado, deve desligar todas as lâmpadas a ele associadas.

<textarea class="code lang-python">
from tupy import *

class Interruptor(Image):
  pass

class Lampada(Image):
  pass

# Exemplo de uso
l1 = Lampada()
l2 = Lampada()
l3 = Lampada()
l4 = Lampada()
i1 = Interruptor()
i1.conectar(l1)
i1.conectar(l3)
i1.conectar(l4)
i2 = Interruptor()
i2.conectar(l2)
i2.conectar(l3)
i3 = Interruptor()
i3.conectar(l4)

run(globals())
</textarea>


