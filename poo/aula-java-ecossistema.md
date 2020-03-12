---
layout: remark
title: "Java: Ecossistema"
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

# Maven

TODO