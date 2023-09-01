## Foguete

Crie uma classe `Foguete` de acordo com o diagrama de classes e a especificação abaixo:

<div class="uml">
class Image {
  - x
  - y
  - file
}
class Foguete {
  - ligado: bool
  - velocidade: int
  + liga()
  + desliga()
  + acelera()
  + desacelera()
  + update()
}

Image <|-- Foguete
</div>

- Ao criar um foguete, deve-se especificar sua posição inicial, em `x` e em `y`.
- O foguete deve estar inicialmente desligado, parado e apontando para cima.
- Quando o foguete está ligado, chamas são emitidas pelo motor.
- Ao acelerar o foguete, sua velocidade se incrementa em 5 unidades.
- Ao desacelerar o foguete, sua velocidade se decrementa em 5 unidades, mas não pode ficar negativa.
- Só é possível acelerar e desacelerar o foguete com ele ligado.
- Quando o foguete está ligado e em movimento, cada chamada ao método `update` deve atualizar sua posição de acordo com a fórmula `y = y - velocidade`.
- Quando a posição do foguete é inferior a `-50`, ele deve ser movido para a posição `600`.

<!-- TODO: testes -->