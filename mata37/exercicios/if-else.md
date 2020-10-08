---
layout: page
title: Exercícios de if/else
---

## Orientações

Esta página contém alguns casos de teste para alguns problemas do JUDE. Note que não são necessariamente os mesmos casos de teste que o JUDE usa, então é possível que seu programa passe nesta página e falhe no JUDE.

Para testar seu programa, cole-o no editor de código e clique em `Rodar` (ou tecle `Ctrl+Enter`). Abaixo, aparecerá uma mensagem como `Testes: 100%` ou `Testes: 50% (Ver detalhes...)`. Clique em `Ver detalhes...` para ver um caso de teste no qual seu programa não está passando.

Neste corretor automático, a última instrução de seus programas deve ser `return 0;`, conforme exemplos abaixo.

Se você está curioso para saber quais casos de teste estão sendo utilizados, abra o código-fonte desta página e procure pela palavra `testcases`.

## K. Programa de Cálculo de Impostos

<textarea class="code lang-cpp">
#include &lt;iostream&gt;

using namespace std;

int main() {

  return 0;
}</textarea>

<div class="testcases">
500
]]]
Imposto: R$ 75
Salário líquido: R$ 425
=====
10000
]]]
Imposto: R$ 2250
Salário líquido: R$ 7750
=====
2999
]]]
Imposto: R$ 449.85
Salário líquido: R$ 2549.15
=====
3000
]]]
Imposto: R$ 450
Salário líquido: R$ 2550
=====
3001
]]]
Imposto: R$ 450.20
Salário líquido: R$ 2550.80
=====
5999
]]]
Imposto: R$ 1049.80
Salário líquido: R$ 4949.20
=====
6000
]]]
Imposto: R$ 1050
Salário líquido: R$ 4950
=====
6001
]]]
Imposto: R$ 1050.30
Salário líquido: R$ 4950.70
</div>

## I. Pu-Dean!

<textarea class="code lang-cpp">
#include &lt;iostream&gt;

using namespace std;

int main() {

  return 0;
}</textarea>

<div class="testcases">
0 0 0 0
]]]
0 h 0 m 0 s
=====
1000000000  1000000000  1000000000  1000000000
]]]
43715277 h 46 m 40 s
=====
1600  3200  800 400
]]]
139 h 53 m 20 s
=====
156 624 234 156
]]]
13 h 38 m 21 s
=====
324 1296  648 243
]]]
28 h 19 m 39 s
=====
316 1896  316 316
]]]
27 h 37 m 41 s
=====
244 1464  488 122
]]]
21 h 19 m 59 s
=====
160 1280  160 120
]]]
13 h 59 m 20 s
=====
100 800 150 50
]]]
8 h 44 m 35 s
=====
256 256 192 128
]]]
11 h 11 m 28 s
=====
672 672 672 252
]]]
29 h 22 m 36 s
=====
320 960 80  160
]]]
13 h 59 m 20 s
=====
152 456 152 19
]]]
6 h 38 m 41 s
=====
88  352 22  33
]]]
3 h 50 m 49 s
=====
456 1824  342 57
]]]
19 h 56 m 3 s
=====
252 168 84  84
]]]
7 h 20 m 39 s
=====
624 416 416 104
]]]
18 h 11 m 8 s
=====
228 304 38  76
]]]
6 h 38 m 41 s
=====
312 416 208 26
]]]
9 h 5 m 34 s
=====
984 2624  164 164
]]]
28 h 40 m 38 s
=====
744 1984  248 62
]]]
21 h 40 m 58 s
=====
208 104 52  39
]]]
4 h 32 m 47 s
=====
608 304 228 76
]]]
13 h 17 m 22 s
=====
368 368 46  69
]]]
8 h 2 m 37 s
=====
736 736 276 46
]]]
16 h 5 m 14 s
=====
1056  1584  132 132
]]]
23 h 4 m 54 s
=====
1136  1704  284 71
]]]
24 h 49 m 49 s
</div>

## Mínimo

Escreva um programa que lê 4 números inteiros e imprime o menor desses números.

<textarea class="code lang-cpp">
#include &lt;iostream&gt;

using namespace std;

int main() {

  return 0;
}</textarea>

<div class="testcases">
400 400 400 400]]]400=====
39 78 117 156]]]39=====
81 162 324 243]]]81=====
79 237 158 316]]]79=====
61 183 244 122]]]61=====
40 160 80 120]]]40=====
25 100 75 50]]]25=====
64 32 96 128]]]32=====
168 84 336 252]]]84=====
80 120 40 160]]]40=====
38 57 76 19]]]19=====
22 44 11 33]]]11=====
114 228 171 57]]]57=====
63 21 42 84]]]21=====
156 52 208 104]]]52=====
57 38 19 76]]]19=====
78 52 104 26]]]26=====
246 328 82 164]]]82=====
186 248 124 62]]]62=====
52 13 26 39]]]13=====
152 38 114 76]]]38=====
92 46 23 69]]]23=====
184 92 138 46]]]46=====
264 198 66 132]]]66=====
284 213 142 71]]]71
</div>