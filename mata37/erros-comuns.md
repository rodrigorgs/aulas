---
layout: remark
title: Erros comuns nos exercícios
---

<div>

# Problema (com correção automática)

Leia dois números, `x` e `y`, e imprima a diferença entre eles, no formato `DIF = nnn` (trocando `nnn` pela diferença).

Exemplo de entrada:

```
10 8
```

Exemplo de saída:

```
DIF = 2
```

---

# O que está errado?

```c++
#include <iostream>

using namespace std;

int main() {
    int x, y;
    int dif = x - y;

    cout << dif << endl;

    return 0;
}
```

---

# O que está errado?

```c++
#include <iostream>

using namespace std;

int main() {
    int x, y;
    int dif = x - y;

    cin >> x >> y;
    cout << dif << endl;

    return 0;
}
```

---

# O que está errado?

```c++
#include <iostream>

using namespace std;

int main() {
    int x, y;
    int dif;

    cin >> x >> y;
    dif = x - y;

    cout << dif << endl;

    return 0;
}
```

---

# O que está errado?

```c++
#include <iostream>

using namespace std;

int main() {
    int x, y;
    int dif;

    cin >> x >> y;
    dif = x - y;

    cout << dif << endl;

    return 0;
}
```

---

# O que está errado?

```c++
#include <iostream>

using namespace std;

int main() {
    int x, y;
    int dif;

    cin >> x >> y;
    dif = x - y;

    cout << "dif =" << dif << endl;

    return 0;
}
```

---

# O que está errado?

```c++
#include <iostream>

using namespace std;

int main() {
    int x, y;
    int dif;

    cin >> x >> y;
    dif = x - y;

    cout << "DIF =" << dif << endl;

    return 0;
}
```

---

# O que está errado?

```c++
#include <iostream>

using namespace std;

int main() {
    int x, y;
    int dif;

    cin >> x >> y;
    dif = x - y;

    cout << "DIF = " << dif;

    return 0;
}
```

---

# O que está errado?

```c++
#include <iostream>

using namespace std;

int main() {
    int x, y;
    int dif;

    cin >> x >> y;
    dif = x - y;

    cout << "DIF = " << x - y << endl;

    return 0;
}
```

---

# O que está errado?

```c++
#include <iostream>

using namespace std;

int main() {
    int x, y;
    int dif;

    cout << "Digite dois números: ";
    cin >> x >> y;
    dif = x - y;

    cout << "DIF = " << dif << endl;

    return 0;
}
```

---

# Escolha da linguagem de programação

Ao submeter uma resposta, escolha a linguagem de programação correta!

</div>