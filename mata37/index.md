---
layout: page
title: MATA37 - ILP - 2017.1
---

# Informações básicas

<div style="float: left; padding: 5px; width: 30%;" markdown="1">
**Aulas**

- SEG, 14:50, PAF sala 109
- QUA, 14:50, IME lab 143

**Equipe**

- Professor: Rodrigo Rocha <rodrigo@dcc.ufba.br>
- Monitores: Daniel Luis <danieldlmt@gmail.com>, Matheus Silva <msformigteen@live.com>, Alex Santos <alexsisantos@gmail.com>
</div>

<div style="float: left; padding: 5px; width: 30%;" markdown="1">
**Grupo da disciplina**

- Inscreva-se no [grupo de discussão disciplina](https://groups.google.com/forum/#!forum/mata37t05-20171)!
- Cheque seu e-mail diariamente: o grupo pode ser usado para comunicações importantes.
</div>

<div style="float: left; padding: 5px; width: 30%;" markdown="1">
**Avaliações**

- Exercícios online individuais<br/><span style="color: gray;">\[peso: 3\]</span>
- Duas provas práticas<br/><span style="color: gray;">\[peso: 5\]</span>
- Trabalho prático (jogo)<br/><span style="color: gray;">\[peso: 2\]</span>
</div>

<div style="clear: left;"></div>

# Links importantes

- Tutoriais, apostilas e livros:
  - [Curso C++](http://excript.com/curso-cpp.html)
  - [Introdução a Ciência da Computação em C](https://www.ime.usp.br/~hitoshi/introducao/)
  - [Curso de Linguagem C][cursoC]
- [repl.it: C++ online][replit]
- IDEs (ambientes integrados de desenvolvimento -- escolha ):
  - [Instalação do Code::Blocks](https://panda.ime.usp.br/panda/static/data/codeblocks/windows.html)
  - [Instalação do Dev-C++][devc]

# Conteúdo

<!-- |           | [Arquitetura de computadores](arquitetura)    |    |-->
<!-- |           | [Linguagens de programação](#!linguagens)     |                                | -->

| Dia       | Conteúdo                                           |                                 |
| :-------  | :------------------------------------------------- | :------------------------------ |
| **08/05** | [Introdução à disciplina](intro-ilp)               |                                 |
|           | [Problemas](intro-problemas)                       |                                 |
|           | [Introdução a algoritmos](algoritmo)               |                                 |
|           | ["Alô mundo" em C++](intro-cpp)                    |                                 |
| **10/05** | [Introdução à linha de comando][linux]             |                                 |
|           | [Entrada e saída, variáveis][io]                   |                                 |
| **15/05** | [Variáveis](variaveis)                             |                                 |
|           | [Expressões aritméticas](aritmetica)               |                                 |
| **17/05** | Lab: exercícios                                    |                                 |
| **22/05** | [Desvio condicional][desvio]                       |                                 |
| **24/05** | Lab: Exercícios                                    |                                 |
| **29/05** | Lab: Exercícios                                    |                                 |
| **31/05** | Lab: Exercícios                                    |                                 |
| **05/06** | [Estruturas de repetição](repeticao)               |                                 |
| **07/06** | Lab: Exercícios                                    |                                 |
| **12/06** | Lab: Exercícios                                    |                                 |
| **14/06** | Lab: Exercícios                                    |                                 |

[io]: https://docs.google.com/presentation/d/1k1Pvv6SlGuumYC_zk_OW2GZYb7ue-pS2JaxO-ITTnLc/edit?usp=sharing
[desvio]: https://docs.google.com/presentation/d/1ziW7-IQMEHCXYp4YvUxgl8FZhu_WaWdX9vtNjRWo6cA/edit?usp=sharing

<!-- 
|           | [Resolução de problemas](#!qa)                |                                |
|           | [Entrada e saída](#!entrada-saida.md)         |                                |

 -->
<!--
| **29/05** | Estruturas de seleção                             |                                |
| **31/05** | Lab: Exercícios                                     |                                |
| **05/06** | Estruturas de repetição                             |                                |
| **07/06** | Lab: Exercícios                                     |                                |
| **12/06** |                                               |                                     |
| **14/06** |                                               |                                     |
| **19/06** |                                               |                                     |
| **21/06** |                                               |                                     |
| **26/06** |                                               |                                     |
| **28/06** |                                               |                                     |
| **03/07** |                                               |                                     |
| **05/07** |                                               |                                     |
| **10/07** |                                               |                                     |
| **12/07** |                                               |                                     |
| **17/07** |                                               |                                     |
| **19/07** |                                               |                                     |
| **24/07** |                                               |                                     |
| **26/07** |                                               |                                     |
| **31/07** |                                               |                                     |
| **02/08** |                                               |                                     |
| **07/08** |                                               |                                     |
| **09/08** |                                               |                                     |
| **14/08** |                                               |                                     |
| **16/08** |                                               |                                     |
| **21/08** |                                               |                                     |
| **23/08** |                                               |                                     |
| **28/08** |                                               |                                     |
| **30/08** |                                               |                                     |
| **04/09** |                                               |                                     |
| **06/09** |                                               |                                     |
-->


[cursoC]: http://equipe.nce.ufrj.br/adriano/c/apostila/texfiles/apostilaC.pdf
[replit]: https://repl.it/languages/cpp

[linux]: https://tutorial.djangogirls.org/pt/intro_to_command_line/
[devc]: http://linguagemc.com.br/tutorial-de-instalacao-do-dev-c/

<script type="text/javascript">
function desabilitaLinksComecadosPor(prefixo) {
  var links = $('a').filter(function (idx) { return $(this).attr('href').startsWith(prefixo); });
  links.contents().unwrap();  
}
$(document).ready(function () {
  desabilitaLinksComecadosPor('#!');
});
</script>