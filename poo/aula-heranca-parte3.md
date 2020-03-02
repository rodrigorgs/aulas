---
layout: remark
title: Herança - parte 3
---

<div>

# Polimorfismo

- Em POO, cada classe define um tipo de dados
- A herança estabelece um relacionamento de subtipo entre duas classes.
- Se Aluno estende Pessoa, dizemos que Aluno é um subtipo de Pessoa
- Dizemos também Aluno é um conceito mais concreto (mais detalhado), e que Pessoa é um conceito mais abstrato (menos detalhado)

---

# Polimorfismo

Na POO, o polimorfismo permite que referências de tipos de classes mais abstratas representem o comportamento das classes concretas que referenciam. Assim, é possível tratar vários tipos de maneira homogênea (através da interface do tipo mais abstrato). (definição da Wikipédia)

Dentro desse conceito, objetos de classes diferentes (porém relacionadas por meio de herança) podem responder de forma diferente à mesma mensagem (ou seja, as classes podem ter implementações diferentes para o mesmo método, por meio da sobreposição de métodos).

---

# Exemplo

```java
class Animal {
  public void anda() {
    System.out.println("Andando...");
  }
}
class Gato extends Animal {
  public void mia() {
    System.out.println("Miau");
  }
}
class Cao extends Animal {
  public void late() {
    System.out.println("Au-au");
  }
}
```

---

# Exemplo

- No exemplo anterior, a classe Animal define um tipo, e Gato é subtipo de Animal. 
- Dessa forma, um objeto do tipo `Gato` pode ser usado em qualquer ponto do programa onde se espera um objeto do tipo `Animal` (afinal, um gato **é um** animal).

---

# Exemplo

O método treina espera um `Animal`. O que acontece se passar um `Gato` ou um `Cao`?

```java
class Treinador {
  public void treina(Animal animal) {
    animal.anda();
    animal.anda();
  }
}

public class Main {
  public static void main(String[] args) {
    Animal animal = new Animal();
    Gato gato = new Gato();
    Cao cao = new Cao();
    Treinador treinador = new Treinador();

    treinador.treina(animal);
    treinador.treina(gato);
    treinador.treina(cao);
  }
}
```

---

# Exemplo

Da mesma forma, pode-se atribuir um objeto da classe `Gato` a uma variável do tipo `Animal`. Nesse caso, no entanto, só é possível acessar os membros definidos na classe `Animal`:

```java
Gato gato1 = new Gato();
Animal gato2 = new Gato();

gato1.anda();
gato1.mia();

gato2.anda();
gato2.mia(); // Erro de compilação
```

---

# Upcasting e downcasting

- Em programação, *cast* significa conversão de tipo explícita. Exemplo: `int x = (int)3.14`;
- Upcasting é fazer o cast para um tipo mais genérico (ou seja, para uma superclasse). Exemplo: `Animal gato = (Animal)new Gato();`. Nesse caso você não precisa fazer cast, pois a conversão é implicitamente realizada pelo compilador.
- O nome é upcasting porque geralmente, ao desenharmos um diagrama de classes, colocamos as superclasses acima das subclasses.

---

# Upcasting e downcasting

Downcasting é fazer o cast para um tipo mais específico (ou seja, uma subclasse). Exemplo:

```java
Animal a1 = new Gato();
Gato gatoAtual = (Gato)a1;
gatoAtual.mia();
```

Você precisa realizar o downcasting se quiser acessar os membros que são específicos de Gato.

---

# Upcasting e downcasting

Downcasting pode resultar em um erro (`ClassCastException`). Exemplo:

```java
class Treinador {
  public void treina(Animal animal) {
    animal.anda();
    ((Gato)animal).mia(); // pode dar erro!
  }
}
public class Main {
  public static void main(String[] args) {
    Gato gato = new Gato();
    Cao cao = new Cao();
    Treinador treinador = new Treinador();

    treinador.treina(gato);
    treinador.treina(cao);
  }
}

```

---

# instanceof

Para evitar erros ao fazer downcasting, use a instrução `instanceof` para checar a classe do objeto. Exemplo:

```java
class Treinador {
  public void treina(Animal animal) {
    animal.anda();
    if (animal instanceof Gato) {
      // animal é um Gato,
      // portanto a linha abaixo
      // não resultará em erro
      ((Gato)animal).mia();
    }
  }
}
```

---

# instanceof

- `x instanceof C` retorna verdadeiro se `C` for a classe de C ou uma de suas superclasses.
- Exemplo: se `fulano` for uma instância de `Aluno` e `Aluno` estende `Pessoa`, as seguintes expressões retornam verdadeiro:

```java
fulano instanceof Aluno
fulano instanceof Pessoa
fulano instanceof Object
```

---

# Late binding (vinculação tardia)

```java
class Animal {
  public void anda() {
    System.out.println("Andando...");
  }
  public void fazBarulho() {
    System.out.println("Zzzzzz...");
  }
}
class Gato extends Animal {
  @Override
  public void fazBarulho() {
    System.out.println("Miau");
  }
}
class Treinador {
  public void treina(Animal animal) {
    animal.anda();
    animal.anda();
    animal.fazBarulho();
  }
}
public class Main {
  public static void main(String[] args) {
    Gato gato = new Gato();
    Treinador treinador = new Treinador();
    treinador.treina(gato);
  }
}
```

- Dizemos que `fazBarulho` é um método polimórfico.
- **Pergunta**: o gato vai miar ou vai falar "Zzzzzz"?

---

# Late binding (vinculação tardia)

Ao realizar uma chamada de método, em algum momento essa chamada é vinculada ao código que será executado. Se um mesmo método tiver várias implementações (porque foi sobreposto), essa vinculação só ocorre durante a execução do programa (pois o compilador não tem como determinar uma única implementação que será usada todas as vezes). É o que chamamos de **vinculação tardia** (*late binding*) ou **vinculação dinâmica**.

---

# Late binding (vinculação tardia)

Quando temos uma linha assim:

```java
Pessoa x = new Aluno();
```

Temos uma referência do tipo `Pessoa` para um objeto do tipo `Aluno`. Isso é permitido se `Aluno` for subclasse direta ou indireta de `Pessoa`.

- Dizemos que o tipo estático de x é `Pessoa`
- Dizemos que o tipo dinâmico de x é `Aluno`. Esse é o tipo usado para decidir qual implementação de um método utilizar.

---

# Outro exemplo: arqueiros e guerreiros

Considere um jogo baseado em combate:

- Um arqueiro possui vida, posição, quantidade de flechas e pode andar e atacar (com a flecha)
- Um guerreiro possui vida, posição e pode andar e atacar (com a espada)

---

# Outro exemplo: arqueiros e guerreiros

Como vamos modelar esse problema?

- Pessoa possui vida, posição e pode andar
- Arqueiro estende Pessoa e também possui quantidade de flechas e pode atacar (com a flecha)
- Guerreiro estende Pessoa e também pode atacar (com a espada)

---

# Outro exemplo: arqueiros e guerreiros

- Problema: e se um arqueiro puder se transformar em guerreiro? (herança é estática, não permite mudanças ao longo da execução do programa)

---

# Outro exemplo: arqueiros e guerreiros

- Nesse caso vamos composição e herança: Pessoa possui Arma, e Arma pode ser Flecha ou Espada. Atacar significa usar a arma.

</div>

<!--
```java
public class Poligono {
  private Lado[] lados;
  public double area() { /* ... */ }
}
public class Retangulo extends Poligono {
  public double area() {
    return lados[0].getMedida() * lados[1].getMedida();
  }
}
public class Triangulo extends Poligono {
  public double area() {
    return 0.5 * lados[0].getMedida() * lados[1].getMedida() * Math.sin(lados[1].anguloCom(lados[0]));
  }
}
```
-->


<!-- 

# Exemplo

```java
class Animal {
  public void anda() { /* ... */ }
  public void fazBarulho() {
    System.out.println("Zzzzzzz");
  }
}
class Cao extends Animal {
  @Override
  public void fazBarulho() {
    System.out.println("Au-au");
  }
}
class Gato extends Animal {
  @Override
  public void fazBarulho() {
    System.out.println("Miau");
  }
}
```

`fazBarulho()` é um método polimórfico: ele é implementado de forma diferente a depender da classe.


 -->
