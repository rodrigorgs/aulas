---
layout: remark
title: "Java: orientação a objetos"
---

<div>

# Antes de começar

A sintaxe de Java é muito similar à sintaxe da linguagem C; se você sabe C, você deverá conseguir entender boa parte dos seguintes códigos sem muitas explicações.

---

# Pensando em objetos

- Imagine que estamos criando um programa que gerencia pessoas, e para cada pessoa armazenamos sua data de nascimento. A partir dessa informação queremos saber a idade de cada pessoa.
- Em linguagens procedimentais (como C), criamos um conjunto de funções (subprogramas), que operam sobre dados (os parâmetros das funções).
  - Funções são como ferramentas
  - Se quisermos saber a idade de uma pessoa, trazemos a pessoa para perto, obtemos sua data de nascimento, e então lançamos essa informação em um programa que sabe calcular idades
  - Um pseudoprograma procedimental: `d = fulano.dataNascimento; idade = calcularIdade(d);`

---

# Pensando em objetos

- Em linguagens orientadas a objetos, pessoas não são apenas seus dados: elas também possuem comportamento. Em particular, cada pessoa sabe calcular sua própria idade.
  - Assim, se queremos saber a idade de uma pessoa, perguntamos para ela: "Fulano, qual sua idade?" (em OO, dizemos que enviamos uma mensagem para o objeto)
  - Um pseudoprograma OO: `idade = fulano.idadeAtual()`
  - Note que `idadeAtual` não é um dado que está armazenado junto com pessoa; para responder a idade atual, a pessoa vai executar um código considerando seus dados (em particular, a data de nascimento)

---

# Criando objetos

**Objetos** são um grupo de variáveis (**atributos**) associados a funções (**métodos**) que operam sobre essas variáveis.

Para criar (**instanciar**) um objeto do tipo T, use `new T()`. Exemplo (considerando um tipo chamado `Pessoa`):

```java
Pessoa fulano = new Pessoa();
Pessoa sicrano = new Pessoa();
```

Dizemos também que `fulano` e `sicrano` são **instâncias** de `Pessoa`.

---

# Acessando a atributos e métodos

- Para acessar **membros** (atributos e métodos) de um objeto, use um ponto (`.`)
- Exemplo: considere que objetos do tipo `Pessoa` possuem os atributos `altura` e `peso`, além do método `imc()`

```java
Pessoa fulano = new Pessoa();
fulano.altura = 1.70;
fulano.peso = 68.3;

Pessoa sicrano = new Pessoa();
fulano.altura = 1.60;
fulano.peso = 72.5;

double imc1 = fulano.imc();
double imc2 = sicrano.imc();
```

---

# Definindo uma classe

O tipo `Pessoa` não é nativo da linguagem Java. Ele deve ser definido através de uma classe.

Uma **classe** é uma estrutura que define atributos e métodos (e outras coisas) comuns a todos os objetos daquela classe. A classe `Pessoa` poderia ser definida assim:

```java
class Pessoa {
    // aqui estão os atributos
    double altura;
    double peso;
    boolean ehAdulto = true;

    // aqui está o método
    double imc() {
        return this.peso / (this.altura * this.altura);
    }
}
```

---

# Entendendo classes

```java
class Pessoa {
    double altura;
    double peso;
*   boolean ehAdulto = true;  // 1

    double imc() {
*       return this.peso / (this.altura * this.altura);  // 2
    }
}
```

1. Pode-se definir valores iniciais para atributos. No exemplo, todo objeto da classe `Pessoa` será criado com o atributo `ehAdulto` valendo `true`; se necessário, pode-se alterar seu valor.
2. Todo método recebe implicitamente um parâmetro chamado `this`, que é uma referência para o objeto que está sendo executado. Através do `this`, o método pode acessar outros membros (atributos e métodos) do objeto.

---

# `this` implícito

Em geral não é necessário usar o `this` para referenciar membros (atributos e métodos) do objeto atual; basta usar o nome do membro diretamente:

```java
class Pessoa {
    double altura;
    double peso;
    boolean ehAdulto = true;

    double imc() {
*       return peso / (altura * altura);
    }
}
```

---

# Atributos estáticos

Classes podem definir atributos **estáticos**. A diferença é que esses atributos não são vinculados aos objetos da classe, e sim à própria classe. Como resultado, temos a seguinte situação:

- Atributo não-estático: pode ter um valor diferente para cada objeto
- Atributo estático: todos os objetos acessarão o mesmo valor (que é o valor definido para a classe)

```java
class Pessoa {
    double altura;
    double peso;
*   static double fatorCorrecao = 1.05;

    double imc() {
*       return fatorCorrecao * peso / (altura * altura);
    }
}
```

---

```java
class Programa {
    void executa() {
        Pessoa fulano = new Pessoa();
        fulano.altura = 1.70;
        fulano.peso = 68.3;

        Pessoa sicrano = new Pessoa();
        fulano.altura = 1.60;
        fulano.peso = 72.5;

        System.out.println(fulano.imc());
        System.out.println(sicrano.imc());

        // Modifica o fator de correção
        // Isso afetará TODOS os objetos do tipo Pessoa.
        Pessoa.fatorCorrecao = 1.0;

        System.out.println(fulano.imc());
        System.out.println(sicrano.imc());
    }
}
```

(OBS.: `out` é um atributo estático da classe `System`)

---

# Atributos `final` (constantes)

É comum usar atributos estáticos para armazenar constantes. Atributos constantes são declarados com a palavra `final`. Exemplo:

```java
class Config {
    static final String diretorio = "/home/fulano";
}

class Programa {
    void executa() {
*       System.out.println(Config.diretorio);
*       Config.diretorio = "/home/sicrano";  // ERRO!
    }
}
```

Um exemplo de atributo estático final é o atributo `PI` da classe `Math`, que vale `3.141592653589793`.

---

# Métodos estáticos

Métodos estáticos são vinculados à classe. Consequências:

- Pode-se chamar métodos estáticos sem instanciar a classe onde estão definidos
- Métodos estáticos não recebem o parâmetro implícito `this`
- Métodos estáticos só podem referenciar diretamente membros (atributos e métodos) estáticos da classe

Um exemplo de método abstato é o método `cos` (cosseno) da classe `Math`:

```java
double x = Math.cos(Math.PI / 2);
```

(a propósito, PI é um atributo estático)

---

```java
class Pessoa {
    double altura;
    double peso;
    static double fatorCorrecao = 1.05;

    double imc() {
        return ajustado(peso / quadrado(altura));
    }

*   static double quadrado(double x) {
        return x * x;
    }

*   static double ajustado(double num) {
*       return fatorCorrecao * num;
    }
}
```

```java
class Programa {
    void executa() {
*       double a = Pessoa.quadrado(4);
*       double b = Pessoa.ajustado(23.6);
    }
}
```

---

Um método estático consegue acessar os membros não-estáticos de um objeto `Pessoa` se recebê-lo como parâmetro. Compare:

```java
class Pessoa {
    double altura;
    double peso;

    double imc(Pessoa p) {
        return peso / (altura * altura);
    }

*   double static calculaIMC(Pessoa p) {
*       return p.peso / (p.altura * p.altura);
*   }
}
```

Uso:

```java
Pessoa fulano = new Pessoa();
// ...
System.out.println(fulano.imc());
*System.out.println(Pessoa.calculaIMC(fulano));
```

</div>

---

