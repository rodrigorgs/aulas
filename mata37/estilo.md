---
layout: remark
title: Estilo de codificação
---

<div>

# Citação

"Quando você é um carpinteiro fazendo uma bela cômoda, você não vai usar um pedaço de madeira podre na parte de trás, mesmo que ela fique virada para a parede e ninguém possa vê-la. Você vai saber que ela está lá, então você precisa usar um belo pedaço de madeira na parte traseira. Para que você possa dormir bem à noite, a estética, a qualidade, precisa estar presente em tudo."

*Steve Jobs*

---

# Indentação

Bug: <https://blog.codecentric.de/en/2014/02/curly-braces/>

---

# Espaçamento

```c++
int x = (3 + 2) * 5;
```

```c++
if (condicao) {
```

```c++
int funcao(float param1, char param2) {
```

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

Sempre usar chaves depois do `if`, mesmo com uma linha

---

# Identificadores

---

# Lint

- splint (C)
- cppcheck (C++)
- [cpplint](https://github.com/google/styleguide/tree/gh-pages/cpplint) (C++)
- <http://gimpel-online.com//cgi-bin/genPage.py?srcFile=simple.cpp&cgiScript=analyseCode.py&title=C%2B%2B&intro=Escreva+seu+programa&compilerOption=online32.lnt&includeOption={{quotedIncludeOption}}>

</div>