---
layout: page
title: Herança - parte 2
---

# A classe Object

Em Java, todas as classes estendem, diretamente ou indiretamente, a classe `Object` (exceto a própria classe `Object`). Assim, não usar a palavra `extends` ao declarar uma classe é equivalente a usar `extends Object`.

Isso significa que todas as classes herdam os métodos definidos em [`Object`](https://docs.oracle.com/javase/7/docs/api/java/lang/Object.html).

---

# A classe Object

- `equals(objeto)` - determina se o objeto atual é igual ao objeto passado como parâmetro (de acordo com algum critério de igualidade) -- ver também `hashCode()`
- `toString()` - retorna a representação textual do objeto. Chamado implicitamente sempre que o objeto é convertido para String (o que acontece, por exemplo, ao concatenar uma string com o objeto)
- `getClass()` - retorna a classe à qual o objeto pertence
- `clone()` - cria uma cópia rasa do objeto (ver documentação)
- `finalize()` - chamado quando o *garbage collector* destrói o objeto

Métodos: toString() -- uso ímplicito na concatenação de strings, equals() e hashCode()

---







# Sobreposição

Sobreposição é definir um método com o mesmo nome, parâmetros e tipo de retorno que um método de uma superclasse.

Em inglês, sobreposição = *override*

---

# Sobreposição

Exemplo:

```java
class Recepcionista {
  public void cumprimentar(String nome) {
    System.out.println("Oi, " + nome);
  }
  public void pegarMalas() {
    System.out.println("...");
  }
}
class RecepcionistaImportado extends Recepcionista {
  public void cumprimentar(String nome) {
    System.out.println("Hi, " + nome);
  }
}
```

---

# Sobreposição

Uso:

```java
Recepcionista r1 = new Recepcionista();
RecepcionistaImportado r2 = new RecepcionistaImportado();
r1.cumprimentar("Julia");
r2.cumprimentar("Julia");
```

---

# Sobreposicao

Ao sobrepor um método...

- ... você pode aumentar a sua visibilidade, mas nunca diminuir. Exemplo: você pode sobrepor um método protected com um método public.
- ... o tipo de retorno pode ser mais específico do que aquele da superclasse (isto é, o tipo de retorno pode ser uma subclasse do tipo de retorno da superclasse). Exemplo: o método da superclasse retorna Object, o método da subclasse retorna String.

---

# Anotação @Override

Ao digitar `@Override` acima da declaração de um método, você está sinalizando para o compilador que aquele método está sobrepondo um método de uma superclasse. Fazer isso resulta em alguns benefícios:

- Se você digitar errado o nome (ou a assinatura) do método que deseja sobrepor, você estará criando um método totalmente novo, e o compilador vai emitir um erro.
- Se alguém mudar o nome (ou a assinatura) do método da superclasse e esquecer de mudar na sua classe, vai dar erro de compilação.
- Quem lê o seu código vai saber que você está sobrepondo um método.

---

# Métodos "final"

Métodos declarados com a palavra `final` não podem ser sobrepostos. Exemplo:

```java
class A {
  public final void teste() { /* ... */ }
}
class B extends A {
  @Override
  public void teste() { /* ... */ }
}
// Resultado: erro de compilação
```

---

# Classes "final"

Uma classe `final` não pode ser estendida. Exemplo:

```java
// A.java
public final class A {
}
// B.java
public class B extends A {
}
// Resultado: erro de compilação
```

---

# Object e sobreposição

Ao definir uma classe, é útil sobrepor os seguintes métodos da classe `Object`: `toString()`, `equals(obj)` e `hashCode()`.

---

# Object e sobreposição

Exemplo com `toString()`:

```java
public class Pessoa {
  private String nome;
  private int idade;
  private String rg;
  private String cpf;

  public Pessoa(String nome) {
    this.nome = nome;
  }

  @Override
  public String toString() {
    return nome;
  }

  public static void main(String[] args) {
    Pessoa fulana = new Pessoa("Fulana de Tal");
    Pessoa sicrano = new Pessoa("Sicrano Junior");

    System.out.println("Oi, " + fulana);
  }
}
```

---

# Object e sobreposição

Exemplo com `equals` e `hashCode`.

```java
public class Pessoa
  private String nome;
  private long cpf;

  public Pessoa(String nome, long cpf) {
    this.nome = nome;
    this.cpf = cpf;
  }
  @Override
  public int hashCode() {
    return (int)cpf;
  }
  @Override
  public boolean equals(Object obj) {
    if (obj == null)
      return false;
    if (getClass() != obj.getClass())
      return false;
    Pessoa outraPessoa = (Pessoa)obj;
    return cpf == outraPessoa.cpf;
  }
```

---

# Object e sobreposição

Ainda sobre `equals` e `hashCode`:

- O Eclipse consegue implementar esses métodos para sua classe. Clique no menu `Source`, e então em `Generate hashCode() and equals()...`
- `hashCode()` deve retornar um valor de forma que, se dois objetos retornarem valores diferentes, eles são considerados diferentes -- e nesse caso `equals()` deve retornar `false`, para ficar consistente
- Se dois objetos retornarem o mesmo `hashCode`, eles podem ser iguais ou diferentes -- é preciso chamar `equals()` para ter certeza

---

# Super e sobreposição

Ao sobrepor um método, você ainda consegue chamar o método da superclasse que foi sobreposto; para isso você usa `super.nomeDoMetodo()`. Exemplo:

```java
class Recepcionista {
  public void cumprimentar(String nome) {
    System.out.println("Oi, " + nome);
  }
  public void pegarMalas() {
    System.out.println("...");
  }
}
class RecepcionistaPoliglota extends Recepcionista {
  public void cumprimentar(String nome) {
    System.out.println("Hi, " + nome);
    super.cumprimentar(nome);
  }
}
```

---

# Sobreposição e private

Um método `private` não pode ser sobreposto, pois ele não é visível pela subclasse. Exemplo:

```java
class A {
	private void teste() {
		System.out.println("A");
	}
}
class B extends A {
	private void teste() {
		System.out.println("B");
	}
}
```

O código compila, mas `B.teste()` não está sobrepondo `A.teste()`; na verdade ele é um método completamente novo. Podemos verificar isso ao adicionar a anotação `@Override` ou ao tentar chamar o método da superclasse usando `super.teste()`;
