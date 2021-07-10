---
layout: remark
title: Entrada e saída em Python
---

<div>

## Saída de dados: print

- Para exibir (imprimir) um valor na tela, use a instrução `print(x)`, substituindo `x` pela expressão cujo resultado deve ser exibido. Exemplos:

```python
print(5)
print("Oi")
print(3.14 / 2)
```

---

## Definindo o número de casas decimais

- Se você precisar controlar o número de casas decimais que vão ser exibidas, use a função `format(x, .Nf)`, que converte um número, `x`, em uma string que representa o número com `N` casas decimais. Exemplo:

```python
numero = 1.5 ** 2
print(format(numero, ".2f"))
print(format(numero, ".5f"))
```

---

## Imprimindo múltiplos valores na mesma linha

Você pode passar para o `print` diversas expressões separadas por vírgulas. Exemplo:

```python
idade = 18
print("Eu tenho", idade, "anos")
```

Na saída, as expressões ficam separadas por um espaço em branco. Se quiser remover essa separação, adicione `sep=""`:

```python
ddd = 71
telefone = "5555-5555"
print("(", ddd, ") ", telefone, sep="")
```

---

## Imprimindo múltiplos valores na mesma linha

Outra opção é converter todas as expressões para string e então concatená-las (juntá-las) com `+`:

```python
ddd = 71
telefone = "5555-5555"
print("(" + str(ddd) + ") " + telefone)
```

--

O que acontece se você não usar `str`?

--

TypeError!

---

# Evitando a quebra de linha

A princípio cada `print` escreve uma linha de texto. Exemplo:

```python
print("Oi, ")
print("pessoal!")
```

Se você quiser evitar a quebra de linha, use `end=""`. Exemplo:

```python
print("Oi, ", end="")
print("pessoal!")
```

---

## Entrada: input()

- `input()` lê tudo o que o usuário digita até apertar Enter e retorna o texto digitado como uma string. Exemplo:

```python
print("Qual é o seu nome?")
nome = input()
print("Oi", nome)
```

---

## Entrada: input()

Qual a saída do programa a seguir, considerando como entradas os números 2 e 3?

```python
print("Digite o primeiro número:")
a = input()
print("Digite o segundo número:")
b = input()
print("Soma:", a + b)
```

--

O `input` sempre retorna uma string! Se necessário, você deve converter para o tipo desejado.

---

## Entrada: input()

Programa corrigido:

```python
print("Digite o primeiro número:")
a = float(input())
print("Digite o segundo número:")
b = float(input())
print("Soma:", a + b)
```

---

## Ex.: programa que lê um número e imprime seu dobro

```python
numero = int(input())
print(numero * 2)
```

---

## Lendo diversos valores na mesma linha

Programa que lê uma linha com três números inteiros, separados por espaço, e mostra a soma dos números:

```python
a, b, c = input().split()
a = int(a)
b = int(b)
c = int(c)
print(a + b + c)
```

`split()` separa o texto da entrada onde tem espaço em branco; cada uma das partes é atribuída para uma variável

Note que `split()` retorna strings; é necessário converter cada parte para inteiro antes de fazer a soma.

</div>