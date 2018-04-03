---
layout: remark
title: Introdução a C
---

<div>

# Linguagem de programação

Neste curso vamos usar a linguagem de programação C++.

- C++ foi projetada entre 1979 e 1985 por Bjarne Stroustrup.
- C++ é uma extensão da linguagem C, lançada em 1972, projetada por Dennis Ritchie.
- Boa parte do que estudaremos vem da linguagem C; usaremos apenas alguns recursos próprios do C++.

---

# Executando um programa em C++

- Para iniciar os estudos, vamos usar o site [repl.it](https://repl.it/languages/cpp)

---

# Alô mundo

Crie um arquivo com o seguinte conteúdo:
<!-- chamado `alo.cc` -->

```c++
#include <iostream>

using namespace std;

int main() {
  cout << "Alo mundo!" << endl;

  return 0;
}
```

<!-- Você pode usar um editor de código como o gedit, o Geany... -->

---

# Rode o seu programa

Clique no botão `play`.

---

# Alô mundo - explicação

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

# Alô mundo - explicação


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

# Alô mundo - explicação


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

# Alô mundo - explicação


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

Imprime a frase `Alo mundo!` na tela, finalizada por uma quebra de linha (`endl`, do inglês *end line*). Alternativa: cout << "Alo mundo!\n";

---

# Alô mundo - explicação


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

# Alô mundo - explicação


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

# Alô mundo - explicação


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

Mostrar exemplo dentro do alô mundo.

</div>