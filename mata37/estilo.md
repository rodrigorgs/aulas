---
layout: remark
title: Estilo de codificação
---

<div>

# Citação

"Quando você é um carpinteiro fazendo uma bela cômoda, você não vai usar um pedaço de madeira podre na parte de trás, mesmo que ela fique virada para a parede e ninguém possa vê-la. Você vai saber que ela está lá, então você precisa usar um belo pedaço de madeira na parte traseira. Para que você possa dormir bem à noite, a estética, a qualidade, precisa estar presente em tudo."

*Steve Jobs*

---

# O que há de errado com o seguinte texto?

Saber programar &nbsp;é importante . **Para** programar,é preciso escolher uma linguagem *de* programação ,como C++ , Java, Python ...

---

# O que há de errado com o seguinte texto?

Saber programar &nbsp;é importante . **Para** programar,é preciso escolher uma linguagem *de* programação ,como C++ , Java, Python ...

> O texto está gramaticalmente correto, o conteúdo faz sentido, mas o espaçamento está inconsistente e a formatação está estranha (por que "Para" está em negrito?). Isso é uma questão de **estilo**.

---

# Espaçamento

Separe palavras, números e operadores com um espaço em branco.

Ruim:

```c++
cout<<2+3<<endl;
```

Melhor:

```c++
cout << 2 + 3 << endl;
```

---

# Espaçamento

Ruim:

```c++
x+=2+3;
```

Melhor:

```c++
x += 2 + 3;
```

---

# Espaçamento

Use um espaço após vírgula e pontos-e-vírgulas.

Ruim:

```c++
int x,y,z;
```

Melhor:

```c++
int x, y, z;
```

---

Use um espaço após vírgula e pontos-e-vírgulas.

Ruim:

```c++
int x;float y;
```

Melhor:

```c++
int x; float y;
```

Ainda melhor:

```c++
int x;
float y;
```

---

# Espaçamento

Outros exemplos:

```c++
if (condicao) {
}
```

```c++
int funcao(float param1, char param2) {
}
```
---

# Indentação

- Indentar significa começar uma linha de texto mais afastada da margem.
    - Você pode usar espaços ou tabs, mas não misture os dois no mesmo código-fonte.
- Em C++, indentar mais ou menos uma linha não afeta o resultado.
- No entanto, a indentação pode tornar seu código-fonte mais claro.

---

# Indentação

```c++
int main() {
  int x;
  cin >> x;
  cout << x * 2 << endl;
}
```

As linhas `int..., cin..., cout...` estão indentadas em relação ao `int main`. Isso passa uma ideia de que essas linhas estão dentro do `main`, que representa o programa principal.

---

# Indentação

Uma indentação ruim pode fazer com que programadores interpretem um código-fonte de maneira incorreta, resultando em bugs que podem passar anos sem ser descobertos.

Bug: <https://blog.codecentric.de/en/2014/02/curly-braces/>

---

# Chaves

```c++
if (cond1) {
  // ...
} else if (cond2) {
  // ...
} else {
  // ...
}
```

Sempre usar chaves depois do `if`, mesmo com uma linha, ajuda a prevenir bugs.

---

# Identificadores

- Inicie identificadores por letra minúscula. Ex.: idade vs. Idade.
- Use nomes significativos. Ex.: idade vs. i.
- Use alguma convenção para separar palavras. Ex.: anoNascimento, ano_nascimento

---

# O mais importante

Ao trabalhar com outros programadores em um projeto pré-existente, siga as convenções adotadas no projeto.

---

# Lint

- splint (C)
- cppcheck (C++)
- [cpplint](https://github.com/google/styleguide/tree/gh-pages/cpplint) (C++)
- <http://gimpel-online.com//cgi-bin/genPage.py?srcFile=simple.cpp&cgiScript=analyseCode.py&title=C%2B%2B&intro=Escreva+seu+programa&compilerOption=online32.lnt&includeOption={{quotedIncludeOption}}>

</div>