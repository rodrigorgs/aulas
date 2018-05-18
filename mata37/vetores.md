---
layout: remark
title: Vetores
---

<div>

# Vetores

Um vetor (em inglês, *array*) é uma estrutura que armazena uma quantidade determinada de valores do mesmo tipo. Exemplo: vetor de inteiros de tamanho 5:

```
+---+---+---+---+---+
| 6 | 4 | 9 | 0 | 2 |
+---+---+---+---+---+
```

O vetor ocupa posições contíguas na memória do computador.

---

# Vetores

Em vez de criar 5 variáveis, 

```c++
int num1, num2, num3, num4, num5;
```

você pode criar um vetor nums com 5 elementos

```c++
int nums[5];
```

e acessá-los assim:

```c++
cin >> nums[0] >> nums[1];
nums[0] = nums[0] + nums[1] * 3;
cout << nums[0] * 3 << endl;
```

Note que, em C++, a primeira posição do vetor é a posição 0. Assim, o vetor `nums` tem 5 posições: `nums[0]`, `nums[1]`, `nums[2]`, `nums[3]`, `nums[4]`.

---

# Declaração

A declaração de um vetor se dá da seguinte forma:

*tipo* nomeDoVetor[*tamanho*];

Exemplo: 

```c++
double notas[20];
```

---

# Inicialização

Você pode inicializar o vetor na sua declaração. Exemplo: 

```c++
double notas[4] = {7.5, 9.3, 3.4, 8.5};
```

Se você fornecer menos valores do que o tamanho do vetor, as posições restantes são inicializadas com 0. Exemplos:

```c++
double notas[4] = {2.0};  // equivalente a {2.0, 0.0, 0.0, 0.0}
double medias[5] = {0.0}; // inicializa tudo com 0
```

---

# Inicialização

Ao fazer a inicialização, o tamanho do vetor pode ser omitido (ele vai ser igual à quantidade de valores fornecidos):

```c++
double notas[] = {7.5, 9.3, 3.4, 8.5};
```

**Nunca se esqueça de inicializar os valores de um vetor antes de lê-los.**

---

# Acesso

Para acessar um elemento do vetor:

nomeDoVetor[indice]

*Índice* é o número que determina a posição de um elemento do vetor que se deseja acessar. Em C++, os vetores são sempre indexados a partir de zero (ou seja, o primeiro índice é zero).

Note que entre colchetes você pode usar **qualquer expressão aritmética** que retorne um índice válido. Exemplo:

```c++
int vetor[] = {7, 4, 0, 5, 8, 3, 2, 1, 3};
int i;
cin >> i;
cout << vetor[i] << endl;
cout << vetor[i + 1] << endl;
```

O que esse programa faz?

---

# Exercício

Escreva um programa que lê 10 números e imprime-os do último para o primeiro. Solução ingênua:

```c++
int num1, num2, ..., num10;

cin >> num1;
...
cin >> num10;

cout << num10 << endl;
...
cout << num1 << endl;
```

---

# Exercício (solução)

```c++
#include <iostream>

using namespace std;

int main() {
  int i;
  int valores[10];

  for (i = 0; i < 10; i++) {
    cin >> valores[i];
  }

  for (i = 9; i >= 0; i--) {
    cout << valores[i] << endl;
  }

  return 0;
}
```

---

# Limites do vetor

O que acontece se você acessar uma posição inválida do vetor? Exemplo:

```c++
int x = {2, 4, 6, 8};
cout << x[10] << endl;
```

---

# Limites do vetor

O que acontece se você acessar uma posição inválida do vetor?

Em algumas linguagens aparece um erro. Na linguagem Java, por exemplo, aparece um erro mais ou menos assim: `Exception in thread "main" java.lang.ArrayIndexOutOfBoundsException:`

Em C++, a depender do sistema, não aparece nenhum erro; em vez disso, o programa lê o valor que está em uma posição da memória que não pertence ao vetor.

```c++
int x = {2, 4, 6, 8};
cout << x[10] << endl;
```

(A saída pode ser algo como -669435648 ou 32764...)

---

# Usar vetor para substituir if

Com `if`:

```c++
#include <iostream>

using namespace std;

int main() {
  int pedido, qtd;

  cout << "Digite o pedido (0 = suco, 1 = água): ";
  cin >> pedido;
  cout << "Digite a quantidade: ";
  cin >> qtd;

  cout << "Valor: ";
  if (pedido == 0) {
    cout << qtd * 2.00 << endl;
  } else if (pedido == 1) {
    cout << qtd * 1.50 << endl;
  }

  return 0;
}
```

---

# Usar vetor para substituir if

```c++
#include <iostream>

using namespace std;

int main() {
  int pedido, qtd;
  double valorUnit[2];

  cout << "Digite o pedido (0 = suco, 1 = água): " 
  cin >> pedido;
  cout << "Digite a quantidade: ";
  cin >> qtd;

  cout << "Valor: ";
  if (valor >= 0 && valor <= 1) {
    cout << valorUnit[pedido] * qtd << endl;
  }

  return 0;
}
```

Ao usar a entrada para indexar o vetor, cheque se o índice está dentro dos limites!

---

# Sentinela

---

# Exercícios sugeridos

- [Cédulas](https://www.urionlinejudge.com.br/judge/pt/problems/view/1018): resolva usando vetor para tornar o código compacto;
- Ler as notas dos alunos e plotar um histograma

</div>