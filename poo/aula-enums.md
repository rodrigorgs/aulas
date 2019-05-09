---
layout: page
title: Enums
---

# Motivação

Às vezes precisamos definir constantes para representar um status, tipo, categoria... Exemplo:

```java
public class Pedido {
    private int status;

    public static final int STATUS_PENDENTE = 1;
    public static final int STATUS_CONFIRMADO = 2;
    public static final int STATUS_ENTREGUE = 3;

    public int getStatus() {
        return status;
    }
    public void setStatus(int status) {
        if (status >= 1 && status <= 3) {
            this.status = status;
        }
    }
}
```

---

# Motivação

Criar constantes ajuda a tornar o código mais legível. Exemplos:

```java
Pedido pedido = new Pedido();
pedido.setStatus(Pedido.STATUS_CONFIRMADO);
```
ou:

```java
int pedidosEntregues = 0;
for (Pedido p : pedidos) {
    if (p.getStatus() == STATUS_ENTREGUE) {
        pedidosEntregues++;
    }
}
```

---

# Motivação

Usar constantes ajuda, mas ainda é propenso a erros. Você, programador, é responsável por validar se o valor do atributo status é válido (no nosso exemplo, deve estar entre 1 e 3). O compilador não ajuda você nessa tarefa.

---

# Enum

Enum é uma estrutura similar a uma classe, que representa um conjunto de constantes. Exemplo:

```java
public enum StatusPedido {
	PENDENTE,
	CONFIRMADO,
	ENTREGUE
}
```

Essas constantes podem ser atribuídas e comparadas.

---

# Enum

Usando a enum:

```java
StatusPedido status1 = StatusPedido.PENDENTE;
StatusPedido status2 = StatusPedido.CONFIRMADO;

if (status1 == StatusPedido.PENDENTE) {
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
public class Pedido {
    private StatusPedido status;

    public StatusPedido getStatus() {
        return status;
    }
    public void setStatus(StatusPedido status) {
        this.status = status;
    }
}
```

---

# Enum

Dessa forma, o compilador impede que valores inválidos de status sejam usados:

```java
Pedido pedido = new Pedido();
pedido.setStatus(1); // ERRO
pedido.setStatus(StatusPedido.PERDIDO); // ERRO
pedido.setStatus(StatusPedido.ENTREGUE); // OK
```

---

# Implementação

Durante a compilação, cada enum é transformado em uma classe, e cada valor de uma enum é um objeto dessa classe.

Enums também podem ter construtores, métodos e atributos.

---

# Enums com construtores, métodos e atributos

Exemplo:

```java
public enum StatusPedido {
    PENDENTE(10),
    CONFIRMADO(6),
    ENTREGUE(1);
    // 10, 6 e 1 são os parâmetros
    // do construtor

    int prioridade;

    // O construtor é sempre privado, pois
    // não deve ser invocado diretamente
    private StatusPedido(int prioridade) {
        this.prioridade = prioridade;
    }

    public int getPrioridade() {
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

# Tópicos avançados

- Você pode definir métodos específicos para cada valor de um enum (para isso, crie um bloco de código após o nome do valor, `{ ... }`).
- Conjunto de valores de enum podem ser armazenados através da classe `EnumSet`.
