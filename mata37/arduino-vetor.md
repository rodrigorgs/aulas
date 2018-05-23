---
layout: page
title:  "Arduino: vetores"
categories: aula
---

# Circuito

Ligar 4 leds nos pinos 8 a 11, e um push button no pino 7.

# Programação

## Programa inicial

```c++
void setup() {
  pinMode(8, OUTPUT);
  pinMode(9, OUTPUT);
  pinMode(10, OUTPUT);
  pinMode(11, OUTPUT);
}

void loop() {
  digitalWrite(8, HIGH);
  digitalWrite(9, LOW);
  digitalWrite(10, HIGH);
  digitalWrite(11, LOW);

  delay(500);
}
```

O código escrito dentro de `setup` só vai rodar uma vez, no início do programa. Nesse código, configuramos os pinos dos LEDs para serem saída.

O código escrito dentro de `loop` vai rodar repetidas vezes, em um loop infinito. Nesse código, acendemos os LEDs nos pinos 8 e 10 (`HIGH`). Aguardamos 500 milissegundos antes de repetir o código.

# Passo 1 - vetor

Crie um vetor (no início do programa, antes de `setup`) para representar o estado dos LEDs: 0 = apagado, 1 = ligado. Acenda e apague os LEDs de acordo com os valores do vetor.

# Passo 2 - árvore de natal

A cada repetição, alterne o estado dos LEDs: apague os LEDs acesos e acenda os LEDs apagados. Faça isso alterando os valores do vetor.

# Passo 3 - letreiro deslizante

Faça agora com que, a cada iteração, os valores dos LEDs deslizem para a direita. Exemplo:

- 1ª Iteração: 1, 1, 0, 0
- 2ª Iteração: 0, 1, 1, 0
- 3ª Iteração: 0, 0, 1, 1
- 4ª Iteração: 0, 0, 0, 1
- 5ª Iteração: 0, 0, 0, 0
 
# Passo 4 - botão

Faça com que, ao acionar um botão, ligue-se o primeiro LED. Para checar o estado do botão:

```c++
int estado = digitalRead(7);
// se o botão estiver pressionado, retorna HIGH
// caso contrário, retorna LOW
```

# Passo 5 - generalização

Considere agora que pode haver um número maior de LEDs, e que eles podem estar ligados em outros pinos (não necessariamente em ordem crescente). Crie um vetor para representar os pinos em que os LEDs estão ligados e altere seu código para usar essa informação.

# Passo 5 - potenciômetro

Adicione um potenciômetro e religue os LEDs em pinos PWM. Acenda os LEDs com a intensidade proporcional ao valor lido no pino do potenciômetro.
