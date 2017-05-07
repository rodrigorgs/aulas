---
layout: remark
title: Compilação de múltiplos arquivos
---

<div>

# Compilação e ligação

```bash
g++ -c arquivo1.cc
g++ -c arquivo2.cc
g++ -o executavel arquivo1.o arquivo2.o
```

# Desenvolvimento

- Para cada `.cc` (fonte), um `.h` (cabeçalho)
- Usar padrão

```c++
#ifndef ARQUIVO_H
#define ARQUIVO_H

// código

#endif
```


</div>