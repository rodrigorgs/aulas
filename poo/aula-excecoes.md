---
layout: page
title: Exceções
---

# Tratamento de erros

- Ao programar, devemos sempre pensar nas situações em que algo pode dar errado e, consequentemente, tratar esse erro
- Existem vários formas de lidar com erros

---

# Forma 1: não lidar com erros

Exemplo:

```java
Scanner scanner = new Scanner(System.in);
int x = scanner.nextInt();
int y = scanner.nextInt();
System.out.println(x / y);
System.out.println("Fim");
```

Se `y` for zero, o programa fecha na hora, e a última linha não é executada.

---

# Forma 2: checar condições excepcionais

Exemplo:

```java
Scanner scanner = new Scanner(System.in);
int x = scanner.nextInt();
int y = scanner.nextInt();
if (y != 0) {
    System.out.println(x / y);
} else {
    System.out.println("Erro: divisão por zero");
}
System.out.println("Fim");
```

Se `y` for zero, o programa exibe uma mensagem de erro amigável para o usuário e a execução do programa funciona.

(Em C, é comum ter funções que retornam valores especiais para indicar erros; assim, é necessário checar o retorno dessas funções)

---

# Forma 3: usar tratamento de exceções (try/catch)

Exemplo:

```java
Scanner scanner = new Scanner(System.in);
int x = scanner.nextInt();
int y = scanner.nextInt();
try {
    System.out.println(x / y);
} catch (ArithmeticException e) {
    System.out.println("Erro: divisão por zero");
}
System.out.println("Fim");
```

Para entender esse programa, precisamos aprender sobre alguns conceitos antes.

---

# Exceções

- Lembra que, quando você não tratou o erro, apareceu a seguinte mensagem: `Exception in thread "main" java.lang.ArithmeticException: / by zero` ?
- Em Java, os erros geram exceções (exceptions).
- As exceções são objetos que descrevem um erro, indicando a causa do erro, a linha de código onde o erro aconteceu, e possivelmente outras informações.
- As exceções podem pertencer a diversas classes, como `ArithmeticException`, `NullPointerException`, `Error` e muitas outras.
- Todas as classes que representam exceções herdam, direta ou indiretamente, da classe `Throwable` (lançável)

---

# Lançando exceções

- A instrução `throw` (lançar) é usada para **lançar** exceções.
- Quando uma exceção é lançada, duas coisas podem acontecer:
    - A exceção pode ser tratada, usando `try`/`catch`
    - Se não for tratada, o programa imprime uma descrição do erro e o programa fecha
- Em um programa voltado para usuários leigos, você sempre quer tratar as exceções, mesmo que seja para exibi-las de forma mais amigável para o usuário

---

# Lançando exceções

```java
Scanner scanner = new Scanner(System.in);
System.out.println("Digite um número positivo:");
int x = scanner.nextInt();
if (x <= 0) {
    throw new Error("Número inválido: " + x);
}
System.out.println("O dobro de " + x + " é " + (x * 2));
```

# Stack trace

Uma exceção não tratada imprime as seguintes informações no console:

- O nome da classe da exceção
- A thread onde a exceção foi lançada (threads está fora do escopo desta disciplina)
- A mensagem de exceção (normalmente fornecida como parâmetro durante a criação da exceção)
- O rastro da pilha de chamadas (*stack trace*), que indica o ponto do programa onde a exceção foi lançada, o ponto onde o método que lançou a exceção foi chamado, e assim recursivamente, como uma pilha de chamadas de métodos

---

# Stack trace

Exemplo:

```java
package aula;

public class Main {
    public static void a() {
        b();
    }
    public static void b() {
        c();
    }
    public static void c() {
        throw new Error("Erro fatal");
    }
    public static void main(String[] args) {
        a();
    }
}
```

---

# Stack trace

Saída:

```
Exception in thread "main" java.lang.Error: Erro fatal
    at aula.Main.c(Main.java:11)
    at aula.Main.b(Main.java:8)
    at aula.Main.a(Main.java:5)
    at aula.Main.main(Main.java:14)
```

---

# Tratamento de exceções: try/catch

Para tratar exceções, você deve criar blocos de código com as palavras-chave `try` (tentar) e `catch` (capturar). O bloco `try` é executado de maneira que, quando for lançada a primeira exceção dentro do bloco, a execução do bloco é interrompida e é continuada no bloco `catch`. Exemplo:

```java
Scanner scanner = new Scanner(System.in);
int x = scanner.nextInt();
int y = scanner.nextInt();
try {
    System.out.println(x / y);
} catch (ArithmeticException e) {
    System.out.println("Erro: divisão por zero");
}
System.out.println("Fim");
```

Ao executar o bloco `try`:

- Se não for lançada exceção, a execução continua normalmente depois do bloco catch.
- Se for lançada uma exceção do tipo `ArithmeticException`, a execução continua dentro do bloco `catch`, e depois continua normalmente depois do bloco `catch`.

---

# Tratamento de exceções: try/catch

No exemplo anterior, `catch` recebe um parâmetro `e`, do tipo `ArithmeticException` (note que o nome do parâmetro, `e`, é arbitrário; você pode escolher outro nome se preferir). Com esse objeto você pode obter informações sobre a exceção.

```java
Scanner scanner = new Scanner(System.in);
int x = scanner.nextInt();
int y = scanner.nextInt();
try {
    System.out.println(x / y);
} catch (ArithmeticException e) {
    System.out.println("ERRO");
    System.out.println("Mensagem: " + e.getMessage());
    System.out.println("Stack trace:");
    e.printStackTrace();
}
System.out.println("Fim");
```


---

# Tratamento de exceções: try/catch

O código abaixo está um pouco diferente. Qual será sua saída no caso de não ser lançada uma exceção? E no caso de ser lançada uma exceção?

```java
Scanner scanner = new Scanner(System.in);
int x = scanner.nextInt();
int y = scanner.nextInt();
try {
    System.out.println(x / y);
    System.out.println("Fim");
} catch (ArithmeticException e) {
    System.out.println("Erro: divisão por zero");
}
```

---

# Tratamento de exceções: múltiplos catches

```java
Scanner scanner = new Scanner(System.in);
Integer x = scanner.nextInt();
Integer y = scanner.nextInt();
if (x == 0) {
    x = null;
}

try {
    System.out.println("Sucessor de x: " + (x + 1));
    System.out.println("x / y: " + (x / y));
} catch (ArithmeticException e) {
    System.out.println("Erro: divisão por zero");
} catch (NullPointerException e) {
    System.out.println("Erro: valor nulo");
}
System.out.println("Fim");
```


---

# Bloco finally

O bloco `finally` é usado para colocar código de limpeza, que é executado independentemente de ter ocorrido uma exceção. Exemplo:

```java
public int divisao() {
    Scanner scanner = new Scanner(System.in);
    Integer x = scanner.nextInt();
    Integer y = scanner.nextInt();

    try {
        int resultado = x / y;
        return resultado;
    } catch (ArithmeticException e) {
        return -1;
    } finally {
        scanner.close();
    }

    // esta linha nunca é executada
    // por causa dos returns
    System.out.println("qwerty");
}
```

Ver também: <https://stackoverflow.com/questions/3354823/how-to-use-finally>

---

# Hierarquia de exceções

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

- `Throwable` é a mãe de todas as exceções
- `Error` é para exceções que indicam problemas sérios que em geral não podem ser tratados. Exemplo (subclasse): `OutOfMemoryError`
- `Exception` é para exceções que em geral podem ser tratadas
- `RuntimeException` é para exceções corriqueiras, que poderiam ter sido evitadas com verificações durante a execução do problema. Exemplos (subclasses): `ArithmeticException`, `NullPointerException`, `IndexOutOfBoundsException`

Observações:

- Você pode criar sua própria classe de exceção, bastando estender de uma classe de exceção pré-existente.
- Na cláusula `catch` você pode usar uma superclasse da classe de exceção que de fato foi lançada. Por exemplo, `catch (Throwable e)` vai capturar qualquer exceção.

---

# Exceções checadas e não-checadas

- Existem dois tipos de exceção: **checadas** e **não-checadas**
- As instâncias de `Error`, `RuntimeException` e suas subclasses são ditas exceções **não-checadas**
- Todas as demais são **checadas**; isso significa que o compilador vai checar se você está tratando a exceção
- Se um método puder, sob alguma hipótese, lançar uma exceção **checada**, essa exceção deve ser declarada na assinatura do método (veremos como fazer isso em breve)
- Um código que chama esse método deve obrigatoriamente tratar todas as exceções checadas declaradas pelo método (ou, como veremos em breve, relançar a exceção)

---

# Cláusula throws

Considere o seguinte exemplo:

```java
public class Main {
    public void criaArquivo() {
        File file = new File("/tmp/abcd");
        file.createNewFile();
    }
    public static void main(String[] args) {
        criaArquivo();
    }
}
```

O método `createNewFile()` pode lançar uma exceção da classe `IOException`, que herda de `Exception` e, por isso, é uma exceção *checada*. Como a exceção checada não está sendo tratada, o programa não compila. O erro de compilação é `Unhandled exception type IOException`.

(Extra: quais seriam as possíveis causas para `createNewFile` retornar uma exceção?)

---

# Cláusula throws

Há duas formas de resolver esse problema. Uma forma é a que já conhecemos: usar `try/catch` (experimente usar o Eclipse para gerar o `try/catch` para você):

```java
public class Main {
    public void criaArquivo() {
        File file = new File("/tmp/abcd");
        try {
            file.createNewFile();
        } catch (IOException e) {
            System.out.println("Não foi possível criar o arquivo");
        }
    }
    public static void main(String[] args) {
        criaArquivo();
    }
}
```

---

# Cláusula throws

Tratar a exceção no método `criaArquivo` pode não ser uma boa ideia porque, se esse método for usado por diversos programas, cada programa pode querer tratar a exceção de uma forma diferente. Por exemplo, um programa web pode querer exibir a mensagem de erro através de uma página web, e não através de um `print` no console. Assim, o ideal é relançar a exceção:

```java
public class Main {
    public void criaArquivo() {
        File file = new File("/tmp/abcd");
        try {
            file.createNewFile();
        } catch (IOException e) {
            System.out.println("Não foi possível criar o arquivo");
            throw e; // <|------------
        }
    }
    public static void main(String[] args) {
        criaArquivo();
    }
}
```

---

# Cláusula throws

Agora, seu método voltou a lançar uma exceção não-checada. Isso deve ser declarado na assinatura do método, usando a palavra-chave `throws` (não confundir com `throw`):

```java
public class Main {
    public void criaArquivo() throws IOException { // <|-----
        File file = new File("/tmp/abcd");
        try {
            file.createNewFile();
        } catch (IOException e) {
            throw e;
        }
    }
    public static void main(String[] args) {
        criaArquivo();
    }
}
```

Experimente usar o Eclipse para gerar o `throws` para você.

---

# Cláusula throws

De fato, uma vez que você usou `throws`, você pode eliminar o `try/catch`:

```java
public class Main {
    public void criaArquivo() throws IOException { // <|-----
        File file = new File("/tmp/abcd");
        file.createNewFile();
    }
    public static void main(String[] args) {
        criaArquivo();
    }
}
```

Assim, qualquer exceção da classe `IOException`, se não tratada (com `try/catch`), será lançada imediatamente.

---

# Cláusula throws

Agora o método `main` está chamando um método que lança exceções não-checadas. Ele também precisa fazer algo a respeito, seja usando `try/catch` ou `throws`. Caso opte por relançar a exceção, essa exceção é tratada pela máquina virtual Java, que imprime o *stack trace* e fecha o programa.

---

# Comparando com tratamento de erros em C

Em C, um programa que escreve em um arquivo possui código de tratamento de exceção intercalado com o código da funcionalidade:

```c
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>

int
main(int argc, char *argv[]) {
    char *path;
    int f;
    size_t stat;
    const char *message = "Hello, world.\n";

    if (argc != 2) {
        printf("Need filename\n");
        exit(1);
    }

    path = argv[1];

    f = open(path, O_CREAT | O_WRONLY | O_SYNC, S_IRWXU);
    if (f < 0) {
        perror("open out");
        exit(1);
    }/* if */

    stat = write(f, message, strlen(message));
    if (stat < 0) {
        perror("write");
        exit(1);
    }/* if */

    stat = fsync(f);
    if (stat) {
        perror("fsync");
        exit(1);
    }

    stat = close(f);
    if (stat) {
        perror("close");
        exit(1);
    }/* if */

    printf("(Apparently) successfully wrote '%s'\n", path);
    return 0;
}
```

Fonte: <https://stackoverflow.com/questions/11322262/how-do-i-detect-a-file-write-error-in-c>

--- 

# Comparando com tratamento de erros em C

Compare com um programa em Java para ler uma linha de um arquivo. O código de tratamento de exceções está todo no final:

```java
try {
    File file = new File("/tmp/abcd");
    FileInputStream fis = new FileInputStream(file);
    BufferedReader br = new BufferedReader(new InputStreamReader(fis));
    System.out.println(br.read());
    br.close();
} catch (FileNotFoundException e) {
    // ..
} catch (IOException e) {
    // ...
}
```

---

# Considerações sobre desempenho

O tratamento de exceções em Java introduz uma penalidade no desempenho do programa, uma vez que construir o *stack trace* da exceção é uma operação potencialmente custosa. Assim, evite usar `try/catch` dentro de um loop com muitas iterações se o desempenho for uma preocupação.


