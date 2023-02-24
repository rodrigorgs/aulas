---
layout: remark
title: Introdução à Programação
---
{::nomarkdown}
template: inverse

# Algoritmos e Programas

{% include_relative footer.txt %}

---

# Algoritmo

Um **algoritmo** é uma sequência de passos bem definidos para resolver um problema. Exemplos:

- Receita de bolo
- Manual de produto
- Processo de matrícula
- Como resolver o cubo de Rubik

<!-- Algoritmos devem ser expressos dentro de uma quantidade **finita** de espaço e tempo. -->

<!-- Na computação, algoritmos transformam valores de entrada em valores de saída (como funções). -->

---

# Programa

Um **programa** é uma sequência de instruções que serão executadas pelo computador. Um programa, portanto, pode descrever algoritmos.

O computador consegue executar **código de máquina**, isto é, programas escritos em **linguagem de máquina**. <!-- Cada máquina entende uma linguagem diferente -->

Pessoas geralmente trabalham com **código-fonte**, isto é, programas escritos em uma **linguagem de programação** (mais fácil de entender).

> Exemplos de linguagens de programação: C++, Python, Java, JavaScript

---

# Compilador e interpretador

Um **compilador** ou **intepretador** é um programa que transforma código-fonte em código de máquina.

- O compilador faz isso de uma vez só, gravando o código de máquina em um arquivo executável
- O interpretador transforma o código enquanto o executa

Um programa que é interpretado também é chamado de **script**.

---

# Instruções

As linguagens de programação possuem os seguintes tipos de instruções:

- **entrada de dados** - lê dados do teclado, de um arquivo, da rede, do relógio, da câmera e outros dispositivos
- **saída de dados** - escrever na tela ou em um arquivo, enviar dados via rede, emitir um som etc.
- **processamento de dados** - basicamente operações matemáticas
- **condicionais** - permite executar ou não outras instruções a depender de uma condição
- **repetição** - permite re-executar instruções

---

# Exemplo de programa

Algoritmo para calcular a idade de uma pessoa, escrito em português:

1. Pergunta o ano atual
2. Pergunta o ano de nascimento de uma pessoa
3. Pergunta se a pessoa já fez aniversário no ano atual
4. Calcula a idade (ano atual menos ano de nascimento)
5. Se a pessoa ainda não fez aniversário, subtrai 1 da idade
6. Diz a idade, ou seja, o resultado do cálculo

---

# Exemplo de programa

Programa escrito na linguagem de programação Python:

```python
# Entrada
ano_atual = int(input())
ano_nascimento = int(input())
ja_fez_aniversario = input() == "sim"

# Processamento
idade = ano_atual - ano_nascimento
if not ja_fez_aniversario:
    idade = idade - 1

# Saída
print(idade)
```

{:/}