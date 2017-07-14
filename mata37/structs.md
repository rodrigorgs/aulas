---
layout: remark
title: Structs
---

<div>

# Structs

Structs (também chamados de registros) são tipos de dados compostos, e representam uma lista de variáveis agrupadas sob um mesmo nome.

Structs são úteis para agrupar dados relacionados.

---

# Motivação

Considere variáveis para representar a matrícula, o ano de nascimento e a nota de dois alunos diferentes:

```c++
long aluno1Matricula;
int aluno1AnoNascimento;
float aluno1Nota;

long aluno2Matricula;
int aluno2AnoNascimento;
float aluno2Nota;
```

---

# Definição de um struct

Para melhorar a organização do código, podemos definir um struct, chamado `aluno`, que é uma composição de matrícula, ano de nascimento e nota:

```
struct aluno {
	long matricula;
	int anoNascimento;
	float nota;
}
```

Nesse exemplo, `matricula`, `anoNascimento` e `nota` são chamados de **membros** (ou **atributos**) do `struct aluno`.

---

# Uso de um struct

A struct simplifica as declarações de variáveis:

```
struct aluno fulano;
struct aluno sicrano;
```

Nesse caso, `fulano` e `sicrano` são variáveis do tipo `struct aluno`. Seus membros podem ser acessados usando um ponto:

```
fulano.matricula = 12345;
fulano.anoNascimento = 2000;
fulano.nota = 10.0f;

cout << fulano.nota << endl;
```

---

# typedef

A palavra-chave `typedef` é usada para definir apelidos para os tipos. Seu uso é na seguinte forma:

```c++
typedef tipoOriginal novoNome;
```

Exemplo:

```
typedef unsigned int uint;
```

Nesse caso, `unsigned int` é o tipo original e `uint` é o apelido que definimos. A partir de agora, podemos escrever `uint` no lugar de `unsigned int`. Exemplo:


```c++
uint idade, quantidade;
```

---

# typedef e struct

O typedef é comumente usado com structs para definir nomes curtos. Exemplo:

```c++
typedef struct {
	int idade;
	float peso;
} pessoa;
```

Nesse caso, o tipo `struct { int idade; float peso; }` recebeu o apelido `pessoa`. Assim, podemos declarar variáveis do tipo pessoa da seguinte forma:

```c++
pessoa fulano, sicrano;
```

---

# Inicialização

```c++
pessoa fulano = {18, 71.5f};
```

---

# Exemplo mais completo

Sem struct:

```c++
#include <iostream>

using namespace std;

int main() {
	int monstroX[20], monstroY[20];
	int i;

	for (i = 0; i < 20; i++) {
		cout << "A posicao do monstro " << i << " e' ";
		cout << monstroX[i] << ", " << monstroY[i] << endl;
	}
	return 0;
}
```

---

# Exemplo mais completo

Com struct:

```c++
#include <iostream>

using namespace std;

typedef struct {
	int x, y;
} ponto;

int main() {
	ponto monstros[20];
	int i;

	for (i = 0; i < 20; i++) {
		cout << "A posicao do monstro " << i << " e' ";
		cout << monstros[i].x << ", " << monstros[i].y << endl;
	}
	return 0;
}
```

---

# Exemplo mais completo com funções

```c++
#include <iostream>

using namespace std;

typedef struct {
	int x, y;
} ponto;

void imprimeMonstro(ponto monstro) {
	cout << "A posicao do monstro " << i << " e' ";
	cout << monstro.x << ", " << monstro.y << endl;
}

int main() {
	ponto monstros[20];
	int i;

	for (i = 0; i < 20; i++) {
		imprimeMonstro(monstros[i]);
	}
	return 0;
}
```

</div>

