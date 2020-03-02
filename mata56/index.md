---
layout: page
title: MATA56 - Paradigmas de linguagens de programação - 2020.1
---

# Objetivo

Compreender e aplicar conceitos e paradigmas de linguagens de programação, de forma a facilitar o aprendizado de novas linguagens de programação e fornecer elementos para uma comparação crítica entre linguagens.

# Informações básicas

- Professor: Rodrigo Rocha <rodrigorgs@ufba.br>
- Entre no [Google Classroom](https://classroom.google.com/) e inscreva-se nesta turma clicando no botão `+` e digitando o código `7aaxcjx`.

# Avaliações

- Prova prática de Prolog <span style="color: gray;">\[peso: 3, individual\]</span>
- Caracterização de uma linguagem de programação <span style="color: gray;">\[peso: 3, em grupo de até 5 pessoas\]</span>
- Prova prática de programação funcional e concorrente com JavaScript <span style="color: gray;">\[peso: 4, individual\]</span>

# Ferramentas

- [SWISH](http://swish.swi-prolog.org/): interpretador de Prolog online
- [BiwaScheme](biwascheme): interpretador de Scheme online
- [repl.it](https://repl.it/languages): interpretador online de várias linguagens

# Conteúdo

(Atenção: o material pode ser atualizado ao longo do semestre)

Introdução

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

# Principais referências

- **Prolog**: Introdução à Programação Prolog, Palazzo. ([pdf](http://disciplinas.dcc.ufba.br/pub/MATA56/20092/prolog-palazzo.pdf))
- **Conceitos**: Programming Language Pragmatics ([site](https://www.cs.rochester.edu/u/scott/pragmatics/3e/)), Michael L. Scott, 3ª edição.
- **Scheme**: [BiwaScheme reference](https://www.biwascheme.org/doc/reference.html)
- **JavaScript**: [You Don't Know JS Yet](https://github.com/getify/You-Dont-Know-JS)
- [Outras referências](disciplina)