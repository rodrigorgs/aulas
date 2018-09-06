---
layout: page
title: Correção dos exercícios do Learn Git Branching
---

Abra o console JavaScript do navegador e cole o seguinte código:

```javascript
function calculaScore(base64) {
  var storage = JSON.parse(atob(base64))
  var scoreFinal = 0;

  if (storage.solvedMap) {
    var solvedObj = JSON.parse(storage.solvedMap)

    solved = Object.keys(solvedObj).filter(key => solvedObj[key] === true)

    selecionados = ["intro1", "intro2", "intro3", "intro4", "rampup1", "rampup2", "rampup3", "rampup4", "remote1", "remote2", "remote3", "remote4", "remote5", "remote6", "remote7", "remoteAdvanced1", "remoteAdvanced2"];
    scoreSelecionados = selecionados.reduce((sum, level) => solvedObj[level] ? sum + 1 : sum, 0);
    extras = solved.filter(x => !selecionados.includes(x));
    scoreExtras = Math.min(extras.length, 3);
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

Cole a resposta digitada pelo estudante no janela que se abre e pressione Enter. No console vai aparecer a pontuação do estudante, variando entre 0 e 20.