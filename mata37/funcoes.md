---
layout: remark
title: Funções
---

<div>

# Funções

Em programação, uma **função** é um bloco de código que executa uma tarefa específica.

Em um programa, toda vez que a tarefa precisar ser executada, o programa pode chamar a função.

Funções são uma forma de organizar melhor o código.

---

# Motivação

Considere o seguinte código, que imprime os números de 1 a 3:

```c++
cout << 1 << endl;
cout << 2 << endl;
cout << 3 << endl;
```

Agora imagine que você quer fazer isso duas vezes no seu programa. A primeira solução é duplicar o código:

```c++
cout << 1 << endl;
cout << 2 << endl;
cout << 3 << endl;

cout << 1 << endl;
cout << 2 << endl;
cout << 3 << endl;
```

---

# Motivação

Agora imagine que o código que imprime os números de 1 a 3 foram transformados em uma função chamada `imprime1a3`. Se você precisa executar essa tarefa duas vezes no programa, basta chamar a função `imprime1a3` duas vezes:

```c++
imprime1a3();
imprime1a3();
```

Cada uma das linhas é um *chamada* à função `imprime1a3()`. Quando uma função é chamada, o bloco de código correspondente é executado.

---

# Definição de função

Toda função possui um nome, um tipo de retorno e uma lista de parâmetros.

Considere o exemplo da função `imprime1a3`. Ela pode ser definida da seguinte forma:

```
void imprime1a3() {
	cout << 1 << endl;
	cout << 2 << endl;
	cout << 3 << endl;
}
```

Onde:

- `imprime1a3` é o **nome** da função
- `void` é o **tipo de retorno**; `void` significa "vazio"
- a **lista de parâmetros**, entre `(` e `)` é vazia
- o que está entre `{` e `}` é o **corpo** da função

---

# Definição de função

Em geral, a definição de função segue a seguinte forma:

```c++
tipoRetorno nome(tipo param1, tipo param2, ....) {
	corpoDaFunção
}
```

---

# Parâmetros

Funções podem definir parâmetros, que recebem valores quando a função é chamada.

Definição:

```c++
void imprimeSoma(int a, int b) {
	cout << (a + b) << endl;
}
```

Os parâmetros da função `imprimeSoma` são `a` e `b`, ambos do tipo `int`.

Chamada:

```c++
imprimeSoma(2, 3);
```

---

# Retorno

Funções também podem retornar valores para o código que realizou a chamada da função. Para isso, basta que o tipo de retorno seja diferente de `void`. A palavra-chave `return` indica o valor que será retornado. Quando o `return` é executado, a execução da função é interrompida imediatamente e volta para o chamador. Exemplo:

```c++
int soma(int x, int y) {
	return x + y;
}
```

Chamada:

```c++
int resultado;

resultado = soma(2, 3);
cout << resultado << endl;
```

---

# Variáveis locais

É possível declarar variáveis dentro do corpo das funções. Essas variáveis são chamadas de **variáveis locais** e só podem ser acessadas dentro das funções que as declararam. Exemplo:

```c++
int soma(int x, int y) {
	int resultado = x + y;
	return resultado;
}
```

---

# Exemplo: somatório

Crie uma função, `somatorio`, que recebe um número inteiro, `n`, e retorna o somatório dos números naturais consecutivos de 1 a `n`, ou seja, `1 + 2 + ... + n`.

---

# Exemplo: somatório

```c++
int somatorio(int n) {
	int i;
	int resultado = 0;

	for (i = 1; i <= n; i++) {
		resultado += i;
	}

	return resultado;
}
```

Exemplo de chamada:

```c++
cout << somatorio(5) << endl;
```

---

# Tópicos: main

Como você já deve ter percebido, `main` é uma função que retorna um valor do tipo `int` e não recebe nenhum parâmetro. Por convenção, essa função é chamada quando a execução do programa é iniciada.

```c++
int main() {
	return 0;
}
```

---

# Tópicos: passagem de parâmetros por valor

Considere o seguinte programa:

```c++
int sucessor(int num) {
	num = num + 1;
	return num;
}

int main() {
	int num = 5;
	int prox = sucessor(num);

	cout << num << endl;
	cout << prox << endl;
	return 0;
}
```

O que o programa vai imprimir?

---

# Tópicos: passagem de parâmetros por valor

O que a função `sucessor` recebe é uma cópia do valor da variável `num`.

A variável `num` definida em `main` não tem nada a ver com a variável `num` definida em `sucessor` (embora ambas as variáveis tenham o mesmo nome, e o valor de `num` seja passado como parâmetro da função `sucessor`). Portanto, a função `sucessor` modifica uma cópia de `num`; a variável `num` de `main` mantém seu valor original.

---

# Tópicos: variáveis globais

Variáveis globais podem ser acessadas de qualquer função do programa, inclusive a função `main`. Elas são declaradas no início do programa, fora de qualquer função. Exemplo:

```c++
#include <iostream>

using namespace std;

float temperatura = 20.0f;

void imprimeTemperatura() {
	cout << temperatura << endl;
}

int main() {
	imprimeTemperatura();
	temperatura = 25.0f;
	imprimeTemperatura();

	return 0;	
}
```

Use variáveis globais com moderação, pois seu uso excessivo pode tornar o programa mais difícil de entender.

---

# Tópicos: forward declarations

...


</div>

