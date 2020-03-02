---
layout: remark
title: Enums
---

<div>

# Motivação

Às vezes criamos constantes para representar um status, tipo, categoria...

```java
class Pedido {
    int status;

*   static final int STATUS_PENDENTE = 1;
*   static final int STATUS_CONFIRMADO = 2;
*   static final int STATUS_ENTREGUE = 3;

    int getStatus() {
        return status;
    }
    void setStatus(int status) {
        if (status >= 1 && status <= 3) {
            this.status = status;
        }
    }
}
```

Isso torna o código do cliente mais legível:

```java
Pedido pedido = new Pedido();
*pedido.setStatus(Pedido.STATUS_CONFIRMADO);
```

---

# Motivação

Usar constantes ajuda, mas ainda é propenso a erros. Você, programador, é responsável por validar se o valor do atributo status é válido (no nosso exemplo, deve estar entre 1 e 3). O compilador não ajuda você nessa tarefa.

```java
// ...
    void setStatus(int status) {
*       if (status >= 1 && status <= 3) {
            this.status = status;
        }
    }
// ...
```

---

# Enum

Enum é uma estrutura similar a uma classe, que representa um conjunto de constantes. Exemplo:

```java
*enum StatusPedido {
	PENDENTE,
	CONFIRMADO,
	ENTREGUE
}
```

Essas constantes podem ser atribuídas e comparadas:


```java
*StatusPedido status1 = StatusPedido.PENDENTE;
StatusPedido status2 = StatusPedido.CONFIRMADO;

*if (status1 == StatusPedido.PENDENTE) {
    System.out.println("pendente");
}
if (status1 == status2) {
    System.out.println("mesmo status");
}
```

---

# Enum

Assim, podemos reescrever nossa classe `Pedido`:

```java
class Pedido {
    StatusPedido status;

    StatusPedido getStatus() {
        return status;
    }
    void setStatus(StatusPedido status) {
        this.status = status;
    }
}
```

---

# Enum

Usando enums, o compilador impede que valores inválidos de status sejam usados:

```java
Pedido pedido = new Pedido();
*pedido.setStatus(1);                    // ERRO de compilação
*pedido.setStatus(StatusPedido.PERDIDO); // ERRO de compilação
pedido.setStatus(StatusPedido.ENTREGUE); // OK
```

---

# Enum

Algumas enumerações possuem uma ordem natural. Exemplo:

```java
enum Prioridade {
    BAIXA, MEDIA, ALTA;
}
```

Não é possível comparar dois valores diretamente usando `<`, `>`, `<=`, `>=`, mas pode-se obter o mesmo efeito usando o método `ordinal()`, que retorna a posição do valor na enumeração. Exemplo:

```java
Prioridade prEstudar = Prioridade.ALTA;
Prioridade prTomarSorvete = Prioridade.BAIXA;
if (prEstudar.ordinal() > prTomarSorvete.ordinal()) {
    System.out.println("Muito bem!");
}
```

---

class: middle, center

# Tópicos avançados

---

# Implementação

Durante a compilação, cada enum é transformado em uma classe, e cada valor de uma enum é um objeto dessa classe.

Assim como classes, enums também podem ter construtores, métodos e atributos.

---

# Construtores, métodos e atributos

```java
enum StatusPedido {
    PENDENTE(10),
    CONFIRMADO(6),
    ENTREGUE(1);
    // 10, 6 e 1 são os parâmetros
    // do construtor

    int prioridade;

    // O construtor é sempre privado, pois
    // não deve ser invocado diretamente
    StatusPedido(int prioridade) {
        this.prioridade = prioridade;
    }

    int getPrioridade() {
        return prioridade;
    }
}
```

Exemplo de uso:

```java
StatusPedido s = StatusPedido.PENDENTE;
System.out.println(s.getPrioridade());
```

---

# Enums com construtores, métodos e atributos

Você também pode sobrepor o método `toString` para alterar a representação textual de cada valor de enum.

---

# Percorrendo os valores de um enum

```java
for (StatusPedido sp : StatusPedido.values()) {
    System.out.println(sp);
}
```

---

# Outros tópicos avançados

- Você pode definir métodos específicos para cada valor de um enum (para isso, crie um bloco de código após o nome do valor, `{ ... }`).
- Conjunto de valores de enum podem ser armazenados através da classe `EnumSet`.

</div>