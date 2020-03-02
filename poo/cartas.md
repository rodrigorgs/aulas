---
layout: remark
---

class: middle, center

# Jogo de paciência em Java

adaptado do livro "Introduction to Software Design with Java", de Martin P. Robillard

<!-- https://github.com/prmr/DesignBook -->

---

- Regras: <https://pt.wikipedia.org/wiki/Paci%C3%AAncia_(jogo)>
- Jogo online: <https://www.solitr.com/>

---

class: middle, center

# Carta de baralho

(Pré-requisitos: variáveis, classes, arrays, enums)

---

# Baralho (deque de cartas)

- Um baralho (ou deque de cartas) possui 52 cartas, cada uma com um **valor** e um **naipe**
- São 13 valores possíveis: A (às), 2, 3, 4, 5, 6, 7, 8, 9, 10, J (valete), Q (dama), K (rei)
- São 4 naipes possíveis: paus (♣), copas (<span style="color: red;">♥</span>), espadas (♠), ouros (<span style="color: red;">♦</span>)

---

# Como representar uma carta do baralho?

Podemos representar como um número inteiro entre 0 e 51. Exemplo:

```java
int carta = 13;   // 13 = Às de copas
```

Para extrair o naipe e o valor de uma carta, podemos usar o seguinte código:

```java
int naipe = carta / 13;  // 1 = copas
int valor = carta % 13;  // 0 = Às
```

Ao escrever um programa que usa cartas (ex.: jogo da paciência), precisaríamos realizar essas operações em várias partes do código.

---

# Como representar uma carta do baralho?

Poderíamos também representar como um par de inteiros, o primeiro representando o valor, e o segundo representando o naipe:

```java
int[] carta1 = {4, 0};  //  5 de paus
int[] carta2 = {4, 1};  //  5 de copas
```

Ainda assim, essa representação não é muito legível, pois nos obriga a sempre lembrar das convenções adotadas para representar naipes (ex.: 0 = paus, 1 = copas) e valores (ex.: 0 = às, 12 = rei).

---

# Quais são os problemas com essas representações?

- O conceito de carta não é representado de forma intuitiva. O tipo `int` é usado para representar números, e não cartas. Não é natural pensar em "carta 42", ou "carta 18".
- A representação é acoplada à sua implementação. No primeiro exemplo, todo código que manipula cartas trabalhará com inteiros e com operações de `/` e `%`. Se alterarmos a representação para um par de ints, deveremos alterar todo o código.
- As representações permitem valores inválidos. O que acontece se atribuirmos à variável `carta` o valor 128? Ou -5? 

---

# Representando um naipe

```java
enum Naipe {
    PAUS,
    COPAS,
    ESPADAS,
    OUROS
}
```

---

# Representando um valor

```java
enum Valor {
    AS, DOIS, TRES, QUATRO,
    CINCO, SEIS, SETE, OITO,
    NOVE, DEZ, VALETE,
    DAMA, REI
}
```

---

# Representando uma carta

```java
class Carta {
    Valor valor;
    Naipe naipe;
}
```

Exemplo de uso:

```java
Carta carta = new Carta();
carta.valor = Valor.AS;
carta.naipe = Naipe.COPAS;
```

---

# Vantagens

- Essa representação é intuitiva?
- É possível criar uma carta inválida?
- Se quisermos passar a usar um `int` para o valor (no lugar do enum), é preciso alterar várias partes do programa?
  - Por enquanto sim. Depois veremos como resolver isso.

---

class: middle, center

# Baralho

(Pré-requisitos: collections, construtores, visibilidade)

---

# Representando um baralho

Um baralho (conjunto de 52 cartas distintas) pode ser representado como uma lista de cartas:

```java
ArrayList<Carta> baralho = new ArrayList<>();
```

Quais são as desvantagens dessa abordagem?

---

# Desvantagens

- `ArrayList<Carta>` pode representar qualquer lista de cartas (ex.: mão de um jogador), e não apenas um baralho completo
- O uso de `ArrayList` é um detalhe de implementação; se decidirmos depois trocar por um array, precisaremos alterar várias partes do programa
- É possível gerar inconsistências, como baralhos com cartas faltando ou cartas duplicadas

---

# Representando um baralho (A FAZER)

```java

```