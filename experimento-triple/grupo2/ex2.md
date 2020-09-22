---
layout: triple-page
title: L2 Experimento
---

## Início

Você agora vai iniciar a segunda lista de exercícios do experimento. Livre-se de qualquer distração e anote o horário atual.

<div>
<textarea></textarea>
</div>

## Digite a senha

Escreva um programa em que o usuário digita uma senha numérica e o programa informa `Senha correta` ou `Senha incorreta`, a depender do que foi digitado. A senha correta é `123`. O programa já está parcialmente escrito.

<textarea class="code lang-cpp">
#include &lt;iostream&gt;

using namespace std;

int main() {
  int senha;

  cin >> senha;

  cout << "Senha incorreta" << endl;
  
  return 0;
}</textarea>

<div class="testcases">
0 ]]] Senha incorreta
=====
-123 ]]] Senha incorreta
=====
123 ]]] Senha correta
</div>


## Faixa de risco

O programa a seguir pede a idade do usuário e dá as boas-vindas , com a mensagem `Bem-vindo(a)!`. No caso de usuários com idade entre 60 e 80 anos, o programa deve escrever `Faixa de risco` antes de dar as boas-vindas.

<textarea class="code lang-cpp">
#include &lt;iostream&gt;

using namespace std;

int main() {
  int idade;

  cin >> idade;

  // Se idade estiver entre 60 e 80 anos,
  // imprimir Faixa de risco

  cout << "Bem-vindo(a)!" << endl;
  
  return 0;
}</textarea>

<div class="testcases">
0 ]]] Bem-vindo(a)!
=====
59 ]]] Bem-vindo(a)!
=====
81 ]]] Bem-vindo(a)!
=====
60 ]]] Faixa de risco
Bem-vindo(a)!
=====
80 ]]] Faixa de risco
Bem-vindo(a)!
=====
64 ]]] Faixa de risco
Bem-vindo(a)!
</div>


## Fim do experimento

Você completou o experimento. Anote o horário atual. Calcule quantos minutos você demorou para resolver esta lista de exercícios e preencha no formulário do experimento.

<div>
<textarea></textarea>
</div>

Obrigado por participar!
