---
layout: remark
title: "Java: orientação a objetos"
---

<div>

Uma classe define um novo **tipo** em um programa, com dados (**atributos**) e comportamento (**métodos**) de um tipo de dados

Atributos e métodos são coletivamente chamados de **membros** da classe

A partir de uma classe são criados **objetos**, também chamados de **instâncias** da classe

Uma classe também possui **construtores**, que são métodos chamados no momento da criação de um objeto

---

.left-50[
```java
// Definição de uma classe
class Pessoa {
    // atributos
    String nome;
    int anoNascimento;

    // construtor
    Pessoa(String n, int a) {
        nome = n;
        anoNascimento = a;
    }

    // método
    void cumprimentar() {
        System.out.println("Oi, " + nome);
    }
}
```
]
.right-50[
```java
// Instancia um objeto do tipo Pessoa e
// atribui à variável p1, do tipo
// Pessoa.
// Nesse momento o construtor de Pessoa
// é chamado
Pessoa p1 = new Pessoa("Fulano", 2000);

// Cria outro objeto do tipo Pessoa.
Pessoa p2 = new Pessoa("Sicrana", 2005);

// Chama o método cumprimentar() de
// Pessoa no contexto do objeto p1
p1.cumprimentar();
```
]

</div>