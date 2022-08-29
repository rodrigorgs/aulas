---
layout: triple-page
title: "Módulos em Python"
features: [quiz]
---


Até então trabalhamos com programas simples, cujo código foi escrito em um único arquivo `.py`. Para programas maiores, usar um único arquivo se torna inviável. Aqui vamos aprender a dividir um programa em módulos e pacotes, de forma a facilitar a sua manutenção.

Um módulo define variáveis, funções e outras estruturas que podem ser reusadas em diferentes partes de um programa ou em diferentes programas.

## Importando módulos

Já vimos que é possível usar módulos como `math`, `time`, entre outros, para acessar funcionalidades extras.

### Usando import módulo

O código a seguir importa o módulo `math`. Desta forma, temos acesso às funções e variáveis definidas pelo módulo, usando a sintaxe `math.NOME`, onde `NOME` é o nome da variável ou função.

```python
import math

print(math.sqrt(9))
print(math.PI)
```

### Usando `from módulo import nome`

Podemos fazer a mesma coisa usando uma sintaxe diferente:

```python
from math import sqrt, PI

print(sqrt(9))
print(PI)
```

Nesse caso, devemos acessar a função ou variável diretamente, sem o prefixo `math.`

Você também pode usar `from math import *` para importar tudo o que foi definido em `math`.

## Um módulo é um arquivo .py

Ao executar um `import` ou `from ... import ...`, o Python busca os módulos em determinados diretórios pré-configurados. Um desses diretórios é o diretório do script que foi executado.

Para criar um módulo, crie um arquivo `nome.py`, onde `nome` é o nome do módulo.

## `if __name__ == __main__`

Um arquivo Python pode ser executado como script ou importado como módulo.

A variável `__name__` guarda o nome do módulo ou, se o script for executado como script, guarda o nome `__main__`.

Assim, se há algum código que queremos executar quando o código é tratado como script, mas não quando é importado, usamos:

```python
if __name__ == '__main__':
  seu codigo aqui
```

## Pacotes

Diretórios são pacotes, que podem conter outros pacotes (outros diretórios) ou módulos (arquivos `.py`).

Um pacote pode ser importado como módulo se tiver um arquivo `__init__.py`; nesse caso, o arquivo é importado.

## Imports relativos

Um módulo pode importar outros módulos usando caminhos relativos usando uma das seguintes sintaxes:

- `from .modulo import nomes`: importa módulo no mesmo diretório
- `from ..modulo import nomes`: importa módulo no diretório pai




