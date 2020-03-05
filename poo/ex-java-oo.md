---
layout: page
---

Crie uma classe `Retangulo`, que representa um retângulo, com largura e altura (do tipo `double`). Por padrão, largura = altura = 1. Para este exercício, não é preciso checar se os valores de largura e altura são válidos. A classe deve possuir os seguintes métodos:

- `double calculaPerimetro()`: retorna a soma dos lados do retângulo
- `double calculaArea()`: retorna o produto da largura pela altura
- `double calculaVolume(double p)`: retorna o volume de um prisma retangular com profundidade `p`, tendo como base este retângulo; lembre-se que, nesse caso, o volume corresponde à área da base multiplicado pela profundidade

Crie também um programa que cria dois retângulos, com medidas fixas quaisquer, e imprime seus perímetros, áreas e volumes (considerando alturas quaisquer).

Bônus: note que o cálculo do volume é feito a partir do cálculo da área. Evite duplicar código.

---

Crie uma classe `Horario`, que possui horas e minutos, ambos inteiros. Crie os seguintes métodos:

- `void avancaUmMinuto()`: avança um minuto no horário; considere que 1 hora possui 60 minutos (i.e., 0--59), e um dia tem 24 horas (i.e., 0--23)
- `void imprime()`: imprime o horário na tela, no formato `horas:minutos`; exemplo: `18:30`, `7:15`

Crie um programa para testar seu código, se quiser.

Bônus: Se o número de minutos tiver um dígito, ele deve ser precedido por um zero no momento de imprimir. Exemplo: `14:05`

---

<!-- static -->

Crie uma classe `TelevisaoModelo123`, que representa um determinado modelo de TV, que possui o atributo `volume` (inteiro). A classe deve possuir os seguintes métodos:

- `definirVolume(int vol)`: altera o volume para `vol`, exceto se `vol` for menor que zero ou maior que o volume máximo
- `definirVolumeMaximo(int volMax)`: altera o volume máximo permitido

Note que, embora cada aparelho de TV possa ter seu volume ajustado de forma independente, o volume máximo é uma característica do modelo; isso significa que não deve ser possível ajustar o volume máximo diferentemente para cada aparelho.
