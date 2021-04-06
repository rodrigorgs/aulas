---
layout: remark
title: Collections
---

<div>

# Collections

- No Java, Collections são um conjunto de classes e outras entidades que representam grupos de objetos (também chamados de coleções).
- Há classes que implementam estruturas de dados como listas, pilhas, filas, árvores, conjuntos, dentre outras.
- Algumas coleções são ordenadas, outras não
- Algumas coleções permitem elementos duplicados, outras não

---

# Collections

- Algumas classes:
    - `ArrayList`: array que se redimensiona de acordo com a necessidade
    - `Vector`: similar a `ArrayList`, porém mais apropriada a programas *multithreaded*
    - `LinkedList`: lista encadeada simples
    - `HashSet`: conjunto (não permite elementos duplicados), a ordem dos elementos não é definida
    - `TreeSet`: conjunto (não permite elementos duplicados) em que elementos são ordenados automaticamente

---

# Criação

Ao criar uma coleção, pode-se especificar (entre `<` e `>`) de que **classe** serão os seus elementos. Exemplo:

```java
ArrayList<Double> numeros = new ArrayList<Double>();
// pode-se informar o tipo apenas na declaração,
// e não na instanciação:
HashSet<Aluno> alunos = new HashSet<>();

// Se não informar, será usada a classe Object
Vector vetor = new Vector(); // é igual a
Vector<Object> vetor = new Vector<>();
```

> Collections **não** armazenam **tipos primitivos**

---

# Inserção

Em qualquer coleção usa-se o método `add(elemento)` para adicionar um elemento à coleção. Exemplo:

```java
ArrayList<Double> numeros = new ArrayList<>();
numeros.add(3);
numeros.add(3);
numeros.add(1);
numeros.add(2);
```

---

# Iteração

Pode-se iterar sobre uma coleção usando o `for` aprimorado:

```java
ArrayList<Double> numeros = new ArrayList<>();
numeros.add(3);
numeros.add(3);
numeros.add(1);
numeros.add(2);
for (Double numero : numeros) {
    System.out.println(numero);
}
```

Experimente trocar `ArrayList` por outras coleções e veja o resultado!


---

# Métodos existentes em todas as coleções

**Modificação**:

+ `add(elemento)` - adiciona elemento à coleção
+ `addAll(colecao)` - adiciona todos os elementos de uma outra coleção a esta coleção
+ `remove(obj)` - remove uma ocorrência do objeto obj
+ `removeAll`, `removeIf`, `retainAll`...
+ `clear()` - remove todos os elementos

---

# Métodos existentes em todas as coleções

**Consulta**:

+ `contains(obj)` - indica se a coleção contém o objeto obj
+ `containsAll(col)` - indica se a coleção contém todos os elementos da colecao `col`
+ `size()` - número de elementos na coleção
+ `isEmpty()` - verdadeiro de size() == 0

---

# Métodos existentes em todas as coleções

**Conversão**:

+ `toArray()` - retorna um array com os mesmos elementos da coleção, do tipo `Object[]`
+ `toArray(T[] x)` - retorna um array do tipo `T` com os mesmos elementos da coleção. Exemplo: `String[] x = lista.toArray(new String[0]);`
+ todas as coleções possuem um construtor que recebe uma coleção e cria uma coleção com os mesmos elementos. Exemplo: `ArrayList<String> a = new ArrayList<>(); Vector<String> b = new Vector<>(a);`

---

# Métodos existentes em ALGUMAS coleções

+ `get(i)` - retorna o elemento na posição `i` (indexado a partir de zero)
+ `firstElement()`/`lastElement()` - retorna o primeiro/último elemento
+ `indexOf(elem)`/`lastIndexOf(elem)` - retorna a posição da primeira/última ocorrência do elemento `elem`

---

# Classe Collections

A classe `Collections` possui diversos métodos estáticos que implementa operações úteis sobre coleções, como `sort`, `binarySearch`, `frequency`, `max`, `min`, `replaceAll`, `reverse`, `rotate`, `shuffle`, `swap`. Veja a documentação da classe para entender o que cada método faz.

---

# HashMap

Mostrar em aula

---

# Exercício em sala

Crie um programa que lê um arquivo com dados de cursos e disciplinas da UFBA ([`dados.txt`](https://raw.githubusercontent.com/rodrigorgs/aulas/master/mata37/web/dados.txt)) e cria objetos com esses dados. Classes:

- Universidade: nome, addCurso(), imprime(), qtdDisciplinas()
- Curso: codigo, nome, addDisciplina(), getDisciplinas(), imprime(), qtdDisciplinas()
- Disciplina: codigo, nome, semestre, natureza, ch, curriculo, imprime()
</div>