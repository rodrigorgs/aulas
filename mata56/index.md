---
layout: page
title: MATA56 - PLP - 2017.1
---

# Informações básicas

- Professor: Rodrigo Rocha <rodrigorgs@ufba.br>
- Entre no [Google Classroom](https://classroom.google.com/) e inscreva-se nesta turma clicando no botão `+` e digitando o código `yxt8ii`.

# Avaliações

- Prova escrita de Prolog <span style="color: gray;">\[peso: 3\]</span>
- Exercícios práticos de Scheme <span style="color: gray;">\[peso: 1\]</span>
- Prova escrita de programação funcional <span style="color: gray;">\[peso: 3\]</span>
- Prova escrita de programação concorrente <span style="color: gray;">\[peso: 3\]</span>

<!-- Tipos de questão:
* qual o resultado desse código / como funciona?
* escreva código segundo essa especificação
  * corrija o código
 -->

# Links importantes

- [SWISH](http://swish.swi-prolog.org/): interpretador de Prolog online
- [BiwaScheme](biwascheme): interpretador de Scheme online

# Conteúdo

Introdução

- [Apresentação da disciplina](disciplina)
- [História das LPs](https://goo.gl/9qSZmy)

Paradigma baseado em lógica

- [Prolog: introdução](aula02-prolog)
- [Prolog: recursão](aula03-prolog-recursao) - [kahoot](https://create.kahoot.it/details/prolog-conceitos/76411391-65da-4134-9f23-cae462725e24)
- [Prolog: unificação e busca](aula04-prolog-busca)
- [Prolog: aritmética](aula05-prolog-aritmetica) - [kahoot](https://create.kahoot.it/details/prolog-unificacao-e-aritmetica/af8c85ae-cedb-40e3-820d-de75b3fbbf9a)
- [Prolog: listas](aula06-prolog-listas) - [kahoot](https://create.kahoot.it/details/prolog-listas/33b33e8f-63df-465d-8116-3fed63a4a0de)

Paradigma funcional (introdução com Scheme)

- [Scheme: introdução](aula08-lisp)
- [Scheme: exercícios](aula09-lisp-ex)
- [Scheme: funções de alta ordem](aula10-lisp-alta-ordem)
- [Scheme: recursão profunda](aula11-lisp-rec-prof) (extra)

Conceitos

- [Conceitos de LPs](http://slides.com/rodrigorgs/conceitos-de-linguagens-de-programacao)

Paradigma funcional (tópicos avançados com JavaScript)

- [JS: introdução (slides)](https://docs.google.com/presentation/d/1tK-mleL0MPsohCff0E8tuxeyijwprZwsIqmIwoy46gA/edit?usp=sharing)
- [JS: introdução e funções de alta ordem](aula12-js-intro)
- [JS: closures](aula13-js-closures)
- [JS: currying, aplicação parcial, composição de funções](aula14-currying)

Programação assíncrona

- [JS: concorrência](aula15-concorrencia)
- [JS: padrões de concorrência](aula16-concorrencia-padroes)
- [JS: promises](aula17-promises)
- [JS: async/await](aula18-async-await)
- .
- [JS: iterators e generators](aulaxx-generators)

<script type="text/javascript">
function desabilitaLinksComecadosPor(prefixo) {
  var links = $('a').filter(function (idx) { return $(this).attr('href').startsWith(prefixo); });
  links.contents().unwrap();  
}
$(document).ready(function () {
  desabilitaLinksComecadosPor('#!');
});
</script>