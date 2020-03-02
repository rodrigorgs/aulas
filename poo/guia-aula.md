---
layout: page
---

<!-- 
Os paradigmas de programação e o elevador

Elevador: abre, fecha porta, subir, descer

- ASM: você liga os fios para ativar as funções. todo mundo que chega tem que saber quais são os fios, e tem que controlar quanto tempo leva para chegar no andar desejado

 -->

# Java e orientação a objetos básica

Use o Eclipse para criar um projeto Java contendo uma classe `br.ufba.poo.Alo`, que, quando executada, imprime a raiz quadrada do número 10. Para calcular a raiz quadrada, use o método `Math.sqrt(x)`.

---

<!-- Entrada/saída -->

Escreva um programa que lê dois números inteiros do teclado e imprime o produto entre eles.

<b><span data-hint="Você precisará de um objeto Scanner para ler da entrada padrão. Assim: Scanner input = new Scanner(System.in);" class="hint-bottom-middle">[Dica 1]</span></b>

<b><span data-hint="int x = input.nextInt();" class="hint-bottom-middle">[Dica 2]</span></b>

---

<!-- Arrays -->

Escreva um programa que lê 5 números inteiros e imprime esses números em ordem inversa.

<b><span data-hint="Você precisará de um array." class="hint-bottom-middle">[Dica 1]</span></b>

---

<!-- Classes, atributos e métodos -->

Crie uma classe `br.ufba.poo.Retangulo`, que representa um retângulo, com largura e altura (do tipo double), contendo os seguintes métodos:

- `double calculaArea()`: retorna o produto da largura pela altura
- `double calculaPerimetro()`: retorna a soma dos lados do retângulo

Crie também uma classe `br.ufba.poo.Main`, que, quando executada, cria dois retângulos e imprime a área e o perímetro de cada um

Bônus: não use a palavra-chave `this`.

---

<!-- static -->

Crie uma classe `br.ufba.poo.Participante`, com os seguintes membros:

- `nome` (do tipo `String`)
- `contador` (do tipo `int`)
- `void imprimeContador()`: imprime o texto `"Total de participantes: N"`, onde `N` é o número de participantes já instanciados

O atributo `contador` deve guardar o número de objetos da classe `Participante` que já foram instanciados desde o início da execução do programa. Exemplo de programa usando a classe `Participante`:

```java
// ...
Participante p1 = new Participante();
Participante p2 = new Participante();
Participante p3 = new Participante();
Participante.imprimeContador(); // deve imprimir 3
```

<b><span data-hint="Você precisará usar a palavra-chave static." class="hint-bottom-middle">Dica</span></b>

---

<!-- static -->

Crie uma classe `Produto`, como a seguir:

```java
package br.ufba.poo;

public class Produto {
    double preco;
    static final double descontoBoleto = 0.10;

    static double precoFinal(boolean pagamentoBoleto) {
        if (pagamentoBoleto) {
            return preco * descontoBoleto;
        } else {
            return preco;
        }
    }
}
```

Considere que o `descontoBoleto` é válido para qualquer produto (ex.: celular, televisão, pneu...)

- Por que dá erro de compilação? Como corrigir?
- Considere que o `descontoBoleto` pode ser alterado (para todos os produtos) durante a execução do programa, em função de datas comemorativas. O que seria necessário alterar no programa?