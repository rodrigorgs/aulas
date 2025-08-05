---
layout: remark
title: Exceções
---

<!-- 

- Tratando exceções
  - Um catch
  - Múltiplos catches
- Lançando exceções
  - Propagação de exceções
- Tipos de exceção
  - Hierarquia de exceções
  - Exceções customizadas
  - Exceção checada e não-checada
  - Cláusula throws

 -->

<div>

# Exceções

- Motivação e conceitos
- Tratamento de exceções
  - Múltiplos catches
- Propagação de exceções e stack trace
- Lançamento de exceções
- Exceções checadas e não-checadas
- Outros tópicos

---

class: middle, center, inverse

# Motivação e conceitos

---

# Tratamento de erros

- Ao programar, devemos sempre pensar nas situações em que algo pode dar errado e, consequentemente, tratar esse erro
- Existem várias formas de lidar com erros

---

# Forma 1: checar condições excepcionais

Na operação de divisão, o divisor não pode ser zero:

```java
Scanner scanner = new Scanner(System.in);
int x = scanner.nextInt();
int y = scanner.nextInt();
*if (y != 0) {
    System.out.println(x / y);
} else {
    System.out.println("Erro: divisão por zero");
}
System.out.println("Fim");
```

Se `y` for zero, o programa exibe uma mensagem de erro amigável para o usuário e a execução do programa continua.

<!-- (Em C, é comum ter funções que retornam valores especiais para indicar erros; assim, é necessário checar o retorno dessas funções) -->

---

# Forma 2: não lidar com erros

O que acontece se ignorarmos o caso de divisão por zero?

```java
Scanner scanner = new Scanner(System.in);
int x = scanner.nextInt();
int y = scanner.nextInt();
*System.out.println(x / y);
System.out.println("Fim");
```
--


Se `y` for zero, o programa fecha na hora, e a última linha não é executada. O erro exibido é o seguinte:

```
Exception in thread "main" java.lang.ArithmeticException: / by zero
```

---

# Forma 3: usar tratamento de exceções (try/catch)

A operação de divisão **lança uma exceção** quando o divisor é zero. Podemos tratar essa exceção usando `try/catch`:

```java
Scanner scanner = new Scanner(System.in);
int x = scanner.nextInt();
int y = scanner.nextInt();
*try {
    System.out.println(x / y);
*} catch (ArithmeticException e) {
    System.out.println("Erro: divisão por zero");
*}
System.out.println("Fim");
```

Para entender esse programa, precisamos aprender sobre alguns conceitos antes.

---

# Exceções

- Lembra que, quando você não tratou o erro, apareceu a seguinte mensagem: `Exception in thread "main" java.lang.ArithmeticException: / by zero` ?
- Em Java, os erros geram **exceções** (exceptions).

> As exceções são objetos que descrevem um erro, indicando a causa do erro, a linha de código onde o erro aconteceu, e possivelmente outras informações.

--

- Existem várias classes de exceção, como `ArithmeticException`, `NullPointerException`, `Error` e muitas outras.
- Todas as classes que representam exceções são subtipos, direta ou indiretamente, da classe `Throwable` (lançável)

---

class: middle, center, inverse

# Tratamento de exceções

---

# Bloco try/catch

Para tratar exceções, você deve criar blocos de código com as palavras-chave `try` (tentar) e `catch` (capturar). O bloco `try` é executado de maneira que, se for **lançada** uma exceção dentro do bloco, a execução do bloco é interrompida e é continuada no bloco `catch`. Exemplo:

.line-numbers[
```java
Scanner scanner = new Scanner(System.in);
int x = scanner.nextInt();
int y = scanner.nextInt();
*try {
    System.out.println(x / y);  // se y == 0, lança ArithmeticException
*} catch (ArithmeticException e) {
    System.out.println("Erro: divisão por zero");
*}
System.out.println("Fim");
```
]

- Sequência de execução do programa:
  - Sem exceção: linhas 1, 2, 3, 5, 9
  - Com exceção: linhas 1, 2, 3, 5, 7, 9
- O `catch` recebe como parâmetro a exceção que será tratada.
  - Sintaxe: `catch (TipoDaExcecao nomeDoParametro)` -- geralmente usa-se o nome `e` para a exceção

---

# Bloco try/catch

- O bloco `try` não precisa conter apenas a instrução que pode lançar exceção. 
- Considere o código abaixo: qual será sua saída no caso de não ser lançada uma exceção? E no caso de ser lançada uma exceção do tipo `ArithmeticException`?

```java
Scanner scanner = new Scanner(System.in);
try {
    int x = scanner.nextInt();
    int y = scanner.nextInt();
    System.out.println(x / y);
    System.out.println("Fim");
} catch (ArithmeticException e) {
    System.out.println("Erro: divisão por zero");
}
System.out.println("Tchau");
```

---

# Bloco try/catch

Se `y != 0`, não há exceção e as seguinte linhas são executadas:

```java
*Scanner scanner = new Scanner(System.in);
try {
*   int x = scanner.nextInt();
*   int y = scanner.nextInt();
*   System.out.println(x / y);
*   System.out.println("Fim");
} catch (ArithmeticException e) {
    System.out.println("Erro: divisão por zero");
}
*System.out.println("Tchau");
```

---

# Bloco try/catch

Se `y == 0`, é lançada uma exceção e as seguinte linhas são executadas:

```java
*Scanner scanner = new Scanner(System.in);
try {
*   int x = scanner.nextInt();
*   int y = scanner.nextInt();
*   System.out.println(x / y); // O println não é executado!!
    System.out.println("Fim");
} catch (ArithmeticException e) {
*   System.out.println("Erro: divisão por zero");
}
*System.out.println("Tchau");
```

---

# Múltiplos catches

- **Pergunta**: No código do slide anterior, o que acontece se, no lugar de digitar um número, você digitar uma palavra?
--

- **Resposta**: O método `nextInt()` lança uma exceção:

```
Exception in thread "main" java.util.InputMismatchException
```
--

- **Explicação**: Apesar de a chamada a `nextInt()` estar dentro de um bloco `try`, só estamos tratando (com `catch`) as exceções do tipos `ArithmeticException`
--

- **Solução**: Podemos ter múltiplos `catch`es para um mesmo `try`:

```java
Scanner scanner = new Scanner(System.in);
*try {
    int x = scanner.nextInt();
    int y = scanner.nextInt();
    System.out.println(x / y);
    System.out.println("Sucesso");
*} catch (ArithmeticException e) {
    System.out.println("Erro: divisão por zero");
*} catch (InputMismatchException e) {
    System.out.println("Erro: você deveria digitar um número!");
}
```

---

# Código limpo

- O uso de exceções, aliada ao uso do `try/catch`, permite escrevermos código mais **limpo**, no qual o código de tratamento de exceções fica **separado** do código do nosso programa.
- Sem exceções, o <span style="background: #f0f0f0;">tratamento de erros</span> seria **intercalado** com <span style="background: #f0f000;">nosso código</span>, tornando a leitura mais difícil. Algo assim (pseudocódigo):

```java
*x = leInt();
if (x == NUMERO_INVALIDO) {
    print("Erro: número inválido");
    exit();
}
*y = leInt();
if (y == NUMERO_INVALIDO) {
    print("Erro: número inválido");
    exit();
}
if (y == 0) {
    print("Erro: divisão por zero");
    exit();
}

*print("Resultado: " + (x / y));
*print("Fim");
```

---

# Bloco finally

O bloco `finally` é usado para colocar código de limpeza, que é executado independentemente de ter ocorrido uma exceção. Exemplo:

```java
public static int divisao() {
    Scanner scanner = new Scanner(System.in);
    Integer x = scanner.nextInt();
    Integer y = scanner.nextInt();

    try {
        int resultado = x / y;
        return resultado;
    } catch (ArithmeticException e) {
        return -1;
*    } finally {
*        scanner.close();
*    }

    // esta linha nunca é executada
    // por causa dos returns
    System.out.println("qwerty");
}
```

Ver também: <https://stackoverflow.com/questions/3354823/how-to-use-finally>

---

class: middle, center, inverse

# Propagação de exceções

---

# Propagação de exceções

- Quando um método lança uma exceção, duas coisas podem acontecer:
    - O método pode **tratar** a exceção, usando `try`/`catch`
    - O método pode não tratar a exceção, e sim **propagá-la** para o método que o chamou
      - esse método pode tratar ou propagar a exceção, e assim sucessivamente
--

- Em último caso, se o método `main` propagar a exceção, ela é exibida para o usuário final e o programa encerra
- Em um programa voltado para usuários leigos, você sempre quer tratar as exceções, mesmo que seja para exibi-las de forma mais amigável para o usuário

---

# Propagação de exceções

- Considere o seguinte exemplo: `main()` chama `a()`, que chama `b()`, que chama `c()`, e `c()` lança uma exceção do tipo `ArithmeticException`:

```java
public class Main {
    public static void main(String[] args) {
        a();
        System.out.println("fim");
    }
    public static void a() {
        b();
    }
    public static void b() {
        c();
    }
    public static void c() {
*       System.out.println(1 / 0); // lança ArithmeticException
    }
}
```

- `c()` propaga a exceção para `b()`
- `b()` propaga a exceção para `a()`
- `a()` propaga a exceção para `main()`
- `main()` propaga a exceção para a JVM

---

# Propagação de exceções

- Agora considere o exemplo similar, com a diferença de que `a()` trata a exceção:

```java
public class Main {
    public static void main(String[] args) {
        a();
        System.out.println("fim");
    }
    public static void a() {
        try {
            b();
*       } catch (ArithmeticException e) {
        }
    }
    public static void b() {
        c();
    }
    public static void c() {
*       System.out.println(1 / 0); // lança ArithmeticException
    }
}
```

O que acontece?

---

# Propagação de exceções

- `c()` lança a exceção, propaga para `b()`, que propaga para `a()`, que trata a exceção
  - A exceção não se propaga para `main()`
- A execução continua normalmente: `a()` retorna, `main()` imprime `"fim"` e o programa encerra normalmente.

---

# Propagação de exceções: por quê?

Tratar a exceção no método que gera a exceção (no exemplo, o método `c`) pode não ser uma boa ideia porque, se esse método for usado por diversos programas, cada programa pode querer tratar a exceção de uma forma diferente. Por exemplo, um programa web pode querer exibir a mensagem de erro através de uma página web, e não através de um `print` no console. Assim, o ideal é propagar a exceção até o método em que seja mais adequado tratá-la.


<!-- Uma exceção é como uma bomba: uma vez que está na sua mão, você pode desarmar ou repassar para seu superior -->

---

# Obtendo informações sobre a exceção


No exemplo anterior, `catch` recebe um parâmetro `e`, do tipo `ArithmeticException`. Com esse objeto você pode obter informações sobre a exceção.

```java
try {
    System.out.println(1 / 0);
} catch (ArithmeticException e) {
    System.out.println("ERRO");
*   System.out.println("Mensagem: " + e.getMessage());
    System.out.println("Stack trace:");
*   e.printStackTrace();
}
```

---

# Stack trace

Uma exceção não tratada imprime as seguintes informações no console:

- O **nome** da classe da exceção
- A **thread** onde a exceção foi lançada (threads está fora do escopo desta disciplina)
- A **mensagem** de exceção (normalmente fornecida como parâmetro durante a criação da exceção)
- O **stack trace** (rastro da pilha de chamadas), que indica o ponto do programa onde a exceção foi lançada, o ponto onde o método que lançou a exceção foi chamado, e assim recursivamente, como uma pilha de chamadas de métodos

<!-- 
Todo: o rastro mostra também código de biblioteca
 -->

---

# Stack trace

No exemplo apresentado anteriormente, em que temos a sequência de chamadas (`main() => a() => b() => c()`, eis a saída, contendo o stack trace:

```
Exception in thread "main" java.lang.ArithmeticException: / by zero
*   at Exemplo.c(Exemplo.java:16)
*   at Exemplo.b(Exemplo.java:13)
*   at Exemplo.a(Exemplo.java:8)
*   at Exemplo.main(Exemplo.java:3)
```

---

class: middle, center, inverse

# Lançamento de exceções

---

# Lançando exceções

- Para lançar uma exceção, use `throw obj`, onde `obj` é um objeto que representa uma exceção (throw significa "lançar")
- Tipicamente, você usará `throw new ClasseDeExcecao("mensagem de exceção")`
  - Existem várias classes de exceção, como `ArithmeticException`, `NullPointerException`, dentre outras

```java
public class Exemplo {
    public static int leNumeroPositivo() {
        Scanner scanner = new Scanner(System.in);
        System.out.println("Digite um número positivo:");
        int x = scanner.nextInt();
        if (x <= 0) {
*           throw new ArithmeticException("Número inválido: " + x);
        }
        return x; // só executa se não for lançada exceção
    }

    public static void main(String[] args) {
        int x = leNumero();
        System.out.println("O dobro de " + x + " é " + (x * 2));
    }
}
```

---

class: middle, center, inverse

# Exceções checadas e não-checadas

---

# Hierarquia de exceções

.left-column[
<div class="uml">
class Throwable {
}
class Error extends Throwable {
}
class Exception extends Throwable {
}
class RuntimeException extends Exception {
}
</div>
]
.right-column[
- `Throwable` é a mãe de todas as exceções
  - `Error` é para exceções que indicam problemas sérios que em geral não podem ser tratados. Exemplo (subclasse): `OutOfMemoryError`
  - `Exception` é para exceções que em geral podem ser tratadas
    - `RuntimeException` é um tipo de `Exception` para exceções corriqueiras, que poderiam ter sido evitadas com verificações durante a execução do problema. Exemplos (subclasses): `ArithmeticException`, `IndexOutOfBoundsException`...
- OBS.: Na cláusula `catch` você pode usar uma superclasse da classe de exceção que de fato foi lançada. Por exemplo, `catch (Throwable e)` vai capturar qualquer exceção.
]

---

# Exceções checadas e não-checadas

Existem dois tipos de exceção: **checadas** e **não-checadas**:

- Um método que propaga uma exceção **checada** deve declarar, explicitamente, que propaga essa exceção, do contrário ocorre um erro de compilação
  - ou, se o método não declarar que propaga a exceção, ele é obrigado a tratá-la
- Até agora todos os exemplos lançavam exceções **não-checadas**
  - foi possível propagar as exceções sem incluir nenhuma declaração especial
--


As instâncias de `Error`, `RuntimeException` e suas subclasses são ditas exceções **não-checadas**. Todas as demais são exceções **checadas**

<!-- - Se um método puder, sob alguma hipótese, lançar uma exceção **checada**, essa exceção deve ser declarada na assinatura do método (veremos como fazer isso em breve)
- Um código que chama esse método deve obrigatoriamente tratar todas as exceções checadas declaradas pelo método (ou, como veremos em breve, relançar a exceção) -->

---

# Exceções checadas: cláusula throws

- A cláusula `throws` é usada para declarar que um método pode lançar/propagar exceções **checadas**.
- Considere o seguinte exemplo:

```java
public class Main {
    public static void main(String[] args) {
        criaArquivo();
    }
    public void criaArquivo() {
        File file = new File("/tmp/abcd");
*       file.createNewFile(); // pode lançar IOException
    }
}
```
--

- O método `createNewFile()` pode lançar uma exceção da classe `IOException`, que é uma exceção **checada**.
- Como a exceção checada não está sendo tratada, o programa dá erro ao compilar: `Unhandled exception type IOException`.

---

# Exceções checadas: cláusula throws

- Há duas formas de resolver esse problema:
  - Usar `try/catch` para tratar a exceção dentro do método `criaArquivo()`
  - Declarar, com a cláusula `throws`, que o método propaga a exceção `IOException`:
--


```java
public class Main {
    public static void main(String[] args) {
        criaArquivo(); //=> Unhandled exception type IOException
    }
*   public void criaArquivo() throws IOException {
        File file = new File("/tmp/abcd");
        file.createNewFile();
    }
}
```
--


- Esse programa ainda não compila
- `main` chama um método que declara que propaga `IOException` (`throws IOException`)
  - Logo, `main` precisa tratar ou propagar essa exceção

---

# Exceções checadas: cláusula throws

Exemplo compilável:

```java
public class Main {
    public static void main(String[] args) {
        try {
            criaArquivo();
        } catch (IOException e) {
            System.out.println("Não foi possível criar o arquivo");
        }
    }
    public static void criaArquivo() throws IOException {
        File file = new File("/tmp/abcd");
        file.createNewFile();
    }
}
```
--


- Outra opção seria incluir `throws IOException` na declaração do método `main`.
- Nesse caso, a exceção seria tratada pela máquina virtual Java, que imprimiria o *stack trace* e fecharia o programa.

Bônus: como está declarado o método `createNewFile`?

---

# Exceções checadas: exemplo mais complexo

Para declarar a propagação de múltiplas exceções, use `throws Classe1, Classe2, Classe3, ...`

```java
public class Main {
* public void leArquivoAbcd() throws IOException, FileNotFoundException {
    File file = new File("/tmp/abcd");
    FileInputStream fis = new FileInputStream(file); //=> throws FileNotFoundException
    BufferedReader br = new BufferedReader(new InputStreamReader(fis));
    System.out.println(br.read()); //=> throws IOException
    br.close(); //=> throws IOException
  }
  // ...
}
```

---

# Exceções checadas: por quê?

- O uso de exceções checadas faz com que o compilador avise (com um erro) que estamos chamando um método que lança exceções
- O compilador obriga o programador a tratar a exceção ou então declarar, conscientemente, que ela será propagada
- Com exceções não-checadas, o programador pode não saber que está chamando um método que lança exceções, e pode acabar propagando essas exceções sem saber

---

# Exceções checadas: quando?

- Considere que você criou um método `B()`, e que o método `A()` chama `B()`
- Considere ainda que `B()` pode lançar uma exceção
- Segundo Martin Fowler, para decidir entre lançar exceção checada ou não-checada, devemos considerar de quem é a **responsabilidade** por **checar** a condição excepcional:
  - Se `A()` deve ser responsável por checar as condições antes de chamar `B()`, então `B()` só vai lançar exceção se `A()` tiver sido mal programado; por isso, `B()` deve lançar uma exceção **não-checada**
  - Se `B()` deve ser responsável, então `B()` deve lançar uma exceção **checada**

Ver <http://adamsiemion.blogspot.com/2013/05/checked-or-unchecked-exception-in-java.html>

---

# Exceções checadas: quando?

**Exemplo**: considere o método `divide(a, b)`. Se `b == 0`, isso gera uma exceção (pois não é possível dividir por zero).

- O método `divide` deve lançar uma exceção **não-checada**, pois é responsabilidade do cliente/chamador de `divide` verificar se `b == 0` antes de chamar o método
- Seria redundante o chamador usar o `if` para verificar se `b == 0` e depois ainda ser obrigado a tratar a exceção com `try/catch`
--


**Exemplo**: considere o método `leInteiro()`, que lê um número inteiro do teclado. Se o usuário digitar algo que não é um inteiro, o método lança uma exceção.

- A exceção deve ser **checada**, pois o chamador não tem como adivinhar se o usuário vai digitar um número inteiro -- portanto, ele deve tratar o caso excepcional com `try/catch`

---

class: middle, center, inverse

# Outros tópicos

---

# Exceções customizadas

Você pode criar sua própria classe de exceção, bastando para isso estender (`extends`) alguma das classes de exceção já existentes. Exemplo:

```java
public class ExcecaoDeDivisaoPorZero extends ArithmeticException {
    // ...
}
```

---

# Considerações sobre desempenho

O tratamento de exceções em Java introduz uma penalidade no desempenho do programa, uma vez que construir o *stack trace* da exceção é uma operação potencialmente custosa. Assim, evite usar `try/catch` dentro de um loop com muitas iterações se o desempenho for uma preocupação.

</div>
