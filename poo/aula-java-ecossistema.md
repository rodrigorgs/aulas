---
layout: remark
title: "Java: Ecossistema"
---

<div>

# Documentação de código-fonte e gerenciamento de dependências

---

class: middle, center

# Documentação de código-fonte

---

# Javadoc

- javadoc é uma ferramenta que gera documentação a partir de **comentários especiais** no código-fonte
- Ela foi usada, por exemplo, para gerar a [referência oficial do Java](https://docs.oracle.com/javase/9/docs/api/index.html?overview-summary.html)
- Para gerar a documentação, [execute o comando `javadoc`](https://docs.oracle.com/javase/9/javadoc/javadoc-command.htm) ou use sua IDE favorita.
- No Eclipse, acesse o menu `Project` > `Generate Javadoc...`

---

# Javadoc

- Os comentários especiais processados pelo javadoc começam com `/**` e terminam com `*/` e ficam logo acima de uma classe ou membro da classe
- Eles podem conter algumas diretrizes como `@author`, `@deprecated` (indica código obsoleto), `@see` (para indicar elementos relacionados), `@return` (indica o que um método retorna) etc. [Saiba mais...](https://www.tutorialspoint.com/java/java_documentation.htm)

```java
/**
 * Implementa diversas operações matemáticas.
 * @author Rodrigo
 */
public class Matematica {
  /**
   * Soma dois números inteiros.
   * @param a Primeira parcela da soma
   * @param b Segunda parcela da soma
   * @return A soma entre a e b.
   */
  public static int soma(int a, int b) {
    return a + b;
  }
}
```

---

class: middle, inverse

# Gerenciamento de dependências

---

# Gerenciamento de dependências

- Imagine que você tem um projeto que depende de várias bibliotecas
  - Em Java, as bibliotecas possuem o formato `.jar`, que é uma coleção de arquivos `.class`
- Você quer passar esse projeto para seu amigo continuar a desenvolver. Você tem duas opções:
  - Copia seu código-fonte e todas as bibliotecas (`.jar`) para seu amigo
  - Copia somente o código-fonte e fornece instruções de quais bibliotecas seu amigo deve baixar
- A primeira opção tem uma desvantagem: as bibliotecas podem ocupar muito espaço, e pode ser difícil ou lento transferir tudo para seu amigo
- A segunda opção tem uma desvantagem: seu amigo vai gastar um tempão acessando os sites de diversas bibliotecas para baixar todas as dependências

---

# Maven

- Maven é uma ferramenta de automação de compilação e gerenciamento de dependências para Java
- Ao criar um projeto Java usando o Maven, você pode especificar uma lista de dependências
- Com um comando, é possível baixar automaticamente todas as dependências do projeto

---

# Maven: prática

- Para esta prática vamos usar a IDE Eclipse
- Crie um novo projeto Maven:
  - Clique em `File` > `New` > `Project...`
  - Selecione `Maven` > `Maven Project`
  - Marque a caixa `Create a simple project (skip archetype selection)` e clique em `Next >`
  - Pense no nome do pacote que você usará para seu projeto. Ex.: `br.ufba.meuprojeto`
  - Digite o nome do pacote (exceto o último pacote) em `Group Id`. Ex.: `br.ufba`
  - Digite o nome do último pacote em `Artifact Id`. Ex.: `meuprojeto`
  - Cliquem em `Finish`

---

# Maven: prática

Um projeto Maven tem a seguinte estrutura básica:

```
src/
  main/
    java/ -- aqui fica o código-fonte Java
    resources/ -- aqui ficam outros arquivos (imagens, texto...)
  test/
    java/ -- aqui fica o código usado para teste
    resources/ -- aqui ficam outros arquivos usados para teste
target/ -- aqui ficam os arquivos compilados (.class)
pom.xml -- aqui ficam a lista de dependências e outras configurações
```

---

# Maven: prática

- Vamos criar um método estático, `String mascaraSenha(String senha)` que recebe uma senha (`String`) e retorna a senha mascarada com asteriscos. Ex.: `1234` => `****`
- Vamos usar um método na biblioteca [Apache Commons Lang](https://commons.apache.org/proper/commons-lang/) que cria uma string a partir da repetição de um caractere várias vezes
- Para usarmos a biblioteca, vamos adicioná-la ao `pom.xml`:
  - Dentro da tag `<project>`, crie uma tag `<dependencies>`
  - Cole dentro da tag `<dependencies>` o código XML que está no site da biblioteca

---

# Maven: prática

O resultado ficará mais ou menos assim:

```xml
<project ...>
  ...

	<dependencies>
		<dependency>
			<groupId>org.apache.commons</groupId>
			<artifactId>commons-lang3</artifactId>
			<version>3.9</version>
		</dependency>
	</dependencies>
</project>
```

Ao salvar o arquivo, o Eclipse automaticamente baixará a biblioteca e a incorporará ao projeto.

---

# Maven: prática

- Agora você já poderá usar todas as classes e métodos da biblioteca no seu projeto
- Crie uma classe para implementar seu método de mascarar senha
- Você usará o método `repeat` da classe `StringUtils`. Consulte a documentação (javadoc) para mais informações
  - Use o recurso de autocompletar da IDE para importar a classe `StringUtils` no seu arquivo `.java`.

</div>