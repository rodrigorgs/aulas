---
layout: remark
title: Herança - parte 1
---

<div>

# Reuso em POO

Considere as classes `Cao` e `Gato` dentro de um jogo de animais:

- `Cao` possui cor e pode andar, morder, latir e babar.
- `Gato` possui cor e pode andar, morder, miar e ronronar.

Suponha que já criamos a classe `Cao` e agora queremos escrever a classe `Gato`. Dado que há muitas coisas comuns entre cães e gatos, como evitar duplicar código entre as duas classes?

A POO oferece dois mecanismos: **composição** e **herança**.

---

```java
public class Cao {
  private Cor cor;
  public void setCor(Cor cor) { }
  public Cor getCor() { }
  public void anda(int direcao) { }
  public void morde() { }
  public void late() { }
  public void baba() { }
}
```

---

# Herança

A herança é um mecanismo que permite que uma classe receba todos os membros visíveis* (atributos e métodos, mas não construtores) de outra classe.

\* isto é, excluindo os privados e, a depender do caso, privados ao pacote

---

# Herança

Para que uma classe, `B`, herde de uma classe `A`, deve-se declarar `B` da seguinte forma:

```java
public class B extends A {
  // ...
}
```

Além dos membros herdados, a classe B pode definir membros adicionais.

---

# Herança

- No exemplo anterior, diz-se B *estende* A, ou B *herda* de A, ou B *deriva* de A
- B é chamada de *subclasse* de A ou classe *filha* de A ou classe *derivada* de A
- A é chamada de *superclasse* de B ou classe *mãe* de B ou classe *base* de B

---

# Herança

```java
public class Gato extends Cao {
  public void mia() { }
  public void ronrona() { }
}
```

- Pergunta: quais membros de Cao foram herdados por Gato?
- Pergunta: tem algum problema nesse código?

---

# Herança

O programa abaixo compila e executa normalmente:

```java
Gato garfield = new Gato();
gato.anda(1);
gato.mia();
gato.late();
```

No entanto, um gato não deveria latir! Posteriormente veremos como usar herança corretamente.

---

# Composição

A outra forma de reaproveitar código é através da **composição**: um objeto possui referência para outro objeto.

```java
public class Gato {
  private Cao cao = new Cao();
  public void mia() { }
  public void ronrona() { }
}
```

Diferente do que acontece na herança, aqui o gato não ganha automaticamente a habilidade de andar e morder. É preciso criar esses métodos e então **encaminhar** para o cao (ver próximo slide).

---

# Composição

```java
public class Gato {
  private Cao cao = new Cao();
  public void mia() { }
  public void ronrona() { }
  public void anda(int direcao) {
    cao.anda(direcao);
  }
  public void morde() {
    cao.morde();
  }
  public void setCor(Cor cor) {
    cao.setCor(cor);
  }
  public Cor getCor() {
    return cao.getCor();
  }
}
```

---

# Composição

A vantagem é que aqui podemos *esconder* métodos como `late()` e `baba()`. Assim, o código a seguir não vai compilar:

```java
Gato garfield = new Gato();
gato.anda(1);
gato.mia();
gato.late();
```

---

# Composição vs. herança

- Herança
  - Código mais enxuto. Por outro lado, herda até o que não precisa (método esconder()).
- Composição
  - Você só cria os atributos e métodos que fazem sentido. Por outro lado, você precisa recriar os métodos e encaminhar a chamada para o objeto da outra classe.

---

# Composição vs. herança

Uma maneira intuitiva (mas não infalível) para ajudar a decidir se devemos usar composição ou herança:

- Composição deve estabelecer um relacionamento de **tem-um**: um gato **tem um** cachorro
- Herança deve estabelecer um relacionamento de **é-um**: um gato **é um** cachorro

Ou seja, nesse caso nenhum dois dois é adequado.

---

# Composição vs. herança

![Cachorro vestido como gato](https://blog.pawstruck.com/wp-content/uploads/2017/10/catdog.jpg)

---

# Outra solução

Solução: vamos criar uma classe com o que existe em comum entre `Cao` e `Gato`.

- `Animal` possui cor e pode andar e morder
- `Cao` estende `Animal` e também pode latir e babar
- `Gato` estende `Animal` e também pode miar e ronronar

---

# Outra solução

- Herança possui outra vantagem: se adicionarmos alguma nova característica ou comportamento ao Animal, Cao e Gato herdarão automaticamente essa novidade.
- Isso pode ser uma desvantagem se você usar herança incorretamente (por exemplo, fazendo Robo estender Animal -- herança oportunista -- e depois adicionando a Animal o método transpira)

---

# Outra solução

E se quisermos adicionar um `Peixe`? Ele possui cor e pode nadar (mas não pode andar).

---

# Exercícios

Durante a aula, em equipes:

- Pense em classes para representar formas geométricas, com seus principais atributos e métodos, e como seriam as relações de herança entre elas.
- A mesma coisa para membros da comunidade UFBA

(Livro Deitel p. 285)

<!-- Funcionário, professor, membro externo, estudante (graduação e pós) -->

---

# Invocando construtores da superclasse

A palavra `super` pode ser usada para chamar um construtor da superclasse (veremos outros usos depois). Exemplo:

```java
public class Animal {
  private Cor cor;
  protected Animal(Cor cor) {
    this.cor = cor;
  }
}

// Gato não tem acesso ao atributo cor (private)
public class Gato extends Animal {
  public Gato() {
    super(new Cor("preta"));
    // faz outras coisas
  }
}
```

---

# Invocando construtores da superclasse

Dentro de um construtor, há duas opções:

- Não chamar nenhum construtor da superclasse usando `super`. Nesse caso, o compilador insere no início uma chamada a `super()` (construtor sem parâmetros). A classe mãe deve possuir construtor sem parâmetros, do contrário dá erro de compilação. (mostrar exemplo)
- Chamar algum construtor da superclasse usando `super()`. Essa chamada deve ser a primeira instrução no construtor, caso contrário dá erro de compilação.

---

# Invocando construtores da superclasse

Considere o seguinte código:

```java
class A {
  A() { System.out.println("A"); }
}
class B extends A {
  B() { System.out.println("B"); }
}
class C extends B {
  C() { System.out.println("C"); }
}
```

Ao invocar `C c = new C();`, qual a saída?

</div>