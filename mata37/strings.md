---
layout: remark
title: Strings
---

<div>

# Strings - material adicional

---

# Char

Considere o seguinte programa

```c++
#include <iostream>
#include <string>

using namespace std;

int main() {
  int x = 65;

  cout << x << endl;
  
  return 0;
}
```

Agora troque `int` por `char`. O que acontece?

---

# Tabela ASCII

Cada caractere é codificado através de um byte, ou seja, um número entre 0 e 255. A correspondência entre valor numérico e caractere é dada pela [tabela ASCII](https://www.asciitable.com/).

Assim, `char x = 'A';` e `char x = 65;` são equivalentes.

---

# Operações sobre o tipo char

Use `#include <cctype>`. 

- `tolower(c)` - converte para minúsculas
- `toupper(c)` - converte para maiúsculas
- `isalnum(c)` - checa se é alfanumérico
- `isalpha(c)` - checa se é uma letra do alfabeto
- `isdigit(c)` - checa se é um dígito numérico
- `isblank(c)` - checa se é um caracter em branco (espaço, tab, quebra de linha...)
- e [outras](http://www.cplusplus.com/reference/cctype/)...

---

# Leitura de strings

```c++
string x;

getline(cin, x);
cin >> x;
```

---

# Leitura de strings

`cin >>` lê a entrada até encontrar um espaço em branco (espaço, tab, quebra de linha etc.), mas não remove esse espaço em branco da entrada.

`getline(cin, variavel)` lê a entrada até encontrar uma quebra de linha, e remove a quebra de linha da entrada. A variável recebe todo o conteúdo antes da quebra de linha.


---

# Leitura de strings

Isso causa problemas ao usar o `getline` após o `cin >>`. Para resolver, use `cin.ignore()` (descarta o próximo caractere da entrada) ou então `cin >> ws` (descarta todos os caracteres em branco consecutivos da entrada):

```c++
int idade;
string nome;

cin >> idade;
cin.ignore();
getline(cin, x);
```

---

# Fim de arquivo (EOF, end-of-file)

Para saber se a entrada acabou, use `cin.eof()`.
Se a entrada é do teclado, o "fim de arquivo" é obtido pressionando Ctrl+D (Linux, Mac) ou Ctrl+Z, Enter (Windows)

 Ex.:

```c++
// Programa que lê uma linha e
// imprime a linha lida, até
// encontrar o final da entrada.
#include <iostream>
#include <string>

using namespace std;

int main() {
  string x;

  while (!cin.eof()) {
    getline(cin, x);
    cout << x << endl;
  }

  return 0;
}
```

---

# Operações básicas com strings

- `str.length()` ou `str.size()` - retorna comprimento de `str`
- `str[indice]` - acessa caractere na posição `indice`
- `str[indice] = c` - altera caractere na posição `indice`
- `str1 += str2` - insere `str2` no final de `str1` (concatenação)
- `str1 == str2` - comparação de igualdade
- `str1 < str2` - comparação de ordem alfabética (mais ou menos)

---

# Outras operações com strings

- Extrair uma porção da string (`substr`)
- Encontrar a primeira ocorrência de uma string em outra (`find`)

---

# Substrings

`str.substr(pos, comprimento)` - retorna uma nova string com `comprimento` caracteres a partir da posição `pos`. Exemplo:

---

# Busca em strings

- `str.find(trecho)`
- `str.rfind(trecho)`

Retorna posição da primeira (`find`) ou da última (`rfind`) ocorrência de `trecho` dentro de `str`.

Ex.:

```c++
string frase = "o rato roeu a roupa";
string palavra = "rato";
cout << frase.find(palavra) << endl;
// saída: 2
```

---

# Busca em strings

- `str.find(trecho)`
- `str.rfind(trecho)`

O retorno é do tipo size_t (que é efetivamente um inteiro sem sinal).
Se o trecho não for encontrado, retorna `string::npos`. Ex.:

```c++
string frase = "o rato roeu a roupa";
string palavra = "Roma";
size_t pos = frase.find(palavra);
if (pos == string::npos) {
  cout << "Palavra não encontrada na frase";
} else {
  cout << "Posição " << pos;
}
cout << endl;
```

---

# Busca em strings

Opcionalmente, pode-passar um parâmetro a mais, `posicao`:

- `str.find(trecho, posicao)` - busca o trecho a partir da posição `posicao`.
- `str.rfind(trecho, posicao)` - busca o trecho considerando apenas sequências de caracteres iniciadas na posição `posicao` ou posições anteriores.

---

# Exemplo: extrair dados de arquivo HTML

Dada uma string, extraia cada trecho contido entre as tags `<b>` e `</b>` e imprima um trecho por linha. (Exemplo: CifraClub)

```c++
#include <iostream>
#include <string>

using namespace std;

int main() {
  string frase = "Oi, <b>Fulano</b> de <b>SSA</b>";
  size_t ini = 0;
  size_t fim = 0;

  while (ini != string::npos) {
    ini = frase.find("<b>", ini);
    if (ini != string::npos) {
      fim = frase.find("</b>", ini + 1);
      if (fim != string::npos) {
        cout << frase.substr(ini + 3, fim - ini - 3) << endl;
        ini = fim + 1;
      }
    }
  }

  return 0;
}
```

---

# Tópico avançado: expressões regulares

`#include <regex>`


</div>