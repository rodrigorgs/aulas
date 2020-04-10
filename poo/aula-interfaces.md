---
layout: remark
title: "Interfaces e tipos"
---

<!-- 
Interface estabelece um contrato: condições para cumprir
algumas condições o compilador consegue checar, outras não
 -->

<div>

# Interfaces e tipos

---

class: middle, center, inverse

# Interfaces (programação)

---

# Interface

> Em programação, **interface** é uma **especificação**, contendo **declarações** de funções (nome, parâmetros, tipo de retorno) e variáveis/constantes que podem ser usadas por outros módulos de um programa

Em geral, diferencia-se a **interface** (declaração) da **implementação** (corpo da função). Exemplo em C:

.left-50[
### Interface

```c
// Esta função calcula...
int divisao(int a, int b);
```]
.right-50[
### Implementação

```c
int divisao(int a, int b) {
    // implementação:
*   return a / b;
}
```
]

---

# A interface define um contrato

- Uma interface define um **contrato** entre a pessoa que escreveu a função (**fornecedor**) e a pessoa que vai usar a função (**cliente**)
- O contrato define as obrigações do cliente (**pré-condições**) e as garantias do fornecedor (**pós-condições**)
- Lógica: se, ao usar a função, o cliente obedecer às pré-condições, o fornecedor garante que o resultado respeitará as pós-condições
- Parte desse contrato é especificada pela declaração, parte é especificada em texto, na documentação da função

---

# A interface define um contrato

```c
// Esta função calcula...  <-- ISTO É PARTE DO CONTRATO
int divisao(int a, int b);
```

**Pré-condições**:

  1. devem ser fornecidos dois números\*
  2. os números devem ser do tipo `int`\*
  3. o segundo número não pode ser zero
--


**Pós-condições**:

  4. o resultado será a parte inteira do quociente entre os dois números
  5. o resultado será do tipo `int`\*
--


As condições com \* são especificadas na **declaração** da função e são checadas pelo **compilador**.

As demais condições são especificadas na **documentação** da função e é responsabilidade do **programador** checar se elas estão sendo atendidas.

---

# Interface

A mesma ideia pode ser aplicada a classes:

### Interface pública (declarações)

```java
public class Orcamento {
    private Produto[] produtos;
    private Servico[] servicos;
*   public double getValorTotal() {
        double total = 0.0;
        for (Produto produto : produtos) {
            total += produto.getValor();
        }
        for (Servico servico : servicos) {
            total += servico.getValor();
        }
        return total;
    }
*   public void imprimir() {
        System.out.println("Orçamento");
    }
}
```

---

# Interface

A mesma ideia pode ser aplicada a classes:

### Implementação

```java
public class Orcamento {
    private Produto[] produtos;
    private Servico[] servicos;
    public double getValorTotal() {
*       double total = 0.0;
*       for (Produto produto : produtos) {
*           total += produto.getValor();
*       }
*       for (Servico servico : servicos) {
*           total += servico.getValor();
*       }
*       return total;
    }
    public void imprimir() {
*       System.out.println("Orçamento");
    }
}
```

---

# Exemplo fora da programação

.left-column[
<img src="{{site.baseurl}}/poo/images/plugue.webp" style="width: 200px"></img>
]
.right-column[
- O padrão de tomadas do Brasil define uma interface para conexão de aparelhos elétricos a pontos de energia elétrica
- Esse padrão define o formato e posição dos pinos, a função de cada pino (terra, fase, neutro), entre outras coisas
- Você não consegue ligar um plugue norte-americano na tomada brasileira
- Nada impede de você inverta a polaridade (o que seria uma quebra do contrato e pode causar problemas)
]

---

class: middle, center, inverse

# Exemplo motivador

---

# Exemplo: orçamento

Estamos criando um sistema para gerenciar **orçamentos** de obras. Um orçamento pode conter tanto **produtos** (tinta, tijolo etc.) quanto **serviços** (pintura, assentamento de piso etc.). Cada produto e serviço possui um valor.

<div class="uml">
class Produto {
    - descricao
    - valorUnitario
    - quantidade
    + getDescricao()
    + getValor()
}

class Servico {
    - descricao
    - dataAgendada
    - valor
    + getDescricao()
    + getValor()
}

class Orcamento {
    - produtos
    - servicos
    + imprimir()
    + getValorTotal()
}
Orcamento --> Produto
Orcamento --> Servico
</div>

---

# Exemplo: orçamento

```java
public class Orcamento {
    private Produto[] produtos;
    private Servico[] servicos;
*   public double getValorTotal() {
        double total = 0.0;
        for (Produto produto : produtos) {
*           total += produto.getValor();
        }
        for (Servico servico : servicos) {
*           total += servico.getValor();
        }
        return total;
    }
}
```
--

- Percebeu uma certa **duplicação** de código?
- Do ponto de vista da classe `Orcamento`, a distinção entre produtos e serviços é irrelevante: ambos são coisas que têm valor (`getValor()`)
- Como pertencem a classes diferentes, precisam ficar em listas separadas e são tratados separadamente

---

# Exemplo: orçamento

O que queremos é escrever um código mais ou menos assim (pseudocódigo):

```java
public class Orcamento {
*   private ProdutoOuServico[] itens;

    public double getValorTotal() {
        double total = 0.0;
*       for (ProdutoOuServico item : itens) {
*           total += item.getValor();
*       }
        return total;
    }
}
```

Ao mesmo tempo, não queremos juntar as classes `Produto` e `Servico` em uma só (pois essa distinção pode ser importante em outras partes do sistema)

---

class: middle, center, inverse

# Interfaces (Java)

---

# Interface em Java

Em Java, **interface** é uma estrutura que contém apenas a **declaração** de métodos públicos, **sem** as respectivas **implementações**

Assim como uma classe, uma interface define um **tipo de dados** 

Diferentemente de uma classe, uma interface **não pode** ser **instanciada**

Interfaces são úteis para tratar objetos de diferentes classes de maneira **uniforme**

---

# Exemplos de interface

```java
// Nó de uma árvore
public interface No {
    No getPai();
    No[] getFilhos();
}

// Coisa que pode ser comprada ou contratada
public interface Pagavel {
    double getValor();
}

// Coisa que possui uma descrição
public interface Descrevivel {
    String getDescricao();
}
```

> Ao declarar os métodos de uma interface, não é preciso escrever `public` (isso está implícito)

---

# Classes implementam interfaces

- Podemos declarar que uma classe **implementa** uma interface.
- Para isso, escreve-se, depois do nome da classe, `implements NomeDaInterface`. Exemplo:

```java
*public class Produto implements Pagavel {
    // ...
}
```

Isso tem duas consequências:

- A classe `Produto` deve fornecer uma **implementação** para **todos os métodos** da interface `Pagavel` (do contrário, dá erro de compilação)
- Todo objeto do tipo `Produto` passa a ser também um objeto do tipo `Pagavel`

(A implementação pode até ser vazia, mas o programador deve criar essa implementação vazia, explicitamente)

---

# Classes implementam interfaces

De fato, uma classe pode implementar mais de uma interface:

```java
public class Pessoa implements Descrevivel, No {
    // ...
    public String getDescricao() { /* ... */ }

    public No getPai()  { /* ... */ }
    public No[] getFilhos()  { /* ... */ }
}
```

---

# @Override

Convencionalmente, escreve-se `@Override` acima da implementação de métodos que foram especificados por interfaces que estamos implementando:

```java
public class Produto implements Pagavel {
    // ...
*   @Override
    public double getValor() {
        return precoUnitario * quantidade;
    }
}
```

A anotação `@Override` é opcional mas desejável. Ao usarmos `@Override`, se por acaso escrevermos o nome do método errado (ex.: `getVAlor()`), o compilador vai dar erro, informando que o método `getVAlor()` não está implementando nenhum método da interface. (Mais sobre isso quando estudarmos herança)

---

# Interfaces definem tipos de dados

Considerando o exemplo anterior, as seguintes linhas estão corretas:

```java
Produto p1 = new Produto();
Pagavel p2 = new Produto(); // uma instância de Produto é do tipo Pagavel
```
--

No entanto, a seguinte linha está **incorreta**:

```java
Pagavel p3 = new Pagavel(); // erro de compilação!
```

Interfaces **não podem ser instanciadas**! Se pudessem, o que aconteceria quando chamássemos um de seus métodos?

---

# Tratando duas classes de maneira uniforme

Tanto produtos e serviços possuem valor (ainda que o cálculo do valor seja **implementado** de maneira diferente). Assim, podemos fazer com que ambas implementem a interface `Pagavel`:

```java
*public class Produto implements Pagavel {
    // ...
    public double getValor() {
        return precoUnitario * quantidade;
    }
}
*public class Servico implements Pagavel {
    // ...
    public double getValor() {
        return valor;
    }
}
```

---

# Tratando duas classes de maneira uniforme

Desta forma, conseguimos misturar produtos e serviços em um mesmo vetor. Exemplo:

```java
Produto p = new Produto();
Servico s = new Servico();
Pagavel[] itens = new Pagavel[2];
itens[0] = p;
itens[1] = s;
System.out.println(itens[0].getValor());
System.out.println(itens[1].getValor());
```

---

# Tratando duas classes de maneira uniforme

Também conseguimos passar produtos e serviços como parâmetro para métodos que esperam `Pagavel`:

```java
public static Pagavel maisBarato(Pagavel a, Pagavel b) {
    if (a.getValor() <= b.getValor()) {
        return a;
    } else {
        return b;
    }
}
// ...
Produto p = new Produto("Armário pronto", 500.0);
Servico s = new Servico("Marcenaria", 800.0);

Pagavel escolhido = maisBarato(p, s);
```

---

# Tratando duas classes de maneira uniforme

Agora podemos simplificar a classe `Orcamento`. **Antes**:

```java
public class Orcamento {
*   private Produto[] produtos;
*   private Servico[] servicos;
    public double getValorTotal() {
        double total = 0.0;
*       for (Produto produto : produtos) {
*           total += produto.getValor();
*       }
*       for (Servico servico : servicos) {
*           total += servico.getValor();
*       }
        return total;
    }
}
```

---

# Tratando duas classes de maneira uniforme

Agora podemos simplificar a classe `Orcamento`. **Depois**:

```java
public class Orcamento {
*   private Pagavel[] itens;
    public double getValorTotal() {
        double total = 0.0;
*       for (Pagavel item : itens) {
*           total += item.getValor();
*       }
        return total;
    }
}
```

---

class: middle, inverse, center

# Exemplo real: ordenação em Java

---

# Método sort

- Ordenar listas de coisas é uma tarefa muito comum na computação
- Java possui dois métodos estáticos para isso, `Collections.sort(colecao)` (para ordenar uma collection) e `Arrays.sort(vetor)` (para ordenar um vetor). Exemplo:

```java
String[] letras = {"g", "s", "a", "x", "b"};
*Arrays.sort(letras);
for (String letra : letras) {
    System.out.println(letra);
}

ArrayList<Integer> numeros = new ArrayList<>();
numeros.add(4);
numeros.add(2);
numeros.add(5);
*Collections.sort(numeros);
for (Integer numero : numeros) {
    System.out.println(numero);
}
```
--


- Os métodos `sort` conseguem ordenar listas de strings, de inteiros...
- Eles conseguem ordenar listas de `Produto`?

---

# Interface `Comparable`

- Os métodos `sort` conseguem ordenar listas de **qualquer tipo**, contanto que esse tipo implemente a interface `Comparable` (em português, *comparável*):

```java
public interface Comparable<T> {
    /*
     * Retorna número negativo, se this < outro,
     *         número zero,     se this == outro,
     *         número positivo, se this > outro
     */
    int compareTo(T outro);
}
```

---

# Interface `Comparable`

Assim, se queremos ordenar uma lista de produtos, a classe `Produto` deve implementar a interface `Comparable`. Exemplo (ordem crescente de valor):

```java
public class Produto implements Comparable<Produto> {
    private double valor;
    // ...
    public int compareTo(T outro) {
        return valor - outro.valor;
    }
}
```

---

# Interface `Comparator`

- Ao implementar a interface `Comparable` em uma classe, definimos um único critério de ordenação dos objetos dessa classe (denominado **critério natural de ordenação**).
- E se tivermos **vários critérios** de ordenação? Uma hora quero ordenar por preço, outra hora quero ordenar por descrição...
--

- Os métodos `sort` possuem uma versão com dois parâmetros, `sort(lista, comparador)`, em que comparador é um objeto do tipo `Comparator`, que implementa um critério de ordenação
- Assim, podemos ordenar a lista segundo diversos critérios, bastando passar comparadores diferentes

---

# Interface `Comparator`

```java
public interface Comparator<T> {
    /*
     * Retorna número negativo, se o1 < o2,
     *         número zero,     se o1 == o2,
     *         número positivo, se o1 > o2
     */
    int compare(T o1, T o2);
}
```

---

# Usando o `Comparator`

Vamos definir um novo critério de ordenação para produtos:

```java
public class ComparadorDeDescricoes implements Comparator<Produto> {
    public int compare(Produto p1, Produto p2) {
        // usa a ordenação natural de strings
        return p1.getDescricao().compareTo(p2.getDescricao());
    }
}
```
--

Agora, vamos ordenar produtos de acordo com esse critério:

```java
Produto[] produtos = new Produto[] { /* ... */ }

ComparadorDeDescricoes comparador = new ComparadorDeDescricoes();
Array.sort(produtos, comparador);
```

Note que, nesse caso, o critério natural de ordenação (definido pela interface `Comparable`) é ignorado

---

class: middle, inverse, center

# Mais sobre interfaces

---

# Outro exemplo: imprimir orçamento

Qual o problema com o código abaixo?

```java
public class Orcamento {
    private Pagavel[] itens;
    public double getValorTotal() {
        // ...
    }
*   public void imprimir() {
*       for (Pagavel item : itens) {
*           System.out.println(item.getDescricao() + " " + item.getPreco());
*       }
*   }
}
```
--

- **Erro de compilação**: a interface `Pagavel` não possui o método `getDescricao()`!
- Ainda que nosso vetor só possua objetos com descrição (i.e., produtos e serviços), o compilador não tem como garantir isso (afinal, pode existir outra classe que implementa `Pagavel` mas não tem descrição)
- A interface `Descrevivel` possui o método `getDescricao()`, mas não possui `getValor()`
- Vamos criar uma nova interface que combina `Pagavel` e `Descrevivel`

---

# Herança de interfaces

A palavra-chave `extends` permite criar uma interface que combina as declarações de múltiplas interfaces. Exemplo:

```java
public interface Animal {
    void anda();
}
public interface Mamifero extends Animal {
    void mama();
}
```

> A interface `Mamifero` é dita uma **subinterface** da interface `Animal`. Já `Animal` é uma **superinterface** de `Mamifero`.

Consequências:

- Todos os objetos de classes que implementam `Mamifero` respondem às mensagens `anda()` e `mama()` (portanto, a classe deve implementar ambos os métodos)
- Todos os objetos que possuem o tipo `Mamifero` também possuem o tipo `Animal`

---

# Herança de interfaces

No exemplo do orçamento, podemos considerar que um item de orçamento possui descrição e preço:

```java
public interface Pagavel {
    double getValor();
}
public interface Descrevivel {
    String getDescricao();
}
public interface ItemDeOrcamento extends Pagavel, Descrevivel {
}
```

Além disso, `Produto` e `Servico` agora implementarão a nova interface:

```java
public class Produto implements ItemDeOrcamento {
    // ...
}
public class Servico implements ItemDeOrcamento {
    // ...
}
```

---

# Herança de interfaces

.left-column[
<div class="uml">
interface Pagavel {
    + getValor()
}
interface Descrevivel {
    + getDescricao()
}
interface ItemDeOrcamento extends Pagavel, Descrevivel {
}
class Produto implements ItemDeOrcamento {
    - descricao
    - valorUnitario
    - quantidade
    + getDescricao()
    + getValor()
}
class Servico implements ItemDeOrcamento {
    - descricao
    - dataAgendada
    - valor
    + getDescricao()
    + getValor()
}
</div>
]
.right-column[
- Considere o método `efetuaPagamento(Pagavel p)`
- Podemos passar um objeto do tipo `Servico` como parâmetro?
]

---

# Herança de interfaces

.left-column[
<div class="uml">
interface Pagavel {
    + getValor()
}
interface Descrevivel {
    + getDescricao()
}
interface ItemDeOrcamento extends Pagavel, Descrevivel {
}
class Produto implements ItemDeOrcamento {
    - descricao
    - valorUnitario
    - quantidade
    + getDescricao()
    + getValor()
}
class Servico implements ItemDeOrcamento {
    - descricao
    - dataAgendada
    - valor
    + getDescricao()
    + getValor()
}
</div>
]
.right-column[
- Considere o método `efetuaPagamento(Pagavel p)`
- Podemos passar um objeto do tipo `Servico` como parâmetro?
- Todo objeto do tipo `Servico` também é do tipo `ItemDeOrcamento`
- Todo objeto do tipo `ItemDeOrcamento` também é do tipo `Pagavel`
- Logo, todo objeto do tipo `Servico` também é do tipo `Pagavel`
- Portanto, sim, podemos!
]
---

# Determinando os tipos de um objeto

Podemos determinar se um objeto possui determinado tipo escrevendo `objeto instanceof Tipo`.

.left-column[
<div class="uml">
interface Pagavel {
}
interface Descrevivel {
}
interface ItemDeOrcamento extends Pagavel, Descrevivel {
}
class Produto implements ItemDeOrcamento {
}
class Servico implements ItemDeOrcamento {
}
</div>
]
.right-column[
```java
Produto p = new Produto();
System.out.print(p instanceof Produto);        //=> true
System.out.print(p instanceof ItemDeOrcamento);//=> true
System.out.print(p instanceof Pagavel);        //=> true
System.out.print(p instanceof Descrevivel);    //=> true
System.out.print(p instanceof Servico);        //=> false
System.out.print(p instanceof String);         //=> false
```
]

---

# Casting

Considere o seguinte método estático:

```java
public static double calculaTotal(Pagavel[] pagaveis) {
    double total = 0.0;
    for (Pagavel pagavel : pagaveis) {
*       System.out.println("Somando pagavel:");
*       System.out.println(pagavel.getValor());
        total += pagavel.getValor();
    }
    return total;
}
```

- Ele calcula o valor total de um vetor de pagáveis
- Adicionamos alguns prints para "debugar" o programa
- Queremos imprimir também a descrição dos pagáveis, mas nem todos os pagáveis possuem descrição (somente aqueles que implementam a interface `Descrevivel`)

---

# Casting

Qual o problema com o seguinte código?

```java
public static double calculaTotal(Pagavel[] pagaveis) {
    double total = 0.0;
    for (Pagavel pagavel : pagaveis) {
        System.out.println("Somando pagavel:");
*       System.out.println(pagavel.getDescricao());
        System.out.println(pagavel.getValor());
        total += pagavel.getValor();
    }
    return total;
}
```

**Erro de compilação**! A interface `Pagavel` não declara o método `getDescricao()`

---

# Casting

- Para conseguir chamar o método `getDescricao()` do objeto, podemos usar o recurso de *casting* para tratar o objeto pagável como se fosse um descrevível
- Qual o problema com o seguinte código?

```java
public static double calculaTotal(Pagavel[] pagaveis) {
    double total = 0.0;
    for (Pagavel pagavel : pagaveis) {
        System.out.println("Somando pagavel:");
*       System.out.println(((Descrevivel)pagavel).getDescricao());
        System.out.println(pagavel.getValor());
        total += pagavel.getValor();
    }
    return total;
}
```

- O código compila, mas se passarmos algum objeto que possui o tipo `Pagavel` mas não possui o tipo `Descrevivel`, o programa lançará a exceção `ClassCastException`.

---

# Casting

- Antes de fazer o cast, devemos verificar se isso é válido:

```java
public static double calculaTotal(Pagavel[] pagaveis) {
    double total = 0.0;
    for (Pagavel pagavel : pagaveis) {
        System.out.println("Somando pagavel:");
*       if (pagavel instanceof Descrevivel) {
*           System.out.println(((Descrevivel)pagavel).getDescricao());
*       }
        System.out.println(pagavel.getValor());
        total += pagavel.getValor();
    }
    return total;
}
```

---

class: middle, inverse, center

# Exemplo real: Collections

---

# Interface Collection

Em Java, todas as listas de elementos (exceto arrays) implementam (direta ou indiretamente) a interface `Collection`:

```java
public interface Collection<E> {
    int size();
    boolean isEmpty();
    boolean contains(Object o);
    boolean add(E e);
    boolean remove(Object o);
    void clear();
    // ... e outros métodos
}
```

Ou seja, não importa se seu objeto é da classe `ArrayList`, `Vector`, `HashSet`... Todos eles implementam esses métodos

---

# Escrevendo código mais genérico

Se você quer escrever um método que pode receber qualquer coleção de elementos, use o tipo `Collection`. Exemplo:

```java
public class Exemplo {
    public static String stringMaisCurta(Collection<String> lista) {
        // ...
    }

    public static void main(String[] args) {
        ArrayList<String> x1 = new ArrayList<>();
        HashSet<String> x2  = new HashSet<>();
        // ...
        System.out.println(stringMaisCurta(x1));
        System.out.println(stringMaisCurta(x2));
    }
}
```

Só use um tipo mais específico (ex.: `ArrayList`) se realmente seu método só funciona com esse tipo.

---

# Subinterfaces de Collection

.left-column[
<div class="uml">
interface Collection {
    size()
    isEmpty()
    contains(o)
    add(e)
    remove(o)
    clear()
    ...()
}
interface Set extends Collection {
    (sem elementos
    duplicados)
}
interface List extends Collection {
    get(i)
    indexOf(obj)
    ...()
}
</div>
]
.right-column[
- Nem todas as coleções permitem acessar diretamente um elemento a partir de seu índice -- método `get(i)`
- A interface `List` estende `Collection` e adiciona métodos para acesso direto
- Classes como `ArrayList` e `Vector` implementam a interface `List`
- A interface `Set` não possui nenhum método a mais em relação a `Collection`, mas seu contrato estabelece uma condição a mais: a coleção não guarda elementos duplicados
]

---

# Boa prática: declarar tipos mais genéricos

- Ao declarar variáveis ou atributos que representam coleções, use o tipo mais genérico possível. Vantagens:
  - Você poderá trocar a implementação da coleção no futuro
  - O compilador avisará se você estiver usando algum método que não faz parte da coleção
- Exemplo: suponha que você tem uma coleção de Strings e a única coisa que você faz é iterar sobre essa coleção

```java
ArrayList<String> colecao = new ArrayList<>()
// ...
for (int i = 0; i < colecao.size(); i++) {
    System.out.println(colecao.get(i));
}
```

Você precisa mesmo usar o método `get()`, que é específico de listas?

---

# Boa prática: declarar tipos mais genéricos

Mude o tipo declarado para `Collection`:

```java
*Collection<String> colecao = new ArrayList<>()
// ...
for (int i = 0; i < colecao.size(); i++) {
    System.out.println(colecao.get(i));
}
```

- **Erro de compilação**: `Collection` não declara o método `get()`
--

- Troque por uma iteração simples:

```java
Collection<String> colecao = new ArrayList<>()
// ...
*for (String s : colecao)
*   System.out.println(s);
}
```

No futuro será fácil trocar a implementação por `Vector`, `LinkedList`, `TreeSet` ou outra...

<!-- 

- Múltiplas interfaces
- Herança de interfaces
- Interface Collection
- Outro exemplo: padrão de tomada
- up/downcasting
- instanceof
 -->

</div>

