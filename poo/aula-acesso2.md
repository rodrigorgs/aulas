---
layout: remark
title: "Encapsulamento"
---

<div>

# Encapsulamento

> Os dados guardados por um objeto devem ficar **escondidos** de objetos de outras classes

- É uma boa prática tornar os **atributos** das classes **privados**
  - Em Java, atributos privados não podem ser acessados por objetos de outras classes (isso geraria um erro de compilação)
- Desta forma, os objetos só se comunicam através de mensagens bem definidas (**métodos**)
- Se houver mudanças na forma como os dados são representados internamente, outros objetos não serão impactados

---

# Exemplo: termômetro

<div class="uml">
class Termometro {
    - temperatura : double
    + estaComFebre() : boolean
}
</div>

- Os clientes da classe `Termometro` só estão interessados em saber se o paciente está ou não com febre, e não precisam saber a temperatura
- Digamos que a temperatura seja representada em graus Celsius

```java
class Termometro {
    private double temperatura;
    public boolean estaComFebre() {
        return temperatura >= 38.0;
    }
}
```
--

- Por questões estratégicas, o fabricante agora vai passar a medir a temperatura em graus Fahrenheit. Os clientes serão impactados?

---

# Exemplo: termômetro

Não! Basta que o método `estaComFebre()` seja atualizado para lidar com graus Fahrenheit:

```java
class Termometro {
    private double temperatura;
    public boolean estaComFebre() {
*       return temperatura >= 100.4;
    }
}
```

Note que, se deixássemos os clientes acessarem diretamente a `temperatura`, eles iriam parar de funcionar corretamente após a mudança de Celsius para Fahrenheit.

---

# Exemplo: termômetro

- E se os clientes precisassem saber a temperatura exata?
- Deveríamos tornar o atributo `temperatura` público?
--

- Não! Vamos criar um método que retorna a temperatura. Considere o exemplo em que a temperatura é medida em Celsius:

```java
class Termometro {
    private double temperatura;
    public boolean estaComFebre() {
        return temperatura >= 38.0;
    }
*   public boolean temperaturaEmCelsius() {
*       return temperatura;
*   }
}
```
--

- Isso não é a mesma coisa que deixar o atributo `temperatura` público?
--

- De certa forma não... Considere agora a situação em que o fabricante atualiza a classe `Termometro` de forma que, internamente, ela trabalhe com graus Fahrenheit

---

# Exemplo: termômetro

```java
class Termometro {
    private double temperatura;
    public boolean estaComFebre() {
*       return temperatura >= 100.4;
    }
*   public boolean temperaturaEmCelsius() {
*       return (temperatura − 32) * 5/9;
*   }
}
```

- Apesar de a representação interna do termômetro ter mudado, os seus clientes poderão continuar a usá-lo como se nada tivesse acontecido

---

class: middle, center, inverse

# Getters e setters

---


</div>