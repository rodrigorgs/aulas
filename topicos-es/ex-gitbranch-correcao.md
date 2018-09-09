---
layout: page
title: Correção dos exercícios do Learn Git Branching
---

## Planilha de correção

A planilha com as respostas dos alunos se encontra em <https://docs.google.com/spreadsheets/d/105DL1AbjMuLuuJNfEwsJIFaP5aG9AGe3TFXkIzKr3U0/edit>. Nessa planilha, há três colunas que precisam ser preenchidas: Pontuação, Extras e Histórico. Para preencher essas colunas, você precisa copiar o valor da coluna "Cole aqui o resultado da instrução digitada no console JavaScript do navegador, conforme especificação do trabalho" e seguir as orientações abaixo.

## Script de correção

Abra o console JavaScript do navegador e cole o seguinte código:

```javascript
function calculaScore(base64) {
  var storage = JSON.parse(atob(base64))
  var scoreFinal = 0;

  if (storage.solvedMap) {

    var history = JSON.parse(storage.lgb_CommandHistory);
    console.log(history.join("; ").replace("\n", ""));

    var solvedObj = JSON.parse(storage.solvedMap)
    var solved = Object.keys(solvedObj).filter(key => solvedObj[key] === true)

    var selecionados = ["intro1", "intro2", "intro3", "intro4", "rampup1", "rampup2", "rampup3", "rampup4", "remote1", "remote2", "remote3", "remote4", "remote5", "remote6", "remote7", "remoteAdvanced1", "remoteAdvanced2"];
    var scoreSelecionados = selecionados.reduce((sum, level) => solvedObj[level] ? sum + 1 : sum, 0);
    var extras = solved.filter(x => !selecionados.includes(x));
    console.log("Extras:", extras)
    var scoreExtras = Math.min(extras.length, 3);
    scoreFinal = scoreSelecionados + scoreExtras;
  } else {
    scoreFinal = 0;
  }
  
  return scoreFinal;
}

function corrigeExercicio() {
  var s = calculaScore(prompt());
  console.log("Score:", s);
}
```

Então, ainda no console JavaScript, rode o comando:

```javascript
corrigeExercicio();
```

Na janela que se abre, cole a resposta digitada pelo estudante e pressione Enter. No console vai aparecer a pontuação do estudante, variando entre 0 e 20, bem como a lista de questões extras que ele fez e o histórico de comandos. Cole essas informações nas colunas correspondentes da planilha de correção.