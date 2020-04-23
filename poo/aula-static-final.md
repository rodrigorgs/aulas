---
layout: remark
title: "Java: orientação a objetos - static"
---

<div>

# Atributos e métodos

Vimos até agora que uma classe especifica **atributos** e **métodos**

Um método deve ser chamado no contexto de um objeto. Exemplo:

```java
Retangulo r;
Retangulo s;
// ...
// Chama o método definirDimensoes no contexto do objeto r
r.definirDimensoes(2, 3);
```
--


Os exemplos abaixo estão **incorretos**:

```java
definirDimensoes(2, 3);
// O método definirDimensoes está definido em que classe?

Retangulo.definirDimensoes(2, 3);
// Estamos definindo as dimensões de qual retângulo?
// Do retângulo r? Do retângulo s?
```

---

# Métodos estáticos

- Java permite declarar métodos como **estáticos**
- Um método estático é chamado diretamente, como uma função, independentemente de um objeto
- Métodos estáticos são chamados de **métodos de classe**; métodos não-estáticos são chamados de **métodos de instância**


```java
class Retangulo {
    private double base;
    private double altura;

    public static int numeroDeLados() {
        return 2;
    }
    public void setAltura(double a) {
        altura = a;
    }
    public void setBase(double b) {
        base = b;
    }
}

public class Programa {
    public static void main(String[] args) {
        Retangulo r = new Retangulo();
        r.setBase(4.0);
        r.setAltura(5.0);
        int n = Retangulo.numeroDeLados();
    }
}
```

</div>
