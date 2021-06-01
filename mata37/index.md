---
layout: page
title: MATA37 - ILP - 2018.1
---

# Trabalho prático

**Veja a [especificação do trabalho](trabalho20181)**

# Informações básicas

- Professor: Rodrigo Rocha <rodrigorgs@ufba.br>
- Inscreva-se no [Google Classroom](https://classroom.google.com/) da turma: clique no botão `+` e digite o código `6o7sgf2`.

# Avaliações

- Exercícios online individuais<br/><span style="color: gray;">\[peso: 3\]</span>
- Duas provas práticas<br/><span style="color: gray;">\[peso: 5\]</span>
- Trabalho prático<br/><span style="color: gray;">\[peso: 2\]</span> -- **veja a [especificação do trabalho](trabalho20181)**

# Links importantes

- [Código-fonte produzido durante a aula](https://github.com/rodrigorgs/aulas/tree/master/mata37/codigo)
- Tutoriais, apostilas e livros:
  - [Curso C++](http://excript.com/curso-cpp.html)
  - [Introdução a Ciência da Computação em C](https://www.ime.usp.br/~hitoshi/introducao/)
  - [Curso de Linguagem C][cursoC]
- Editores de C++ online:
	- [repl.it: C++ online](https://repl.it/languages/cpp)
	- [JSCPP](https://felixhao28.github.io/JSCPP/)
- [Como instalar um compilador de C++ no Windows (MinGW, g++)](https://www.youtube.com/watch?v=bEs-5IU_l9w)
- IDEs (ambientes integrados de desenvolvimento -- escolha um):
  - [Instalação do Code::Blocks](https://panda.ime.usp.br/panda/static/data/codeblocks/windows.html)
  - [Instalação do Dev-C++](http://linguagemc.com.br/tutorial-de-instalacao-do-dev-c/)

# Conteúdo

<!-- |           | [Arquitetura de computadores](arquitetura)    |    |-->
<!-- |           | [Linguagens de programação](#!linguagens)     |                                | -->

- [Aula 1](https://drive.google.com/file/d/1MCRM7GF9RX8vYtPRL-_QAGQ_tJWBagrq/view?usp=sharing)
- [Pra que aprender a programar?](intro-ilp)
- [O que são algoritmos? E linguagens de programação?](algoritmo)
- .
- ["Alô mundo" em C++](intro-cpp)
- [Variáveis](variaveis)
- [Entrada e saída](entrada-saida)
- [Expressões aritméticas](aritmetica)
- [Estilo de codificação](estilo)
- .
- [Quiz sobre variáveis, aritmética e entrada/saída](https://play.kahoot.it/#/k/71e43c0a-cd6c-4286-a3bf-d159b793dcf7)
- [Erros comuns nos exercícios](erros-comuns)
- .
- [Estruturas de seleção (desvio condicional): if, else, switch, ?:](selecao)
- .
- [Introdução à linha de comando][linux]
- [Compilador de C++](compilador)
- [Como instalar um compilador de C++ no Windows (MinGW, g++)](https://www.youtube.com/watch?v=bEs-5IU_l9w)
- .
- [Estruturas de repetição](repeticao)
- .
- [Vetores](vetores) -- [exercícios extras](https://www.ime.usp.br/~macmulti/exercicios/vetores/)
- .
- [Strings][strings] -- [material complementar](strings)
- .
- [Matrizes][matrizes]
- [Structs](structs)
- [Funções](funcoes)
- [Ordenação](ordenacao)
- [Busca binária][busca] - ver também [material do livro OpenDSA](https://opendsa-server.cs.vt.edu/ODSA/Books/Everything/html/BinarySearch.html)

<!--
Recursão:

https://softwareengineering.stackexchange.com/questions/25052/in-plain-english-what-is-recursion

Condição de parada.

Fatorial.
Imprimir alfabeto ao contrário usando recursão.
Somatório. (exercício).
Fibonacci. (exercício)
Flood fill. (intermediário)
Busca binária. (intermediário)
Hanoi. (avançado)

Recursão vs iteração. (overhead de chamada de função)

 -->

<!-- aritmética, desvio, repetição, vetores, strings, matrizes, ordenação, busca binária, função/recursão -->

[desvio]: https://docs.google.com/presentation/d/1ziW7-IQMEHCXYp4YvUxgl8FZhu_WaWdX9vtNjRWo6cA/edit?usp=sharing
[cursoC]: http://equipe.nce.ufrj.br/adriano/c/apostila/texfiles/apostilaC.pdf
[vetores]: https://docs.google.com/presentation/d/1QRhykZHZEJnj_noNEO5ebwdqX5iik9G8QEp5NXe1aPw/edit
[strings]: https://docs.google.com/presentation/d/1nu6lvyXXjpH-fjRcaCdlEyCxdRlWtYWbeZUzMKuHQ-U/edit
[matrizes]: https://docs.google.com/presentation/d/1wfDe5AFXdvvVaOf-Jdc-vQCUyOJlMF8Nz9Vqy_8fT-0/edit
[ordenacao]: https://docs.google.com/presentation/d/1SBfYu_MiDFzfiV8P3zhs2Wu0yvtAHrFOO7rSkibDd3U/edit
[ordenacao2]: https://www.slideshare.net/xrodrigorgs/aula-busca-e-ordenao
[busca]: https://docs.google.com/presentation/d/1GhlmL_Xxh5bnonbjCIJOlgMMUGJoPXy_nZpswZ6306g/edit
[recursao]: https://docs.google.com/presentation/d/1wbRqdCPIQQwXvfeJthUAsM9w4YGkd6n6IpXDpVITq1M/edit

[linux]: https://tutorial.djangogirls.org/pt/intro_to_command_line/

<script type="text/javascript">
function desabilitaLinksComecadosPor(prefixo) {
  var links = $('a').filter(function (idx) { return $(this).attr('href').startsWith(prefixo); });
  links.contents().unwrap();  
}
$(document).ready(function () {
  desabilitaLinksComecadosPor('#!');
});
</script>
