---
layout: remark
title: "Pacotes, modificadores de acesso, getters e setters"
---

<div>

# Pacotes

- As classes (e outros tipos, como interfaces e enums) ficam dentro de pacotes.
- Dentro de um pacote pode haver outros pacotes (estrutura hierárquica)
- Por convenção, os nomes dos pacotes são escritos em minúsculas

---

# Pacotes

- Cada pacote é representado por um diretório de mesmo nome
- Ex.: O pacote `br.ufba.dcc` é representado pelo diretório `br/ufba/dcc`
- Todos os arquivos `.java` dentro dessa pasta devem começar com a linha `package br.ufba.dcc`.

---

# Pacotes

- É comum estruturar os pacotes de acordo com a notação de nome de domínio reverso. Exemplo: se o site do seu software é <meuhorario.dcc.ufba.br>, você deve criar suas classes dentro do pacote `br.ufba.dcc.meuhorario`.
- O uso de um domínio praticamente elimina a chance de duas organizações escolherem o mesmo nome de pacote
- A ordem reversa ajuda a ordenar os pacotes (por exemplo, ao usar a ordem alfabética, `br.ufba.dcc.disciplinas` ficará perto de `br.ufba.dcc.meuhorario`)

---

# Modificadores de acesso

- Modificadores de acesso permitem restringir o acesso a membros (atributos, métodos, construtores) de uma classe por outras classes.
- Isso é importante para evitar que outras classes dependam de detalhes de implementação que podem mudar com o tempo.
- Os modificadores de acesso são `public`, `protected`, `private` e sem modificador (*package-private*)

---

# Modificadores de acesso

- Os membros públicos (`public`) podem ser acessados por qualquer classe
- Os membros privados (`private`) de uma classe só podem ser acessados pela própria classe
- Os membros privados ao pacote (sem modificador) de uma classe podem ser acessados por qualquer classe do mesmo pacote que ela
- Os membros protegidos (`protected`) de uma classe podem ser acessados por outras classes no mesmo pacote ou por subclasses.

---

# Modificadores de acesso

Ver resumo em <https://docs.oracle.com/javase/tutorial/java/javaOO/accesscontrol.html>

---

# Modificadores de acesso

- Ao definir uma classe, pode-se optar entre `public` e sem modificador (package-private)
- Uma classe pública pode ser acessada por qualquer classe
- Uma classe pública deve estar em um arquivo cujo nome é `<NomeDaClasse>.java`
- Uma classe package-private só pode ser acessada por classes dentro do mesmo pacote
- Exemplo

---

# Modificadores de acesso

- Ao criar uma classe, seja restritivo quanto aos modificadores de acesso.
- Em geral, atributos devem ser `private`, exceto no caso de constantes (que podem ser públicas)
- Ao criar atributos `private`, você terá flexibilidade para mudar detalhes do seu código.

---

# Getters e setters

- Uma vez que é boa prática definir os atributos como `private`, é comum criar métodos que permitam acessar esses atributos, de forma controlada. Esses métodos são chamados de *acessores*, e são divididos em *getters* e *setters*
- *Getters* são métodos que retornam o valor de um atributo e normalmente começam com `get` (no caso de atributos boleanos, `is`). Ex.: `String getName()`, `boolean isFinished()`
- *Setters* são métodos que permitem alterar o valor de um atributo e normalmente começam com `set`. Ex.: `void setName(String n)`

---

# Getters e setters

Exemplo:

```java
public class Termometro {
    private double temperatura; // em °C

    public double getTemperatura() {
        return temperatura;
    }

    public void setTemperatura(double temperatura) {
        this.temperatura = temperatura;
    }
}
```

---

# Getters e setters

- A IDE geralmente nos ajuda a criar automaticamente os getters e setters a partir dos atributos previamente definidos em uma classe.
- No Eclipse, use o menu `Source` > `Generate Getters and Setters...`

---

# Getters e setters

- Pode parecer a mesma coisa que simplesmente deixar o atributo `temperatura` público
- A diferença é que, se um dia resolvermos mudar a forma como representamos a temperatura, podemos alterar a implementação dos getters e setters de forma que os clientes não precisarão ser alterados.
- Além disso, podemos adicionar validações e regras no setter (ex.: limitar a temperatura a valores entre 0 e 100)

---

# Getters e setters

- Suponha que originalmente o atributo `temperatura` guardava a temperatura em graus `Celsius` (°C)
- Por alguma razão foi necessário mudar isso para guardar a temperatura em Kelvin (K)
- Para não impactar os clientes da classe `Temperatura`, os getters e setters farão automaticamente a conversão entre Kelvin e Celsius.

---

# Getters e setters

```java
public class Termometro {
    private double temperatura; // em Kelvin

    // retorna temperatura em °C
    public double getTemperatura() {
        return temperatura - 237.15;
    }

    // recebe temperatura em °C, armazena em Kelvin
    public void setTemperatura(double temperatura) {
        this.temperatura = temperatura + 237.15;
    }
}
```
</div>