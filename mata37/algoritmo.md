---
layout: remark
title: Algoritmo
---

<div>

# Algoritmo

Um algoritmo é uma sequência de passos bem definidos para resolver um problema.

<!-- Algoritmos devem ser expressos dentro de uma quantidade **finita** de espaço e tempo. -->

Na computação, algoritmos transformam valores de entrada em valores de saída (como funções).

---

# Exemplo: receita

- Entrada:
  - 2 xícaras (chá) de açúcar
  - 3 xícaras (chá) de farinha de trigo
  - 4 colheres (sopa) de margarina
  - 3 ovos
  - 1 e 1/2 xícara (chá) de leite
  - 1 colher (sopa) bem cheia de fermento em pó
- Saída: bolo simples
- Instruções: <http://www.tudogostoso.com.br/receita/29124-bolo-simples.html>
- Os passos são bem definidos?

---

# Exemplo: cubo mágico

- Entrada: cubo bagunçado
- Saída: cubo arrumado
- Instruções: <https://www.rubiks.com/solve-it/3x3/>

---

# Alguns elementos básicos de algoritmos

Você consegue identificar nos exemplos os seguintes elementos?

- Sequência de passos
- Dados
- Condicionais (`se` isso `então` aquilo)
- Repetição (`repita` até, repita X vezes...)

---

# Exemplo: Keep Talking and Nobody Explodes

Jogo [Keep Talking and Nobody Explodes](http://jogabilida.de/bomb)

---

# Exemplo: troco

Como dar um troco usando o menor número possível de cédulas e moedas?

Ex.: R$ 3,30 = R$ 2 + R$ 1 + R$ 0,25 + R$ 0,05

- Entrada: ?
- Saída: ?
- Instruções: ?

---

<!-- 
# Exemplo: adivinhe o número

 -->

# Exemplo: ordenação

- Entrada: lista de coisas bagunçada
- Saída: lista de coisas em ordem
- Instruções: várias opções...
- Você consegue explicar para outra pessoa o passo-a-passo de como ordenar uma lista de coisas?

---

# Outros exemplos?

- Dança
- Exercício físico

---

# Representação de algoritmos

- Linguagem natural
- Pseudolinguagem
- Fluxograma
- Linguagem de programação

---

# Linguagem natural

Algoritmo descrito em português. Ex.: receita de bolo.

Dá margem a ambiguidade!

---

# Linguagem natural

Minha mulher disse: "Amor, vá até o mercado e compre 1 caixa de leite. Se eles tiverem ovos, traga 6."

--

Eu voltei para casa com 6 caixas de leite.

--

Ela disse: "Por que diabos você comprou 6 caixas de leite?"

--

Eu respondi: "Porque eles tinham ovos."

--

*(o problema de ser programador)*

---

# Fluxograma

![:height 70vh](https://upload.wikimedia.org/wikipedia/commons/thumb/4/46/LampFlowchart_pt.svg/250px-LampFlowchart_pt.svg.png)

---

# Fluxograma

![:height 70vh](http://3.bp.blogspot.com/_iunkzWDVQMI/S5K_8yAHzwI/AAAAAAAAAHw/KP0xkGPtUPw/w1200-h630-p-k-no-nu/untitled.bmp)

---

# Pseudolinguagem

Baseada na linguagem natural, porém mais bem definida

```
vá ate o mercado
qtdOvos <- 0
qtdCaixasDeLeite <- 1
se ovosDisponiveis > 0 então
  qtdOvos <- 6
tragaLeite(qtdCaixasLeite)
tragaOvos(qtdOvos)
```

---

# Linguagem de programação

É uma linguagem formal que especifica uma conjunto de instruções que podem ser usadas.

Algoritmos expressos em uma linguagem de programação são chamados de programas e podem ser executados por um computador.

Código ou código-fonte é o texto do programa.

---

# Linguagem de programação

Existem muitas linguagens de programação. Você já ouviu falar em quais linguagens de programação?

<https://repl.it/languages/>

---

# Linguagem de programação

Determinar se uma pessoa pode beber álcool no Brasil. Linguagem C++:

```c++
#include <iostream>

using namespace std;

int main() {
  int idade;
  
  cin >> idade;
  if (idade < 18) {
    cout << "Não" << endl;
  } else {
    cout << "Sim" << endl;
  }
}
```

---

# Linguagem de programação

Determinar se uma pessoa pode beber álcool no Brasil. Linguagem Scheme:

```scheme
(begin
  (let ((idade (read)))
  (print
    (if (< idade 18)
        "Não"
        "Sim")))
```

---

# Linguagem de programação

Determinar se uma pessoa pode beber álcool no Brasil. Linguagem Ruby:

```ruby
idade = gets.to_i
puts idade < 18 ? "Não" : "Sim"
```

---

# Linguagem de programação

Seu programa é executado por outro programa. Se você não seguir a linguagem corretamente, dá erro!

- No exemplo em C++, remova um dos `;`
- No exemplo em C++, troque `idade < 18` por `idadi < 18`
- No exemplo em C++, apague as linhas em branco
- O que acontece em cada um dos casos?

</div>

