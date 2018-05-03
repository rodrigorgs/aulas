---
layout: remark
title: Estruturas de repetição
---

<!-- 

TODO: dança repetitiva (for-loop) ou música repetitiva

TODO: um elefante incomoda muita gente

https://www.tutorialspoint.com/cplusplus/cpp_loop_types.htm

https://www.tutorialspoint.com/cplusplus/cpp_while_loop.htm

https://www.tutorialspoint.com/cplusplus/cpp_do_while_loop.htm

 -->

<div>

## Motivação

**Problema**: Seu programa deve calcular a média aritmética de quatro notas de um aluno e informar se o aluno foi aprovado. Se a média for menor do que 7.0, o aluno deve ser reprovado.

**Entrada**: Uma linha contendo quatro números reais.

**Saída**: Seu programa deve imprimir a sentença "Aluno aprovado! Parabens!" ou "Aluno reprovado! Estude mais!" seguida de uma quebra de linha.

---

```c++
#include <iostream>

using namespace std;

int main() {
  float n1, n2, n3, n4, media;

  cin >> n1 >> n2 >> n3 >> n4;
  media = (n1 + n2 + n3 + n4) / 4.0;
  if (media >= 7.0)
    cout << "Aluno aprovado! Parabens!\n";
  else
    cout << "Aluno reprovado! Estude mais!\n";

  return 0;
}
```

---

## Como calcular a média para 30 alunos?

**Problema**: Seu programa deve calcular a média aritmética de quatro notas de 30 alunos. Alunos com média menor do que 7.0 estão reprovados.

**Entrada**: Quatro números reais (notas) lidos da entrada padrão **para cada aluno**.

**Saída**: Seu programa deve imprimir a sentença "Aluno aprovado" ou "Aluno reprovado" seguida de uma quebra de linha **para cada aluno**.

---

```c++
#include <iostream>
using namespace std;
int main() {
  float n1,n2,n3,n4,media;

  // Aluno 1
  cin >> n1 >> n2 >> n3 >> n4;
  media = (n1 + n2 + n3 + n4) / 4.0;
  if (media >= 7.0)
    cout << "Aluno aprovado! Parabens!\n";
  else
    cout << "Aluno reprovado! Estude mais!\n";

  // Aluno 2
  cin >> n1 >> n2 >> n3 >> n4;
  media = (n1 + n2 + n3 + n4) / 4.0;
  if (media >= 7.0)
    cout << "Aluno aprovado! Parabens!\n";
  else
    cout << "Aluno reprovado! Estude mais!\n";

  // ...

  return 0;
}
```

---

## Sumário

Nesta aula vamos ver como executar as instruções de um programa repetidas vezes.

Veremos dois tipos de repetição:

- repetir um número definido de vezes (`for`)
- repetir enquanto uma condição for verdadeira (`while` e `do..while`)

---

## for - Repetição de contagem

```c++
for ( <inicialização> ; <condição> ; <incremento> ) {
 instrução1;
 …
 instruçãoN;
}
```

Se houver apenas uma instrução, as chaves (`{` e `}`) são opcionais.

---

## Média aritmética para 30 alunos


```c++
#include <iostream>

using namespace std;

int main() {
  float n1, n2, n3, n4, media;
  int i;

  for (i = 0; i < 30; i++) {
    cin >> n1 >> n2 >> n3 >> n4;
    media = (n1 + n2 + n3 + n4) /4.0;
    if (media >= 7.0)
      cout << "Aluno aprovado! Parabens!\n";
    else
      cout << "Aluno reprovado! Estude mais!\n";
  } 
  return 0;
}
```

---

![](https://upload.wikimedia.org/wikipedia/commons/0/06/For-loop-diagram.png)

---

# Definições

Um **loop** (ou laço) é uma sequência de instruções que é executada repetidamente.

Cada repetição das instruções (ou seja, cada "volta" no loop) é chamada de **iteração**.

No `for`, é comum usar uma variável para funcionar como **contador de loop**.

---

## Usando o contador de loop nas instruções

Escreva um programa que escreve os números de 2 a 10, um em cada linha:

```c++
#include <iostream>

using namespace std;

int main () {
  int i;

  for (i = 2; i <= 10; i++) {
    cout << i << endl;
  }

  return 0;
}
```

---

## Dando um passo maior

Escreva um programa que escreve os números **pares** de 2 a 10, um em cada linha:

```c++
#include <iostream>

using namespace std;

int main () {
  int i;

  for (i = 2; i <= 10; i += 2) {
    cout << i << endl;
  }

  return 0;
}
```

---

## Dando um passo pra trás

Escreva um programa que escreve os números de 10 a 2, em ordem decrescente, um em cada linha:

```c++
#include <iostream>

using namespace std;

int main () {
  int i;

  for (i = 10; i >= 2; i--) {
    cout << i << endl;
  }

  return 0;
}
```

---

## E se a quantidade não for conhecida? 

**Descrição**: Seu programa deve calcular a média aritmética de quatro notas de N alunos. Alunos com média menor do que 7.0 estão reprovados.

**Entrada**: Para cada aluno, a entrada contém duas linhas. A primeira possui quatro números reais (notas) e a segunda contém um inteiro C que indica se existem mais alunos (C = 1) ou não na entrada (C = 0) após o atual.

**Saída**: Seu programa deve imprimir a sentença "Aluno aprovado" ou "Aluno reprovado" seguida de uma quebra de linha para cada aluno. 

---

## while - Repetição pré-testada

While significa *enquanto*. As instruções são executadas enquanto a condição for verdadeira.

```c++
while ( <condição> ) {
 instrução1;
 …
 instruçãoN;
}
```

Se houver apenas uma instrução, as chaves (`{` e `}`) são opcionais.

---

## Média aritmética de N alunos

```c++
#include <iostream>

using namespace std;

int main() {
  float n1, n2, n3, n4, media;
  int continua = 1;

  while (continua != 0) {
    cin >> n1 >> n2 >> n3 >> n4;
    media = (n1 + n2 + n3 + n4) / 4.0;
    if (media >= 7.0)
      cout << "Aluno aprovado! Parabens!\n";
    else
      cout << "Aluno reprovado! Estude mais!\n";
    cin >> continua;
  } 
  return 0;
}
```

---

## do..while - Repetição pós-testada

O `do..while` funciona de forma similar ao while; a diferença é que a condição é testada no **final** de cada iteração.

```c++
do {
 instrução1;
 …
 instruçãoN;
} while ( <condição> );
```

---

## Média aritmética de N alunos - do..while

```c++
#include <iostream>

using namespace std;

int main() {
  float n1, n2, n3, n4, media;
  int continua;

  do {
    cin >> n1 >> n2 >> n3 >> n4;
    media = (n1 + n2 + n3 + n4) / 4.0;
    if (media >= 7.0)
      cout << "Aluno aprovado! Parabens!\n";
    else
      cout << "Aluno reprovado! Estude mais!\n";
    cin >> continua;
  } while (continua != 0);
  return 0;
}
```

---

# Equivalência entre for e while

```c++
for (i = 0; i < n; i++) {
  cout << i << endl;
}
```

É equivalente a

```c++
i = 0;
while (i < n) {
  cout << i << endl;
  i++;
}
```

---

# Artifício para leitura de sequências de números finalizadas com zero

Leia um número e imprima o dobro, repetidamente. Pare quando o número for 0:

```c++
#include <iostream>

using namespace std;

int main() {
  int i;

  while ((cin >> i) && i != 0) {
    cout << i * 2 << endl;
  }

  return 0;
}
```

`(cin >> i)` lê um número da entrada padrão, atribui o número à variável `i`, e retorna falso se a leitura não é bem sucedida.

---

# Artifício para leitura de sequências de números finalizadas com zero

Outra forma de fazer:

```c++
while (cin >> i, i != 0) {
    ...
}
```

Em C++, 'instrução1, instrução2' significa executar `instrução1`, depois executar `instrução2` e retornar o valor de `instrução2` (isto é, é o valor da `instrução2` que vai ser testado pelo `while`).

---

# Orientação para problemas de correção automática (estilo maratona)

Nos problemas de correção automática, você não precisa ler todas as entradas antes de escrever as saídas. Você pode alternar leitura e escrita.

Lembre-se que a saída é tudo o que seu programa escreve (usando, por exemplo, `cout`). É isso que vai ser comparado com a saída esperada.

---

# Orientação para problemas de correção automática (estilo maratona)

Exemplo: leia um número e imprima o dobro. Entrada finaliza com 0.

Exemplo de entrada:

```
3
-5
0
```

Exemplo de saída:

```
6
-10
```

---

# Orientação para problemas de correção automática (estilo maratona)

Solução:

```c++
#include <iostream>

using namspace std;

int main() {
  int x;
  while (cin >> x, x != 0) {
      cout << x * 2 << endl;
  }
  return 0;
}
```


Nos problemas de correção automática, você não precisa ler todas as entradas antes de escrever as saídas. Você pode alternar leitura e escrita.

Lembre-se que a saída é tudo o que seu programa escreve (usando, por exemplo, `cout`). É isso que vai ser comparado com a saída esperada.

---

# Variáveis com propósitos especiais

- contador
- acumulador
- sinalizador (flag)

---

# Contador

É uma variável que conta o número de iterações de um loop. Ex.:

```c++
#include <iostream>

using namespace std;

int main() {
  int num, cont;
  
  cont = 0;
  while ((cin >> num) && num != 0) {
    cout << num << " ao quadrado = " << num * num << endl; 
    cont++;
  }

  cout << cont << " numeros digitados." << endl;

  return 0;
}
```

---

# Contador

Pode contar apenas algumas iterações.

```c++
#include <iostream>

using namespace std;

int main() {
  int num, cont;
  
  cont = 0;
  while ((cin >> num) && num != 0) {
    cout << num << " ao quadrado = " << num * num << endl; 
    if (num % 2 == 0) {
      cont++;
    }
  }

  cout << cont << " numeros pares digitados." << endl;

  return 0;
}
```

---

# Acumulador

Guarda um resultado parcial a cada iteração do loop.

```c++
#include <iostream>

using namespace std;

int main() {
  int num, maximo;
  
  maximo = 0;
  while ((cin >> num) && num > 0) {
    if (num > maximo) {
      maximo = num;
    }
  }

  cout << "Valor maximo: " << maximo << endl;

  return 0;
}
```

---

# Sinalizador (flag)

Indica se uma situação ocorreu ou não.

```c++
#include <iostream>

using namespace std;

int main() {
  int num;
  bool possuiImpar;
  
  possuiImpar = false;
  while ((cin >> num) && num > 0) {
    if (num % 2 == 1) {
      possuiImpar = true;
    }
  }

  if (possuiImpar) {
    cout << "A sequencia possui numero impar" << endl;
  } else {
    cout << "A sequencia NAO possui numero impar" << endl;
  }

  return 0;
}
```

---

# Combinando for + if

Escreva um programa que lê um número N, e imprime a sequência "1, 2, ..., N"

Exemplo: se N = 4, o programa deve imprimir "1, 2, 3, 4"

---

# loop infinito

No loop infinito, as instruções são repetidas infinitamente. Exemplo usando `for`:

```
for (;;) {
  cout << "Alo mundo! ";
}
```

Exemplo usando while:

```
while (true) {
  cout << "Alo mundo! ";
}
```

Para sair do programa, só com `Ctrl + C`!

---

# Alterando o fluxo do loop

Às vezes é útil interromper um loop ou iniciar a próxima iteração antes de terminar a iteração atual. Para esses casos são usadas as instruções `break` e `continue`.

---

# break

A instrução `break` dentro de um loop interrompe o loop, de forma que a execução do programa continua a partir da próxima instrução após o loop. Exemplo:

```c++
#include <iostream>

using namespace std;

int main() {
  int numero;

  for (;;) {
    cin >> numero;
    if (numero == 0) {
      break;
    }
    cout << numero * 2 << endl;
  }
  return 0;
}
```

O que esse programa faz?

---

# continue

A instrução `continue` dentro de um loop interrompe a iteração atual e parte para a próxima iteração. Exemplo:

```c++
#include <iostream>

using namespace std;

int main() {
  int i;

  for (i = 1; i <= 20; i++) {
    if (i == 13) {
      continue;
    }
    cout << i << endl;
  }
  return 0;
}
```

---

# Quando usar break e continue

Um programa que usa `break` ou `continue` pode ser reescrito sem usar essas instruções.

O uso de `break` e `continue` em alguns casos dificulta o entendimento do fluxo programa.

Em geral, prefere-se usar `break` e `continue` apenas quando o código-fonte fica mais fácil de entender com eles do que sem eles.

---

# laços aninhados

Você pode usar loops dentro de loops. Exemplo: desenhar um retangulo na tela com o caracteres `#`.

```c++
#include <iostream>

using namespace std;

int main() {
  int largura = 8, altura = 3;
  int x, y;

  for (y = 0; y < altura; y++) {
    for (x = 0; x < largura; x++) {
      cout << "#";
    }
    cout << endl;
  }
  return 0;
}
```

---

# laços aninhados

Você pode usar loops dentro de loops. Exemplo: desenhar um triângulo na tela com o caracteres `#`.

```c++
#include <iostream>

using namespace std;

int main() {
  int lado = 6;
  int x, y;

  for (y = 0; y < lado; y++) {
    for (x = 0; x <= y; x++) {
      cout << "#";
    }
    cout << endl;
  }
  return 0;
}
```

Quantas vezes o `cout << "#"` vai ser executado?

---

## Exercício: adivinhe o número

O programa sorteia um número de 1 a 100. O usuário deve adivinhar o número. Exemplo de uso:

- O número está entre 1 e 100
- 30
- O número está entre 31 e 100
- 50
- O número está entre 31 e 49
- 42
- Parabéns! Você acertou em 3 tentativas!

Extra: qual é a melhor estratégia para o usuário?

---

## Exercício: um elefante incomoda muita gente

Crie um programa que imprime a seguinte letra de música, de 1 até 30:

```
1 elefante incomoda muita gente
2 elefantes incomodam, incomodam muito mais

3 elefantes incomodam muita gente
4 elefantes incomodam, incomodam, incomodam, incomodam muito mais

5 elefantes incomodam muita gente
6 elefantes incomodam, incomodam, incomodam, incomodam, incomodam, incomodam muito mais

7 elefantes incomodam muita gente
8 elefantes incomodam, incomodam, incomodam, incomodam, incomodam, incomodam, incomodam, incomodam muito mais

9 elefantes incomodam muita gente
10 elefantes incomodam, incomodam, incomodam, incomodam, incomodam, incomodam, incomodam, incomodam, incomodam, incomodam muito mais
```

(continua até 30).

---

# Debugging (Depuração)

<https://felixhao28.github.io/JSCPP/>

```c++
#include <iostream>
using namespace std;
int main() {
    int i;
    
    for (i = 0;
         i < 5;
         i++) {
        cout << i << endl;
    }
    
    return 0;
}
```

---

Parte deste material foi baseado nos slides do prof. Mauricio Pamplona

</div>