---
layout: remark
title: Refatoração
---

<div>
# Definição

Refatoração (em inglês, refactoring) é o processo de modificar um sistema de software para melhorar a estrutura interna do código sem alterar seu comportamento externo.

---

# Refatoração

- O objetivo de refatorar é tornar o código mais fácil de compreender ou de modificar
- Indica-se que o sistema sendo refatorado possua *testes automatizados* para aumentar a confiança de que o sistema funciona da mesma forma antes e depois da refatoração
- Muitas IDEs possuem ferramentas que automatizam algumas refatorações, como renomear elementos do código, mover código para um novo método etc.
- O livro *Refactoring: Improving the Design of Existing Code*, de Martin Fowler, apresenta um catálogo de refatorações comuns

---

# Code smells

- *Code smell* (malcheiro de código) são características de um programa que indicam potenciais problemas e podem prejudicar a qualidade do programa
- Exemplos de code smells incluem *código duplicado* e *método longo*
- O livro *Refactoring: Improving the Design of Existing Code*, de Martin Fowler, apresenta um catálogo de *code smells*
- A refatoração é usada para remover *code smells*

---

# Refatoração: renomear método

- Problema: o nome do método não deixa claro o seu propósito
- Solução: renomear o método

---

# Refatoração: renomear método

Exemplo. Antes:

```java
public int soma(int x) {
    return x + 1;
}
```

Depois:

```java
public int incrementa(int x) {
    return x + 1;
}
```

---

# Refatoração: renomear método

Ao renomear um método, deve-se tomar o cuidado de trocar o nome do método nos pontos em que ele é chamado.

---

# Refatoração: renomear método

No Eclipse, clique com o botão direito sobre o nome do método, escolha `Refactor` > `Rename` e digite o novo nome. Todas as chamadas ao método dentro dos projetos abertos no Eclipse serão atualizadas.

---

# Refatoração: renomear variável, atributo, classe etc.

Da mesma forma que métodos, outros elementos de um programa podem ser renomeados.

---

# Refatoração: extrair método

Um método muito longo é difícil de compreender. É melhor dividir a lógica em vários métodos.

```java
public double calculaPrecoTotal(Collection<Item> items, boolean clienteVIP) {
    // calcula o somatório dos precos
    double total = 0.0;
    for (Item item : items) {
        total += item.getPreco();
    }

    // aplica desconto
    if (clienteVIP) {
        total *= 0.90;
    } else {
        total *= 0.95;
    }

    // adiciona taxa de entrega
    DayOfWeek diaSemana = LocalDate.now().getDayOfWeek();
    if (diaSemana == DayOfWeek.SUNDAY) {
        total += 10.00;
    } else {
        total += 5.00;
    }

    return total;
}
```

---

# Refatoração: extrair método

```java
public double calculaPrecoTotal(Collection<Item> items, boolean clienteVIP) {
    double total = calculaSomatorioDosPrecos(items);
    total = aplicaDesconto(clienteVIP, total);
    total = adicionaTaxaDeEntrega(total);
    return total;
}
```

Note que os comentários sumiram e o método não ficou mais difícil de entender por isso. Às vezes comentários são considerados malcheiro.

Exercício: faça a refatoração com e sem usar as ferramentas de refatoração do Eclipse.

---

# Refatoração: extrair superclasse

```java
public class Aluno {
    private String nome;
    private String cpf;
    private String matriculaSiac;
    private String curso;

    // construtor
    // getters e setters
}

public class Professor {
    private String nome;
    private String cpf;
    private String departamento;

    // construtor
    // getters e setters
}
```

- Refatoração: criar uma classe, Pessoa, que será superclasse de Aluno e Professor; mover nome e cpf (com seus getters e setters) para Pessoa.
- Exercício: faça a refatoração com e sem usar as ferramentas de refatoração do Eclipse (extract superclass).

---

# Outras refatorações comuns

- Mover membros para superclasse (pull up)
- Mover membros para subclasse (push down)
- Mover membros para outra classe (move)
- Mover membros para uma nova classe (extract class)
- Extrair interface (extract interface)

</div>