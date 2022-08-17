---
layout: triple-page
title: Demonstração
features: [code,javascript]
---

## Página com o triple-page

Use o layout `triple-page`

Cada subseção (`h2` em HTML, `##` em Markdown) inicia uma página

Se dentro da subseção houver um editor de código, ele aparece na coluna do meio, e o console aparece na coluna da esquerda.

Execute o código para ver em ação

<textarea class="code">
function meuMap(funcao, lista) {
  let resultado = [];
  for (let i = 0; i < lista.length; i++) {
    resultado.push(funcao(lista[i]));
  }
  return resultado;
}

teste([2, 4, 6], meuMap(x => x * 2, [1, 2, 3]));
</textarea>

## Outra página

Esta é uma página apenas explicativa, sem editor de código.
