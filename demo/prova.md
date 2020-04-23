---
layout: page
title:  "Prova de exemplo"
---

<script type="text/javascript">
    window.apostila = "prova-demo";
    $(document).ready(() => {
      document.body.style.background = '#efd'
      initSubmissao();
    });
</script>

# Orientações sobre o demo

Clique no botão `Login`. Use senha `123456`.

{% include orientacoes.md %}
{% include codigo-de-conduta.md %}

## Questão 1

Implemente a função `area`, que recebe um parâmetro, `medidas`, e retorna a área do retângulo representado pelas medidas. O parâmetro `medidas` é uma lista com dois elementos, que representam, respectivamente, a medida da base e a medida da altura do retângulo.

<textarea class="code lang-scheme">
; se quiser, pode definir funções auxiliares
(define (area medidas) 
  'implementeAFuncao)

(teste 12 (area '(3 4)))
; Crie no mínimo 2 testes adicionais
;(teste ... ...)
;(teste ... ...)
;(teste ... ...)
</textarea>
