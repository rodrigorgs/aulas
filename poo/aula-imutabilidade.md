---
layout: remark
title: "Imutabilidade e referências escapando"
---

# Equipe de atletas

Considere nosso exemplo anterior de equipe de atletas:

<div class="uml">
class Equipe {
    - atletas : ArrayList<Atleta>
    + imprimir()
    + addAtleta(a)
}
class Atleta {
    - nome : String
    - altura : double
    - peso : double
    + Atleta(n, p, a)
    + getNome() : String
    + getAltura() : double
    + getPeso() : double
    + getIMC() : double
}
</div>

---

# Equipe de atletas

Considere que a equipe não pode ter dois atletas com o mesmo nome. Essa restrição pode ser imposta no método `addAtleta(a)`:

```java
public void addAtleta(Atleta a) {
    for (Atleta atleta : atletas) {
        if (a.getNome().equals(atleta.getNome())) {
            return;
        }
    }
    atletas.add(a);
}
```

---

# Equipe de atletas

- Seguindo o princípio do encapsulamento, a lista de atletas, representada pelo atributo `atletas`, está escondido das outras classes.
- A única forma de interagir com a lista de atletas é através dos métodos `addAtleta()` e `imprimir()`
- Talvez isso esteja muito restritivo. E se meu programa quiser ter acesso à lista de atletas, para fazer alguma outra análise?
- Vamos criar um *getter*!

```java
class Equipe {
    // ...
    public ArrayList<Atleta> getAtletas() {
        return atletas;
    }
}
```

---

# Referências escapando

.left-column[
<div class="uml">
object programa {
}
object equipe {
}
object atletas {
}
programa --> equipe
equipe --> atletas
programa --> atletas
</div>
]
.right-column[
- Resolvemos nosso problema, mas criamos um problema ainda maior!
- Agora, os clientes de `Equipe` podem ter acesso ao objeto que guarda a lista de atletas, e podem inclusive **modificar a lista**!
- Pode-se dizer que
  - deixamos a referência à lista **escapar** para objetos de outras classes
  - quebramos o **encapsulamento**, uma vez que estamos dando acesso indesejado à representação interna do objeto
]

---

# Referências escapando

- Dessa forma, é impossível garantir que a equipe não terá dois atletas com o mesmo nome!
- Abaixo, um código que viola a restrição:

```java
public static void main(String[] args) {
    // ...
    ArrayList<Atleta> atletas = equipe.getAtletas();
    atletas.addAtleta(new Atleta("Fulano", 72, 1.80));
    atletas.addAtleta(new Atleta("Fulano", 97, 2.01));
}
```

---

# Solução 1: acesso de forma controlada

Para resolver o problema, podemos criar métodos para retornar cada um dos atletas:

```java
class Equipe {
    // ...
    public int getTamanho();
    public Atleta getAtleta(int posicao);
}
```

Assim, para acessar a lista de atletas:

```java
public static void main(String[] args) {
    // ...
*   int n = equipe.getTamanho();
    for (int i = 0; i < n; i++) {
*       Atleta atleta = equipe.getAtleta(i);
        // faz algo com o atleta
    }
}
```

---

# Solução 1: acesso de forma controlada

- Essa solução garante que nunca teremos atletas com mesmo nome na equipe?
- E se escrevermos o código a seguir?

```java
public static void main(String[] args) {
    // ...
    int n = equipe.getTamanho();
    for (int i = 0; i < n; i++) {
        Atleta atleta = equipe.getAtleta(i);
*       atleta.setNome("Fulano")
    }
}
```
--

- Nesse caso, violaríamos a nossa restrição
- Felizmente, esse código nem chega a compilar, pois a classe `Atleta` não possui o método `setNome` 
- De fato, a classe `Atleta` não possui nenhum *setter*; como, além disso, seus atributos são privados, é impossível alterar um objeto da classe `Atleta` após criá-lo
- Portanto, nossa classe `Equipe` obedece à restrição de que não pode haver dois atletas com o mesmo nome

---

class: middle, center, inverse

# Imutabilidade

---

# Imutabilidade

> Um objeto é **imutável** se o seu estado (valor dos atributos) não se altera depois de criado

Um objeto é **imutável** se:

- Os atributos são privados e inicializados no construtor
  - pode haver atributos públicos constantes (`final`), contanto que sejam imutáveis
- Não há nenhum método que permita alterar os atributos
- **Não escapa referências para objetos mutáveis**

Um exemplo são os objetos da classe `Atleta`:

<div class="uml">
class Atleta {
    - nome : String
    - altura : double
    - peso : double
    + Atleta(n, p, a)
    + getNome() : String
    + getAltura() : double
    + getPeso() : double
    + getIMC() : double
}
</div>

---

# Imutabilidade

.left-column[
<div class="uml">
object programa {
}
object atleta {
}
object nome {
}
atleta ..> nome
programa ..> atleta
programa ..> nome : x
</div>
]
.right-column[
Note que `Atleta.getNome()` deixa escapar uma referência para o atributo `nome`:

```java
public class Programa {
    public void analisa(Atleta a) {
        // ...
        String x = a.getNome();
    }
}
```

- A princípio, já que temos uma referência para o objeto `nome` (`String`), poderíamos alterá-lo, e dessa forma os objetos da classe `Atleta` não seriam imutáveis
- No entanto, os objetos da classe `String` são **imutáveis**
- Portanto, os objetos da classe `Atleta` também são **imutáveis**
]

---

class: middle, inverse, center

# Referências escapando: outras soluções

---

# Equipe de atletas

- Relembrando nosso exemplo, temos uma classe que representa uma equipe de atletas, na qual não pode haver atletas com o mesmo nome.
- Para garantir essa restrição, evitamos vazar uma referência para a lista de atletas (do tipo `ArrayList`, que é **mutável**)
  - Dessa forma, clientes da classe `Equipe` não conseguem alterar diretamente o conteúdo da lista; isso só pode ser feito através do método `addAtleta(a)`, que checa se já existe um atleta com o mesmo nome de `a` antes de adicioná-lo à lista
- Em vez disso, criamos o método `getAtleta(i)`, que retorna o atleta na posição `i`, sendo que objetos da classe `Atleta` são **imutáveis**
  - Dessa forma, clientes da classe `Equipe` não conseguem alterar o nome de um atleta já existente

<div class="uml">
class Equipe {
    - atletas : ArrayList<Atleta>
    + imprimir()
    + addAtleta(a)
    + getTamanho() : int
    + getAtleta(i) : Atleta
}
</div>

---

# Equipe de atletas

Essa solução funciona (garante que a restrição é respeitada), mas é inconveniente para o cliente, que precisa escrever código assim:

```java
// ...
int n = equipe.getTamanho();
for (int i = 0; i < n; i++) {
    Atleta atleta = equipe.getAtleta(i);
    // ...
}
```
--

Vamos explorar outras formas de atender à restrição. Queremos simplificar, de forma que o código do cliente fique assim:

```java
// ...
int n = equipe.getTamanho();
*for (Atleta atleta : equipe.getAtletas() {
    // ...
}
```


---

# Solução 2: retornar uma cópia da lista

<div class="uml">
class Equipe {
    - atletas : ArrayList<Atleta>
    + imprimir()
    + addAtleta(a)
    + getAtletas() : ArrayList<Atleta>
}
</div>

Nessa solução, criamos o método `getAtletas()`, que retorna uma **cópia** da lista de atletas:

```java
public class Equipe {
    public ArrayList<Atleta> getAtletas() {
        return (ArrayList<Atleta>) atletas.clone();
    }
}
```

---

# Solução 2: retornar uma cópia da lista

Nessa situação, o cliente de `Equipe` pode até modificar a lista retornada por `getAtletas()`, mas isso é irrelevante porque a lista original será preservada.

<div class="uml">
object programa {
}
object equipe {
}
object atletas {
}
object copiaDeAtletas {
}
programa --> equipe
programa --> copiaDeAtletas
equipe --> atletas
</div>

---

# Cópia rasa e cópia profunda

- Ao chamar `atletas.clone()`, estamos criando uma **cópia rasa** (*shallow copy*) da lista: a nova lista contém referência para os objetos originais da classe `Atleta`
  - Assim, estamos escapando referências para os atletas da equipe -- mas isso não é um problema, pois atletas são **imutáveis**
- Uma **cópia profunda** (*deep copy*) de uma lista é aquela na qual não somente é criada uma cópia da lista, mas também a nova lista referencia cópias dos elementos da lista original
  - Se nossa lista contivesse objetos mutáveis, precisaríamos criar uma cópia profunda para evitar que os clientes modificassem esses objetos

---

# Cópia rasa e cópia profunda

Cópia rasa:

<div class="uml">
object lista {
}
object a {
}
object b {
}
object c {
}
object copiaLista {
}
lista --> a
lista --> b
lista --> c
copiaLista --> a
copiaLista --> b
copiaLista --> c
</div>

Cópia profunda:

<div class="uml">
object lista {
}
object a {
}
object b {
}
object c {
}
object copiaA {
}
object copiaB {
}
object copiaC {
}
object copiaLista {
}
lista --> a
lista --> b
lista --> c
copiaLista --> copiaA
copiaLista --> copiaB
copiaLista --> copiaC
</div>

---

# Cópia rasa e cópia profunda

- Na **cópia profunda**, criamos uma cópia dos elementos da lista
- Mas note que a cópia dos elementos pode ser uma cópia rasa ou profunda
- Assim, ao falar em cópia profunda, faz sentido falar em níveis de profundidade

Considere o seguinte cenário:

<div class="uml">
object lista {
}
object a {
}
object b {
}
object x {
}
object y {
}
lista --> a
lista --> b
a --> x
b --> y
</div>

---

# Cópia rasa e cópia profunda

Cópia profunda de `lista` com um nível de profundidade:

<div class="uml">
object lista {
}
object copiaLista {
}
object a {
}
object b {
}
object copiaA {
}
object copiaB {
}
object x {
}
object y {
}
lista --> a
lista --> b
copiaLista --> copiaA
copiaLista --> copiaB
a --> x
b --> y
copiaA --> x
copiaB --> y
</div>

---

# Cópia rasa e cópia profunda

Cópia profunda de `lista` com dois níveis de profundidade:

<div class="uml">
object lista {
}
object copiaLista {
}
object a {
}
object b {
}
object copiaA {
}
object copiaB {
}
object x {
}
object y {
}
object copiaX {
}
object copiaY {
}
lista --> a
lista --> b
copiaLista --> copiaA
copiaLista --> copiaB
a --> x
b --> y
copiaA --> copiaX
copiaB --> copiaY
</div>

---

# Solução 3: coleções não-modificáveis

- Java possui um método estático `Collections.unmodifiableList(l)`, que retorna um *wrapper* (embrulho) para a lista `l`, que lança exceção sempre que chamamos um método que deveria modificar a lista (ex.: `add()`, `remove()`):
- Assim, nossa solução poderia ser assim:

```java
public class Equipe {
    public List<Atleta> getAtletas() {
        return Collection.unmodifiableList(atletas.clone());
    }
}
```

- A vantagem dessa solução é que ele não cria uma cópia da lista (o que pode ser custoso)
- Da mesma forma que na solução anterior, essa solução só atende porque os objetos do tipo `Atleta` são imutáveis

---

# Solução 3: coleções não-modificáveis

- Como listas não-modificáveis funcionam? O método `Collections.unmodifiableList(l)` retorna um objeto de uma outra classe (chamaremos de `UnmodifiableList`), que é implementada mais ou menos assim (isso é apenas uma simplificação!):

```java
public class UnmodifiableList {
    private List listaOriginal;
    // ...
    public int size() {
        return listaOriginal.size()
    }
    public void add(elemento) {
*       throw new UnsupportedOperationException();
    }
    // ...
}
```

- A lista não modificável possui uma referência para a lista original
- Ela delega os métodos de leitura para a lista original
- Nos métodos de modificação da lista, ela chama uma exceção
- Assim, garantimos que quem possuir uma referência para a lista não-modificável conseguirá ler a lista original, mas não conseguirá alterá-la

</div>
