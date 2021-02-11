# Estrutura de uma classe

```java
<modificadores?> class <NomeDaClasse> {
  <atributos>
  <métodos>
  <classes internas> 
}
// Os modificadores são opcionais
```

---

# Estrutura de uma classe

Ex.:

```java
public class Carro {
  float velocidade;
  float aceleracao;
  
  void acelera(float deltaT) {
    velocidade += aceleracao * deltaT;
  }
}
```

---

# Estrutura de uma classe

Ex.:

```java
public class Pessoa {
  Pessoa pai;
  Pessoa mae;
  Carro veiculo;

  Pessoa responsavel() {
    return mae == null ? pai : mae;
  }
}
```

---

# Declaração de atributos

```java
<modificadores?> <tipo> <nome> < = valor inicial?>
// modificadores seguem o seguinte formato:
// <visibilidade?> <static?> <final?>
// visibilidade pode ser:
//   public, private, protected
```

Ex.:

```java
public static final double versao = 1.8;
int quantidade;
```

---

# Declaração de atributos

- Atributos de tipos primitivos são automaticamente inicializados com valores padrão: tipos numéricos são inicializados com zero, `boolean` é inicializado com `false`, `char` é inicializado com o caractere cujo código ASCII é zero.
- Isso só vale para atributos: variáveis locais não são inicializadas automaticamente
- É boa prática sempre inicializar variáveis e atributos.

---

# Declaração de métodos

```java
<modificadores?> <tipo de retorno> <nome>(<lista de parâmetros?>)
// Modificadores seguem o seguinte formato:
// <visibilidade?> <abstract?> <static?>
```

Ex.:

```java
public static int soma(int a, int b)
void exibe(String mensagem)
protected abstract void executa()
```

---

# Instanciando um objeto

---

# Instanciando um objeto

- Para instanciar/construir um objeto a partir de uma classe, usa-se o operador `new`
  - Ex.: `Carro meuPorsche = new Carro();`
- Algumas classes aceitam parâmetros na hora de construir um objeto
  + Ex.: `Date dataDeNascimento = new Date(84, 12, 28);`
  + Dessa forma os atributos já são inicializados com os valores desejados
  + (Observação extra: *deprecated*)

---

# Revisitando AloMundo

- No exemplo anterior, criamos uma classe, mas não a instanciamos (i.e., não criamos um objeto)
  + Nosso programa não é tão diferente de um programa procedimental
- Outra forma de escrever

```java
public class AloMundo {
  public String sujeito = "mundo";

  public void cumprimenta() {
    System.out.println("Alô, " + sujeito + "!");
  }

  public static void main(String[] args) {
    AloMundo alo = new AloMundo();
    alo.cumprimenta();
    alo.sujeito = "você";
    alo.cumprimenta();
  }
}
```

---

# Revisitando AloMundo

```java
// arquivo AloMundo.java
public class AloMundo {
  public static void main(String[] args) {
    Telefonista tel1 = new Telefonista();
    tel1.sujeito = "você";
    Telefonista tel2 = new Telefonista();
    tel1.cumprimenta();
    tel2.cumprimenta();
  }
}

// arquivo Telefonista.java
public class Telefonista {
  public String sujeito = "mundo";

  public void cumprimenta() {
    System.out.println("Alô, " + sujeito + "!");
  }  
}
```

---

# Exemplo: Retângulo

```
public class Retangulo {
  public float base;
  public float altura;

  public float area() {
    return base * altura;
  }
}
```

---

# Destruindo um objeto

---

# Destruindo um objeto

- O operador `new` cria um objeto, e para isso ele aloca espaço na memória para o objeto
- E quando não precisarmos mais do objeto, como liberar o espaço alocado?
- Em Java, o programador não consegue desalocar objetos explicitamente; isso é feito de forma automática pelo coletor de lixo (*garbage collector*)

---

# Coletor de lixo (garbage collector)

- O coletor de lixo é um processo que roda na JVM que é responsável por desalocar os objetos que não estão sendo referenciados por nenhum atributo ou variável (o "lixo")
- Por questões de eficiência, ele pode "deixar o lixo acumular" para liberar vários objetos de uma vez
- Se há muita memória livre, a coleta de lixo pode ser adiada
- Na prática, o programador não tem como saber quando a coleta de lixo será realizada

---

# Construtores

---

# Construtores

- Lembra de Estrutura de Dados (em C), quando você criou uma lista encadeada e esqueceu de chamar a função para inicializá-la, resultando em um erro que você passou horas tentando encontrar?
- Linguagens OO possuem um mecanismo, os **construtores**, para garantir que o programador que usar sua classe nunca vai se esquecer de inicializar seus objetos.

---

# Construtores

- Construtores são estruturas similares a métodos, usadas para inicializar objetos
- Eles são chamados quando se instancia um objeto usando `new`
- Formato:

```java
<visibilidade?> <NomeDaClasse>(<parametros?>) {
  <corpo>
}
```

---

# Construtores

Exemplo:

```java
public class Aluno {
  int semestre;

  public Aluno() {
    semestre = 1;
  }
}
```

---

# Construtores

Exemplo de chamada:

```java
Aluno a = new Aluno();
System.out.println(a.semestre);
```

---

# Construtores

Uma classe pode ter mais de um construtor. Exemplo:

```java
public class Aluno {
  int semestre;

  public Aluno() {
    semestre = 1;
  }

  public Aluno(int semestreInicial) {
    semestre = semestreInicial;
  }
}
```

---

# Construtores

Exemplo de uso:

```java
Aluno a = new Aluno();
Aluno b = new Aluno(4);
System.out.println(a.semestre);
System.out.println(b.semestre);

```

---

# Construtor padrão

- Se você não define um construtor para sua classe, o compilador Java cria para você o **construtor padrão**: um construtor que não recebe parâmetros e que não faz nada
- Se você define pelo menos um construtor, o **construtor padrão** não é criado

---

# Construtor padrão

```java
public class Aluno {
  int semestre;

  public Aluno(int semestreInicial) {
    semestre = semestreInicial;
  }

  public static void main(String[] args) {
    Aluno x = new Aluno();
    // ERRO DE COMPILAÇÃO:
    // A classe Aluno não possui construtor
    // sem parâmetros!
  }
}
```

---

# Palavra-chave this

- Dentro de uma classe, a palavra-chave `this` é uma referência para o objeto atual. Exemplo:

```java
public class Pessoa {
  Pessoa euProprio() {
    return this;
  }
}
```

---

# Palavra-chave this

- A palavra this é útil em construtores para resolver ambiguidades, quando o parâmetro tem o mesmo nome de um atributo:

```java
public class Aluno {
  int semestre;

  public Aluno(int semestre) {
    this.semestre = semestre;
  }
}
```

---

# Palavra-chave this

A palavra this, usada dentro de um construtor, também pode ser usada para se referir a outro construtor da mesma classe. Exemplo:

```java
public class Aluno {
  String nome;
  int semestre;

  public Aluno(String nome, int semestre) {
    this.semestre = semestre;
  }
  public Aluno(String nome) {
    this(nome, 1);
  }
}
```

---

# Palavra-chave this

`this` pode ser usada para passar o objeto atual como parâmetro para algum método:

```java
public class Aluno {
  String nome;
  int semestre;

  public void matriculaEm(Curso curso) {
    curso.adicionaAluno(this);
  }
}
```
