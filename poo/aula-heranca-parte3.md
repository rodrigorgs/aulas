# Polimorfismo

- Em POO, polimorfismo é um mecanismo de linguagem que permite que objetos de diferentes classes respondam de forma diferente à mesma mensagem. (O termo mais preciso seria *polimorfismo de subtipo*)
- Em outras palavras, há diferentes implementações para a mesma interface (o mesmo método com código diferente).
- Para isso, deve-se usar a sobreposição de métodos.
- (Polimorfismo é um dos conceitos mais difíceis de definir, e você encontrará diferentes definições e diferentes tipos de polimorfismo)

<!-- Polymorphism describes a pattern in object oriented programming in which classes have different functionality while sharing a common interface.

Outra definição: polimorfismo é quando você pode tratar um objeto como se fosse uma versão genérica de algo, mas quando você acessa um membro, o membro mais específico é associado, de acordo com o tipo do objeto.


Polymorphism is when you can treat an object as a generic version of something, but when you access it, the code determines which exact type it is and calls the associated code. -->

<!-- https://stackoverflow.com/questions/1031273/what-is-polymorphism-what-is-it-for-and-how-is-it-used -->

---

# Polimorfismo

Exemplo:

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


# Relação de subtipo

- A herança estabelece um relacionamento de subtipo entre duas classes. No exemplo anterior, a classe Animal define um tipo, e Gato é subtipo de Animal. 
- Dessa forma, um objeto do tipo Gato pode se passar como um objeto do tipo Animal (afinal, um gato **é um** animal).

---

# Relação de subtipo

Exemplo:

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

# Relação de subtipo

Da mesma forma, pode-se atribuir um objeto da classe Gato a uma variável do tipo Animal. Nesse caso, no entanto, só é possível acessar os membros definidos na classe Animal:

```java
Gato gato1 = new Gato();
Animal gato2 = new Gato();

gato1.anda()
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

# late binding (vinculação tardia)

Ao realizar uma chamada de método, em algum momento essa chamada é vinculada ao código que será executado. Se um mesmo método tiver várias implementações (porque foi sobreposto), essa vinculação só ocorre durante a execução do programa (pois o compilador não tem como determinar uma única implementação que será usada todas as vezes). É o que chamamos de vinculação tardia (*late binding*)

---

# late binding (vinculação tardia)

Considere o seguinte código:

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

Pergunta: o gato vai miar ou vai falar "Zzzzzz"?

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

- Nesse caso vamos composição e herança: Pessoa possui arma, e arma pode ser flecha ou espada. Atacar significa usar a arma.