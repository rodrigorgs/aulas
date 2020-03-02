---
layout: page
title: Demonstração
---


Para incluir um editor de código JavaScript, use

```html
<textarea class="code">
codigo inicial do editor
</textarea>
```

Resultado:

<textarea class="code">
codigo inicial do editor
</textarea>

## Outras linguagens

Adicione ao `textarea` a classe `lang-NOMEDALINGUAGEM`, ex.: `lang-scheme`, `lang-ruby`.

## Editor de código com resposta

Exemplo:

```html
<textarea class="code">
codigo inicial do editor
</textarea>

<textarea class="answer">
resposta
</textarea>
```

Resultado:

<textarea class="code">
codigo inicial do editor
</textarea>

<textarea class="answer">
resposta
</textarea>

## Testes automatizados

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
