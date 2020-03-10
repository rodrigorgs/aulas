---
layout: remark
title: "Programação procedural em Java"
---

<div>

# Programação procedural em Java

- Nesta aula vamos aprender o básico da linguagem de programação Java, ignorando a maioria dos conceitos de orientação a objetos (serão abordados depois)
  - Escreveremos programas no paradigma procedural em Java
- Os primeiros exemplos desta aula são simples e envolvem poucas linhas de código
- Para executar as linhas de código, uma a uma, vendo o resultado instantaneamente, usaremos o **JShell**. Para executar:
  - Digite `jshell` na linha de comando (a partir do JDK 9); ou
  - Acesse <https://tryjshell.org/>
- Alternativamente, crie um programa simples para testar as linhas de código:

```java
// Arquivo Exercicios.java
public class Exercicios {
    public static void main(String[] args) {
      // seu código aqui
    }
}
```

---

# Comentários

Texto direcionado a programadores, ignorado pelo compilador

Comentário de uma linha (igual a C): 

```java
// isto é um comentário
```

Comentário de múltiplas linhas (igual a C):

```java
/* isto é
um comentário de
múltiplas linhas */
```

---

# Impressão

Forma geral:

```java
System.out.println(string);
```

Strings são representadas entre aspas. Exemplo:

```java
System.out.println("Alô, Mundo!");
```

Use `System.out.print` se não quiser inserir uma quebra de linha no final. Exemplo:

```java
System.out.print("A");
System.out.print("l");
System.out.println("ô"); //=> saída: Alô
```

---

# Concatenação de strings

- Para concatenar strings, use `+`
- Outros tipos (ex.: números) são convertidos automaticamente para strings se necessário
  - Isso se chama conversão implícita ou coerção

Exemplos:

```java
System.out.println("Alô" + ", " + "Mundo!"); //=> saída: Alô, Mundo!

// 2001 é convertido para "2001" e então concatenado
System.out.println("Alô " + 2001);           //=> saída: Alô 2001
```

---

# Tipos de dados primitivos

Java define 8 tipos de dados primitivos

- `byte`: número inteiro de 8 bits (de -128 a 127)
- `short`: número inteiro de 16 bits (de -32768 a 32767)
- `int`: número inteiro de 32 bits
- `long`: número inteiro de 64 bits. Exemplo: 12345678L
- `float`: número racional de 32 bits. Exemplo: 3.14f
- `double`: número racional de 64 bits. Exemplo: 3.14
- `boolean`: valor-verdade (true/false). Exemplo: true
- `char`: caractere Unicode de 16 bits. Exemplo: 'á'

---

# Declaração de variáveis

- Igual a C. Forma: [tipo] [nome] [ = valor inicial], ...

Exemplos:

```java
long contador = 0;
int x, y, z = 1;
char letra = 'a';
float pi = 3.14f, raio;
double distancia;
boolean iniciou = false;
```

---

# Atribuição

Depois de declarada, uma variável pode ter seu valor alterado através do operador de atribuição, `=`. Exemplos:

```java
int contador = 0;  /* inicialização */
contador = 2;      /* atribuição */
contador = 2 + 3;  /* atribuição */
```

---

# Incremento e decremento

Java possui operadores de incremento e decremento, iguais aos da linguagem C:

```java
int x = 10;
x++;      // equivalente a x = x + 1
x--;      // equivalente a x = x - 1
--x;      // equivalente a x = x - 1
x += 5;   // equivalente a x = x + 5
x /= 2;   // equivalente a x = x / 2
x *= 1.5; // equivalente a x = x * 1.5
```

---

# Declaração de constantes

- A declaração de constantes é igual à declaração de variáveis, porém prefixada pela palavra `final`
- Tentar alterar uma constante após ter recebido um valor inicial resulta em erro de compilação

Exemplo:

```java
final double PI = 3.14;
*PI = 1.68;  // ERRO DE COMPILACÃO
```

---

# Operadores aritméticos

Operadores `+`, `-`, `*`, `/`, `%` (resto da divisão)

```java
int idade = 20, anoAtual = 1995;
int anoNascimento = anoAtual - idade;
```

`/` representa divisão inteira se, e somente se, ambos os operandos são inteiros:

```java
int x = 10;
double y = x / 3;
System.out.println(y); //=> saída: 3.0
```

---

# Outras operações aritméticas

A classe `Math` possui diversas operações. Exemplos:

```java
double x = Math.cos(Math.PI); /* cosseno */ //=> -1.0
double y = Math.round(2.6);                 //=> 3.0
double z = Math.ceil(2.1);   /* teto */     //=> 3.0
double w = Math.abs(-5);     /* módulo */   //=> 5.0
double a = Math.max(3, 5);
double b = Math.pow(2, 3); // potência (2³)
double c = Math.sqrt(9); // raiz quadrada
```

Consulte a [documentação da classe Math](https://docs.oracle.com/javase/8/docs/api/java/lang/Math.html) para mais operações. Dica: para buscar essa documentação, use a string de busca `javadoc Math`.

---

# Operadores relacionais (comparadores)

- São usados para construir expressões booleanas (que retornam verdadeiro ou falso)
- Comparadores: `<`, `>`, `<=`, `>=`, `==`, `!=`

Exemplo:

```java
// Todas essas expressões retornam
// um booleano (true ou false)
System.out.println(1 < 2);        //=> true
System.out.println(2 + 2 == 5);   //=> false
System.out.println(1 + 2 != 10);  //=> true
System.out.println(9 / 2.0 >= 4); //=> true
```

---

# Operadores lógicos

Usados para combinar expressões booleanas:

- `&&` - operador AND (conjunção lógica)
- `||` - operador OR (disjunção lógica)
- `!` - operador NOT (negação lógica)

Exemplos:

```java
System.out.println(1 == 1 && 2 == 2);     //=> true
System.out.println(1 == 1 || 2 + 2 == 5); //=> true
System.out.println(1 == 1 && !(2 == 2));  //=> false
```

Os operadores `&&` e `||` fazem avaliação em curto-circuito. No segundo exemplo, como `1 == 1` é verdadeiro, a expressão `2 + 2 == 5` não chega a ser avaliada.

---

# Conversão de tipos

- É possível converter valores de um tipo para outro
- Essa conversão pode ser feita de maneira 
  - **implícita** (sem escrever código para isso)
  - **explícita** (espeficando a conversão no código)
- A conversão pode ser
  - **ampliadora** (para um tipo mais abrangente, ex.: de `int` para `double`)
  - **redutora** (para um tipo mais restrito, ex.: de `double` para `int` -- perde informação!)

---

# Conversão implícita de tipos (coerção)

Exemplos:

```java
// 3 é int; é convertido para 3.0 (ampliadora)
double x = 3;
//  (redutora)
int y = 2.8f;  //=> Erro de compilação, pois haveria perda de informação
// 2 é convertido para 2.0 para fazermos uma soma de doubles
System.out.println(3.5 + 2);
```

---

# Conversão explícita de tipos (casting)

Para converter entre tipos, use `(tipo)expressão`. Exemplos:

```java
char x = 'A';
int y = (int)x;
System.out.println(y); //=> saída: 65

double d = 2.8;
System.out.println((int)d); //=> saída: 2
```

Outro exemplo, para evitar uma divisão inteira:

```java
int numerador = 10;
int denominador = 3;
double res = numerador / (double)denominador;
System.out.println(res); //=> saída: 3.3333333333333335
```

---

class: middle, center

# Estruturas (condicionais, loops, funções etc.)

---

`if`, `switch case`, `for`, `while`, `do while`: igual a C.

`return`: igual a C

---

# if

```java
if (x == 2 && y < 10) {
  System.out.println("a");
} else if (x >= 3 || x <= 5) {
  System.out.println("b");
} else {
  System.out.println("c");
}
```

OBS.: Assim como em C, você pode suprimir as chaves (`{}`) caso os blocos de código possuam apenas uma instrução. É boa prática, no entanto, usar chaves mesmo nesses casos.

---

# while

```java
int x = 10;
while (x > 0) {
  System.out.println(x);
  x--;
}
```

---

# for

```java
for (int i = 1; i <= 10; i++) {
  System.out.println(i);
}
```

---

# "Funções"

- Em Java não existem funções, mas existem métodos, que desempenham um papel similar
- Os métodos necessariamente devem estar dentro de uma classe (ou alguma estrutura similar a classe)
- A sintaxe é a mesma do C: `tipoRetorno nomeFuncao(param1, param2, ...) { corpoDoMetodo }`
  - Para retornar um valor, usamos a palavra-chave `return` no corpo do método
  - Se a função não retornar nada, o `tipoRetorno` deve ser `void`
- Para tornar o método mais parecido com uma função, prefixamos a declaração com as palavras `public static`
  - Ao estudarmos orientação a objetos, entenderemos o que essas palavras significam
- A função `public static void main(String[] args)` é o ponto de entrada do programa; equivale à função `int main()` do C

---

Exemplo (arquivo `ExemploFuncao.java`):

```java
public class ExemploFuncao {
  public static void imprimeDeAte(int a, int b) {
    for (int i = a; i <= b; i++) {
      System.out.println(i);
    }
  }

  public static int soma(int a, int b) {
    return a + b;
  }

  public static void main(String[] args) {
    imprimeDeAte(2, 5);
    System.out.println(soma(20, 22));
  }
}
```

---

# "Variáveis globais"

- Em Java não é possível declarar variáveis fora de classes e métodos
- Podemos emular variáveis globais criando atributos estáticos dentro da classe
- Para isso, devemos prefixar a declaração com as palavras `public static`

Exemplo (arquivo `ExemploGlobal.java`):

```java
public class ExemploGlobal {
  public static int contador = 0;

  public static void incrementa() {
    contador++;
  }

  public static void main(String[] args) {
    contador = 5;
    incrementa();
    System.out.println(contador); //=> saída: 6
  }
}
```

---

class: middle, center

# Exercícios - tipos primitivos

---

# Exercício resolvido

Escreva um método estático, `double hipotenusa(double c1, double c2)`, que recebe as medidas de dois catetos de um triângulo retângulo, e retorna a medida da hipotenusa.

Resposta (`ExercicioResolvido.java`):

```java
public class ExercicioResolvido {
* public static double hipotenusa(double c1, double c2) {
*   double c1quadrado = Math.pow(c1, 2);
*   double c2quadrado = Math.pow(c2, 2);
*   return Math.sqrt(c1quadrado + c2quadrado);
* }

  // Código usado para testar o método.
  // Não faz parte da resposta.
  public static void main(String[] args) {
    System.out.println(hipotenusa(3, 4));
  }
}
```

---

1. Escreva um método estático, `int somatorio(int n)`, que recebe um número inteiro e retorna a soma de todos os números de 1 até esse número. Ex.: `somatorio(3)` deve retorna 6 (pois 1 + 2 + 3 = 6). Se o número não for positivo, deve retornar -1.
2. Escreva um método estático, `boolean equilatero(double a, double b, double c)`, que recebe as medidas dos três lados de triângulos, e determina se ele é equilátero.
3. Escreva um método estático, `int contaPositivos(double a, double b, double c)`, que retorna a quantidade de números positivos (maiores que 0) recebidos como parâmetro.

---

class: middle, center

# Strings

---

# Strings em Java

- Em Java, string não é um tipo primitivo, e sim uma classe, `String` (com S maiúsculo)
- Portanto, strings são **objetos**, que possuem atributos e métodos
- Além disso, strings são **imutáveis**: uma vez criadas não podem ser modificadas
- Objetos string são representados por **aspas**.
- Strings podem ser concatenados com o operador `+`

Exemplos:

```java
String s1 = "Alô";
String s2 = "mundo";
System.out.println(s1 + " " + s2);
System.out.println(s1.length());      //=> saída: 3
System.out.println("mundo".length()); //=> saída: 5
```

---

# Alguns métodos úteis

- `length()` - comprimento
- `charAt(i)` - caractere na posição `i`
- `contains(substr)` - indica se a string contém a substring `substr`
- `toLowerCase()` / `toUpperCase()` - retorna uma nova string com todos os caracteres convertidos para minúsculas / maiúsculas
- `trim()` - retorna uma nova string com espaços em branco removidos do início e do final da string
- `equals(s)` - indica se a string é igual à string `s`
- `equalsIgnoreCase(s)` - indica se a string é igual à string `s`, ignorando distinção entre maiúsculas e minúsculas

Para mais métodos, busque na internet por [javadoc String](https://www.google.com/search?q=javadoc+string) -- veja, por exemplo, o método `compareTo`.

---

# Exemplos

```java
String x = "Alo mundo";
System.out.println(x);     //=> saída: Alo mundo

String y = x.toUpperCase();
System.out.println(y);     //=> saída: ALO MUNDO

char quinto = y.charAt(4); //=> quinto: 'M'
int tamanho = y.length();  //=> tamanho: 9
String z = y + "!!!";      //=> z: "ALO MUNDO!!!"
System.out.println(z);
```

---

# Comparação de strings

- Sejam `a` e `b` duas variáveis do tipo `String`.
- A comparação `a == b` retornará `true` apenas se `a` e `b` forem o mesmo objeto
- Para comparar o conteúdo das strings, use `a.equals(b)`.
- Se criarmos duas strings com o mesmo tamanho e os mesmos caracteres na mesma ordem, ainda assim `a == b` pode retornar `false`, mas `a.equals(b)` retornará `true`.

```java
String a = "alo mundo";
String b = "ALO MUNDO".toLowerCase();
System.out.println(a == b);
System.out.println(a.equals(b));
```

---

# Comparação de strings

Neste caso `a == b` retorna `true`:

```java
String a = "alo mundo";
String b = "alo mundo";
System.out.println(a == b);
System.out.println(a.equals(b));
```

Isso ocorre porque o compilador otimiza o código, criando uma única string e atribuindo-a a ambas as variáveis.

---

class: middle, center

# Exercícios - Strings

---

1. **Primeira letra**: escreva um método estático que recebe uma String e retorna um `char` representando o primeiro caractere da String. Se esse caractere for uma letra maiúscula, deve ser convertido para minúscula. Se a String for vazia, deve retornar o caractere de espaço branco.
2. **Arquivos PDF**: escreva um método estático que recebe o nome de um arquivo e indica (através apenas da análise do nome do arquivo) se o arquivo está no formato PDF.
3. **Mascarando senha**: escreva um método estático que recebe uma String e retorna uma String contendo um `*` para cada caractere da String original.
4. **Múltipla escolha**: escreva um método estático que recebe duas Strings, representando as respostas de uma prova de múltipla escolha realizada por um estudante e o seu gabarito, ex.: respostas "ADDCBA", gabarito "ABDCAA". O método deve retornar a quantidade de acertos (i.e., quantidade de caracteres iguais em posições iguais nas duas strings).

---

class: middle, center

# Arrays (vetores)

---

# Arrays: declaração e inicialização

Estrutura que contém um grupo de elementos do mesmo tipo. Similar a C.

```java
// Declaração
float[] temperaturas;

// Declaração com inicialização explícita
int[] numeros = {1, 1, 2, 3, 5, 8}
float matriz[][] = new float[][] {
  {1, 2, 3, 4},
  {5, 6, 7, 8},
  {9, 10, 11, 12}
};

// Declaração sem inicialização explícita
// (nesse caso, todos os elementos são
//  inicializados com o valor 0.0)
double[] coordenadas = new double[3];
int matriz2[][] = new int[3][4]; // 3 linhas, 4 colunas
```

---

# Arrays: acesso

Para acessar um elemento, usa-se `vetor[indice]`, onde o índice vai de 0 até `vetor.length - 1`, onde `vetor.length` é o tamanho do vetor.

```java
int[] numeros = {1, 1, 2, 3, 5, 8}

// Imprime 5º elemento (posição 4)
System.out.println(numeros[4]);

// Imprime o último elemento
int ultimaPos = numeros.length - 1;
System.out.println(numeros[ultimaPos]);

// Modifica 1º elemento
numeros[0] = -1;
System.out.println(numeros[0]);
```

---

# Iteração sobre vetores

Primeira forma: usando o `for` tradicional:

```java
int[] numeros = {1, 1, 2, 3, 5, 8};

for (int i = 0; i < numeros.length; i++) {
  System.out.println(numeros[i]);
}
```

---

# Iteração sobre vetores

- Primeira forma: usando o `for` aprimorado.
- Sintaxe: `for (tipoVariavel nomeVariavel : vetor) { ... }`

```java
int[] numeros = {1, 1, 2, 3, 5, 8};

*for (int num : numeros) {
  System.out.println(num);
}
```

---

class: middle, center

# Exercícios  - arrays

---

1. Escreva um método estático que recebe um array de números inteiros e imprime os elementos desse array, um por linha
2. Escreva um método estático que recebe um array de números inteiros e retorna o array inverso. Ex.: se a entrada for `3, 5, 1, 2, 6`, a saída deve ser `6, 2, 1, 5, 3`.
3. Escreva um método estático que recebe um array de números inteiros e retorna o maior desses números.

---

class: middle, center

# Convenções de codificação

---

# Convenções de codificação

- Conjunto de recomendações de como escrever código em uma linguagem, de forma a uniformizar certos aspectos do código-fonte, como nomes de variáveis, uso de espaços ou tabs, quebras de linha etc.
- Cada empresa ou equipe pode estabelecer suas convenções.
- Exemplos para Java:
  - <https://www.oracle.com/technetwork/java/codeconventions-150003.pdf>
  - <https://google.github.io/styleguide/javaguide.html>

---

# Nomes de variáveis

- Seguir convenção "camel case minúsculo":
  - Iniciar com letra minúscula
  - Apenas a inicial de cada palavra a partir da segunda deve ser maiúscula
- Exemplos: `diaDaSemana`, `ultimoNome`, `data`
- Contra-exemplos: `diadasemana`, `ULTIMO_NOME`, `Data`

---

# Nomes de classes

- Seguir convenção "camel case maiúsculo":
  - Apenas a inicial de cada palavra deve ser maiúscula (incluindo a primeira)
- Exemplos: `Pessoa`, `ItemFinanceiro`
- Contra-exemplos: `PESSOA`, `itemFinanceiro`

---

# Nomes de constantes

- Seguir convenção "snake case maiúsculo":
  - todas as letras maiúsculas, palavras separadas por `_`
- Exemplos: `PI`, `LARGURA_DA_TELA`


</div>