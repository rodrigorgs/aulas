---
layout: remark
title: Entrada e saída
---

<div>

# Entrada e saída

- Entrada e saída se referem ao fluxo de dados em um programa de computador
- Dispositivos de **entrada** incluem teclado, mouse, câmera, microfone, leitor de digitais...
- Dispositivos de **saída** incluem monitor, caixa de som, impressora...

---

# Console

Os programas que vamos criar rodam no console (termos relacionados: terminal, linha de comando).

No console, os usuários podem passar dados para um programa através do teclado. Isso é chamado de **entrada padrão**.

Os programas, por sua vez, imprimem informações no console. Isso é chamado de **saída padrão**.

---

# C++: cin, cout

Em C++, a entrada e saída se dá com as palavras `cin` (*console input*, entrada padrão) e `cout` (*console output*, saída padrão).

Para usar `cin` e `cout` no seu programa, você precisa incluir as seguintes linhas no início do seu código.

```c++
#include <iostream>

using namespace std;
```

`iostream` é a biblioteca do C++ que define `cin`, `cout`, dentre outras coisas.

---

# Imprimindo no console

Exemplo simples:

cout << "Isto vai ser impresso no console";

---

# Imprimindo no console

O formato geral para imprimir no console é:

```c++
cout << expressão1 << expressão2 << ... << expressãoN;
```

As expressões são *concatenadas*, da esquerda para a direita.

Cada expressão pode ser uma sequência de caracteres entre aspas (*string*), um número, uma variável ou outras [expressões aritméticas](aritmetica). Exemplo:

```c++
int numero = 11;
cout << "O triplo de " << numero << " eh " << numero * 3;
```

---

# Quebra de linha

Ao final de uma linha deve-se inserir uma *quebra de linha*, que é denotada por `"\n"` ou por `endl`. Exemplos:

```c++
cout << "Isto eh uma linha" << endl;
cout << "Isto eh uma linha" << "\n";
cout << "Isto eh uma linha\n";
cout << "Isto sao duas\nlinhas" << endl;
```

---

# Imprimindo números com precisão definida

```c++
#include <iostream>
#include <iomanip>

using namespace std;

int main() {
  cout << fixed << setprecision(2) << 3.5 << endl;
  return 0;
}
```

O programa acima imprimirá `3.50`, isto é, com 2 casas decimais. Note que para usar `fixed` e `setprecision`, é necessário adicionar `#include <iomanip>`

---

# Lendo do teclado

O código abaixo lê 3 números. O usuário deve digitar os três números separados por espaços em branco ou quebras de linha. O programa só avança para a próxima linha (`cout << ...`) depois que todos os números forem digitados.

```c++
int x, y, z;
cin >> x >> y >> z;
cout << "O ultimo numero foi " << z << endl;
```

Note que com o `cin`, usa-se `>>`, enquanto no `cout` usa-se `<<`.

---

# Lendo do teclado

Outra forma de escrever o mesmo programa:

```c++
int x, y, z;
cin >> x;
cin >> y;
cin >> z;
```

---

# C: scanf, printf

A linguagem C fornece as funções `scanf` e `printf` para entrada e saída de dados, respectivamente.

O uso dessas funções não será cobrado, pois envolve conceitos mais complexos, mas é fortemente recomendado que você tenha ao menos um conhecimento superficial.

Exemplos:

```c++
int x, y, z;
scanf("%d%d%d", &x, &y, &z);
printf("Soma: %d\n", x + y + z);
```

</div>