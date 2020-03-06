---
layout: remark
title: "Java: Alô mundo"
---

<div>

# História

- Criada por James Gosling, na Sun Microsystems
- Lançada em 1995
- Ainda hoje uma das linguagens de programação mais populares
- Sintaxe similar a C e C++
- Setembro de 2018: Java 11

---

# Características

- Orientada a objetos
- Gera bytecode, que roda na máquina virtual Java (JVM)
- A JVM possui versões para diversos sistemas operacionais
- Projetada para portabilidade: o mesmo programa compilado pode ser executado em vários sistemas operacionais
- Tem garbage collector (mecanismo de gerenciamento de memória automatizado)

---

# Baixando o Java

- Existem dois principais pacotes do Java: JRE e JDK
  - **JRE** (Java Runtime Engine) contém o necessário para **executar** programas em Java. Contém a JVM e o programa `java`, dentre outros
  - **JDK** (Java Development Kit) inclui o JRE e ferramentas necessárias para **desenvolver** programas em Java, como o compilador (`javac`) e o depurador (`jdb`)

---

# Experimente online

O site <repl.it> permite programar em diversas linguagens sem instalar nada, usando apenas o navegador e uma conexão à Internet. Uma dessas linguagens é o Java:

<https://repl.it/languages/java>

---

# Um programa mínimo

Crie um arquivo `AloMundo.java` com o seguinte conteúdo:

```java
public class AloMundo {
    public static void main(String[] args) {
        System.out.println("Alô, Mundo!");
    }
}
```

Explicação sucinta (detalharemos depois):

- Todo o código Java precisa estar dentro de alguma classe (ou estruturas similares a classes)
- Define a classe `AloMundo`, com um método estático chamado `main`
- Ao executar uma classe Java a partir do comando `java`, o interpretador busca dentro da classe o método `public static void main(String[] args)`; se encontrar, ele executa esse método
- A classe `System` possui um atributo estático `out`, que é um objeto que possui o método `println()` (ver [documentação](https://docs.oracle.com/javase/7/docs/api/java/lang/System.html)). Esse método é responsável por escrever na tela.

---

# Sobre nomes de arquivos

- Em Java, o nome do arquivo deve ser igual ao nome da classe nele contido, adicionado do sufixo `.java`.
- Em geral, cada arquivo contém exatamente uma classe, e cada classe é descrita em um arquivo
  - Pode haver mais de uma classe por arquivo, mas isso é assunto para outra aula

---

# Compilando e executando

Programas Java (`.java`) são **compilados** em um arquivo binário, chamado **bytecode** (`.class`), que não é executado diretamente pelo sistema operacional, e sim interpretado pela máquina virtual Java (**JVM**, de *java virtual machine*).

```shell
# Para compilar
javac AloMundo.java    # Cria arquivo AloMundo.class

# Para executar
java AloMundo          # Executa arquivo AloMundo.class
```

---

# Pacotes

- Pacotes
  - As classes (e estruturas similares) ficam dentro de pacotes.
  - Dentro de um pacote pode haver outros pacotes (estrutura hierárquica)
- Diretórios e pacotes
  - Cada pacote é representado por um diretório de mesmo nome
  - Ex.: O pacote br.ufba.dcc é representado pelo diretório br/ufba/dcc
  - Todos os arquivos .java dentro dessa pasta devem começar com a linha package br.ufba.dcc.
  - Por convenção, os nomes dos pacotes são escritos em minúsculas
- Domínio reverso
  - É comum estruturar os pacotes de acordo com a notação de nome de domínio reverso. Exemplo: se o site do seu software é <meuhorario.dcc.ufba.br>, você deve criar suas classes dentro do pacote br.ufba.dcc.meuhorario.
  - O uso de um domínio praticamente elimina a chance de duas organizações escolherem o mesmo nome de pacote
  - A ordem reversa ajuda a ordenar os pacotes (por exemplo, ao usar a ordem alfabética, br.ufba.dcc.disciplinas ficará perto de br.ufba.dcc.meuhorario)

---

# Alô mundo com pacotes

Crie a seguinte estrutura de diretórios e arquivos:

```
.
+-- br/
  +-- ufba/
    +-- AloMundo.java
```

Isso indica que `AloMundo` está dentro do pacote `ufba`, que por sua vez está dentro do pacote `br` (para abreviar, dizemos que `AloMundo` está no pacote `br.ufba`).

Para completar, só falta declarar o pacote na primeira linha do arquivo `AloMundo.java`:

```java
*package br.ufba;

public class AloMundo {
    public static void main(String[] args) {
        System.out.println("Alô, Mundo!");
    }
}
```

---

# Compilando e executando com pacotes

Considerando o exemplo anterior:

```shell
# Compila
javac br/ufba/AloMundo.java         # no Windows use \

# Executa
java br.ufba.AloMundo
```

</div>