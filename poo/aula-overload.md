<!-- https://www.baeldung.com/java-method-overload-override -->

# Sobrecarga (overload)

- Sobrecarga de métodos é um mecanismo de linguagem que permite que uma classe possua diversos métodos com o mesmo nome
- ...e número de parâmetros diferente
- ...e tipo de parâmetros diferente
- A sobrecarga pode ser usada para criar classes mais fáceis de usar

---

# Sobrecarga

Considere a seguinte classe:

```java
public class Calculadora {
    int soma2ints(int a, int b) {
        return a + b;
    }
    int soma3ints(int a, int b, int c) {
        return a + b + c;
    }
    float soma2floats(float a, float b) {
        return a + b;
    }
    // ...
}
```

---

# Sobrecarga: número de parâmetros

Podemos *sobrecarregar* o método `somaInt` ao definir duas versões, uma com 2 e outra com 3 parâmetros. O compilador determina qual versão será executada de acordo com o número de valores passados como parâmetro:

```java
public class Calculadora {
    int somaInt(int a, int b) {
        return a + b;
    }
    int somaInt(int a, int b, int c) {
        return a + b + c;
    }
    // ...
}
```

---

# Sobrecarga: tipo de parâmetros

Também podemos *sobrecarregar* o método `soma` para aceitar ou `int` ou `float`. Exemplo:

```java
public class Calculadora {
    int soma(int a, int b) {
        return a + b;
    }
    float soma(float a, float b) {
        return a + b;
    }
    // ...
}
// soma(1, 2) chama a primeira versão
// soma(1.0f, 2.0f) chama a segunda versão
```

---

# Sobrecarga: juntando tudo

```java
public class Calculadora {
    int soma(int a, int b) {
        return a + b;
    }
    int soma(int a, int b, int c) {
        return a + b + c;
    }
    float soma(float a, float b) {
        return a + b;
    }
    float soma(float a, float b, float c) {
        return a + b + c;
    }
}
```

OBS.: duas versões de um método não podem diferir apenas no tipo de retorno (para evitar ambiguidades). O resultado é um erro de compilação.

---

# Conversões ampliadoras

No exemplo anterior, qual versão do método é executada na chamada `soma(1, 2.0f)`?

---

# Conversões ampliadoras

Não existe nenhuma versão com parâmetros `(int, float)`, mas o compilador *implicitamente* (i.e., sem o programador pedir) converte o primeiro `int` para `float` e então executa a versão `soma(float, float)`.

Esse tipo de conversão só é feita de um tipo mais restrito para um tipo mais amplo. No exemplo, `float` é mais amplo do que `int`, pois pode assumir os mesmos valores que `int` e mais outros valores.

---

# Sobrecarga de construtores

O que vale para métodos também vale para construtores.

---

# Exemplos nas classes nativas do Java

- [Método print de PrintStream](https://docs.oracle.com/javase/7/docs/api/java/io/PrintStream.html#print(boolean))
- [Construtores da classe Date](https://docs.oracle.com/javase/8/docs/api/java/util/Date.html#constructor.summary)