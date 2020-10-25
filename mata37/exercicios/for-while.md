---
layout: page
title: Exercícios de for/while
---

## Orientações

Esta página contém alguns casos de teste para alguns problemas do JUDE. Note que não são necessariamente os mesmos casos de teste que o JUDE usa, então é possível que seu programa passe nesta página e falhe no JUDE.

Para testar seu programa, cole-o no editor de código e clique em `Rodar` (ou tecle `Ctrl+Enter`). Abaixo, aparecerá uma mensagem como `Testes: 100%` ou `Testes: 50% (Ver detalhes...)`. Clique em `Ver detalhes...` para ver um caso de teste no qual seu programa não está passando.

Neste corretor automático, a última instrução de seus programas deve ser `return 0;`, conforme exemplos abaixo.

Se você está curioso para saber quais casos de teste estão sendo utilizados, abra o código-fonte desta página e procure pela palavra `testcases`.

## Black Jack

<textarea class="code lang-cpp">
#include &lt;iostream&gt;

using namespace std;

int main() {

  return 0;
}</textarea>

<div class="testcases">
3 10 10 1 9 8 4]]]Empate.=====
1 19 19]]]Empate.=====
1 20 19]]]Jogador A vence com 20 pontos.=====
1 21 19]]]Jogador A vence com BlackJack.=====
1 22 19]]]Jogador B vence com 19 pontos.=====
1 19 20]]]Jogador B vence com 20 pontos.=====
1 20 20]]]Empate.=====
1 21 20]]]Jogador A vence com BlackJack.=====
1 22 20]]]Jogador B vence com 20 pontos.=====
1 19 21]]]Jogador B vence com BlackJack.=====
1 20 21]]]Jogador B vence com BlackJack.=====
1 21 21]]]Empate.=====
1 22 21]]]Jogador B vence com BlackJack.=====
1 19 22]]]Jogador A vence com 19 pontos.=====
1 20 22]]]Jogador A vence com 20 pontos.=====
1 21 22]]]Jogador A vence com BlackJack.=====
1 22 22]]]Empate.=====
1 22 23]]]Empate.=====
1 23 22]]]Empate.
</div>
