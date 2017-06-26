---
layout: page
title: MATA56 - PLP - 2017.1
---

# Informações básicas

<div style="float: left; padding: 5px; width: 30%;" markdown="1">
**Aulas**

- SEG, 13:00, IME lab 140
- QUA, 13:00, PAF sala 109

**Equipe**

- Professor: Rodrigo Rocha <rodrigo@dcc.ufba.br>
- Monitor: Daniel Amador <danielsegundoemail@gmail.com>
</div>

<div style="float: left; padding: 5px; width: 30%;" markdown="1">
**Grupo da disciplina**

- Inscreva-se no [grupo de discussão disciplina](https://groups.google.com/d/forum/mata56t01-20171)!
- Cheque seu e-mail diariamente: o grupo pode ser usado para comunicações importantes.
</div>

<div style="float: left; padding: 5px; width: 30%;" markdown="1">
**Avaliações**

- Prova escrita de Prolog <span style="color: gray;">\[peso: 2\]</span>
- Prova escrita de conceitos <span style="color: gray;">\[peso: 2\]</span>
- Prova prática de Scheme <span style="color: gray;">\[peso: 3\]</span>
- Trabalho de JavaScript <span style="color: gray;">\[peso: 3\]</span>
</div>

<div style="clear: left;"></div>

# Links importantes

- [SWISH][swish]: interpretador de Prolog online

# Conteúdo

| Dia       | Conteúdo                                                         |                                                                               |
| :-------  | :--------------------------------------------                    | :----------------------                                                       |
| **08/05** | [Apresentação da disciplina](disciplina)                         |                                                                               |
|           | [História das LPs](https://goo.gl/9qSZmy)                        |                                                                               |
| **10/05** | [Prolog: introdução](aula02-prolog)                              |                                                                               |
| **15/05** | Prolog: exercícios                                               |                                                                               |
| **17/05** | [Prolog: recursão](aula03-prolog-recursao)                       |                                                                               |
|           | [Prolog: unificação e busca](aula04-prolog-busca)                |                                                                               |
| **22/05** | Prolog: exercícios                                               | Aula com Daniel                                                               |
| **24/05** | [Prolog: aritmética](aula05-prolog-aritmetica) (leitura em casa) | Não haverá aula presencial                                                    |
| **29/05** | Prolog: exercícios                                               | [kahoot](https://create.kahoot.it/#quiz/af8c85ae-cedb-40e3-820d-de75b3fbbf9a) |
| **31/05** | [Prolog: listas](aula06-prolog-listas)                           |                                                                               |
| **05/06** | Prolog: exercícios                                               |                                                                               |
| **07/06** | Prolog: revisão.                                                 |                                                                               |
| **12/06** | Prolog: revisão.                                                 |                                                                               |
| **14/06** | **Prova de Prolog**                                              | **PROVA**                                                                     |
| **19/06** | [Conceitos de LPs][conceitos]                                    |                                                                               |
| **21/06** | Conceitos de LPs.                                                |                                                                               |
| **26/06** | Conceitos de LPs.                                                |                                                                               |
| **28/06** | Conceitos de LPs.                                                |                                                                               |
| **03/07** | Scheme: introdução                                               |                                                                               |
| **05/07** | Scheme: introdução                                               |                                                                               |
| **10/07** | Scheme: exercícios de recursão                                   |                                                                               |
| **12/07** | **Prova sobre conceitos**                                        | **PROVA**                                                                     |

<!--
| **17/07** | Scheme: funções de alta ordem                          |   |
| **19/07** | Scheme: recursão profunda                              |   |
| **24/07** | JS: introdução, funções de alta ordem, escopo          |   |
| **26/07** | JS: closures                                           |   |
| **31/07** | JS: currying, aplicação parcial, composição de funções |   |
| **02/08** | (paralisação)                                          |   |
| **07/08** | JS: revisão de currying, introdução a concorrência     |   |
| **09/08** | JS: concorrência                                       |   |
| **14/08** | JS: concorrência                                       |   |
| **16/08** | Revisão: JS funcional e concorrência                   |   |
| **21/08** |                                                        |   |
| **23/08** |                                                        |   |
| **28/08** |                                                        |   |
| **30/08** |                                                        |   |
| **04/09** |                                                        |   |
| **06/09** |                                                        |   |
-->

[swish]: http://swish.swi-prolog.org/
[conceitos]: http://slides.com/rodrigorgs/conceitos-de-linguagens-de-programacao

<script type="text/javascript">
function desabilitaLinksComecadosPor(prefixo) {
  var links = $('a').filter(function (idx) { return $(this).attr('href').startsWith(prefixo); });
  links.contents().unwrap();  
}
$(document).ready(function () {
  desabilitaLinksComecadosPor('#!');
});
</script>