---
layout: remark
title: Introdução a C
---

<div>

# C ou C++?

- C++ é um superconjunto de C
- Vamos usar C com alguns poucos recursos de C++
- Por isso, precisaremos de um compilador de C++

---

# Compiladores

- GNU C Compiler (gcc)
- Clang / LLVM
- Compilador do Visual Studio

---

# Alô mundo

Crie um arquivo chamado `alo.cc` com o seguinte conteúdo:

```c++
#include <iostream>

using namespace std;

int main() {
  cout << "Alo mundo!" << endl;

  return 0;
}
```

Você pode usar um editor de código como o gedit, o Geany...

---

# Compilador gcc

```bash
g++ alo.cc
./a.out
```

---

# Compilador gcc

```bash
g++ alo.cc -o alo
./alo
```

---

# Compilador gcc

```bash
g++ -Wall alo.cc -o alo
./alo
```

---


# Alô mundo

```c++
#include <iostream>

using namespace std;

int main() {
  cout << "Alo mundo!" << endl;

  return 0;
}
```

A linha

```c++
#include <iostream>
```

inclui as funções de entrada e saída de dados (I/O, do inglês *input/output*) da biblioteca padrão do C++.

---

# Alô mundo


```c++
#include <iostream>

using namespace std;

int main() {
  cout << "Alo mundo!" << endl;

  return 0;
}
```

A linha

```c++
using namespace std;
```

permite abreviar algumas palavras da biblioteca padrão (std, do inglês *standard*) do C++. Sem essa linha, seria necessário escrever `std::cout` e `std::endl`.

---

# Alô mundo


```c++
#include <iostream>

using namespace std;

int main() {
  cout << "Alo mundo!" << endl;

  return 0;
}
```

A linha

```c++
int main() {
```

indica o início da função `main`, onde o programa inicia a sua execução.

---

# Alô mundo


```c++
#include <iostream>

using namespace std;

int main() {
  cout << "Alo mundo!" << endl;

  return 0;
}
```

A linha

```c++
  cout << "Alo mundo!" << endl;
```

Imprime a frase `Alo mundo!` na tela, finalizada por uma quebra de linha (`endl`, do inglês *end line*).

---

# Alô mundo


```c++
#include <iostream>

using namespace std;

int main() {
  cout << "Alo mundo!" << endl;

  return 0;
}
```

A linha

```c++
  return 0;
```

retorna o código 0 para o sistema operacional (por convenção, indica que o programa foi bem-sucedido, sem erro).

---

# Alô mundo


```c++
#include <iostream>

using namespace std;

int main() {
  cout << "Alo mundo!" << endl;

  return 0;
}
```

A linha

```c++
#include <iostream>
```

inclui as funções de entrada e saída de dados.

---

# Alô mundo


```c++
#include <iostream>

using namespace std;

int main() {
  cout << "Alo mundo!" << endl;

  return 0;
}
```

A linha

```c++
}
```

indica o fim da função `main`.

---

# Comentários

São ignorados pelo compilador. Dois propósitos principais:

- Se comunicar com o programador
- Desabilitar temporariamente uma ou mais linhas de código
- (também podem ser usados para gerar documentação, como no caso do Doxygen)

---

# Comentários

```c++
// comentário de uma linha

/* comentário
com várias
linhas */
```

---

# Expressões aritméticas

```c++
#include <iostream>

using namespace std;

int main() {
  cout << "O dobro de cinco: " << 2 * 5 << endl;

  return 0;
}
```

</div>