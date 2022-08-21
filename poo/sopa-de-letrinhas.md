---
layout: page
title: Sopa de Letrinhas
features: []
---

Neste projeto você deve implementar um jogo similar ao Sopa de Letrinhas. Veja o [vídeo de demonstração](https://www.youtube.com/watch?v=yd7bHQnnGy4).

Sopa de Letrinhas é um jogo no qual, a cada partida, são apresentadas 6 letras embaralhadas, com as quais o jogador deve formar palavras de 3 a 6 letras.

- Toda partida possui ao menos uma palavra de 6 letras
- As partidas do jogo são representadas em um arquivo texto chamado `partidas.txt` (veja exemplo no final da página)
  - No arquivo, cada linha representa uma partida
  - Cada linha consiste de uma sequência de palavras, em letras minúsculas, separadas por vírgulas, iniciando por uma palavra de 6 letras
  - Todas as palavras da partida são formadas pela permutação de um subconjunto das letras da palavra de 6 letras
  - Algumas palavras podem ter acento; considera-se que letras acentuadas são equivalentes a suas versões não acentuadas; assim, `oca` e `aço` podem ser consideradas palavras formadas a partir das letras `c`, `a`, e `o`.
- A tela do jogo é formada pelas seguintes áreas:
  - Listagem: lista as palavras descobertas pelo jogador, bem como indica palavras que ainda precisam ser descobertas; inicialmente mostra todas as palavras da partida, em ordem de número de letras e depois alfabética, trocando todas as letras por algum símbolo, de forma que o jogador consegue visualizar rapidamente quantas palavras há com cada quantidade de letras
  - Campo de texto: mostra a palavra que o jogador está formando
  - Bandeja: mostra letras que podem ser usadas para formar palavras
  - Área de ações: contém botões que permitem limpar palavra, submeter palavra, dentre outros
- Durante a partida, o jogador pode efetuar as seguintes operações:
  - Mover uma letra específica da bandeja para o final do campo de texto
  - Mover a última letra do campo de texto para a bandeja
  - Mover todas as letras do campo de texto para a bandeja
  - Submeter a palavra formada no campo de texto; se a palavra fizer parte da partida, ela é adicionada à listagem e as letras voltam para a bandeja; caso contrário, o jogo deve indicar que a palavra não faz parte
- Cada palavra certa adiciona à pontuação o número de letras da palavra
- Ao iniciar o jogo, é iniciada uma partida aleatória
- Quando o jogador descobre todas as palavras da partida ou quando desiste, ele tem a possibilidade de jogar uma nova partida, aleatória e diferente da partida que acabou de jogar
- Ao descobrir uma palavra, o jogador ganha uma quantidade de pontos igual à quantidade de letras da palavra
- O jogo pode ser jogador com o teclado ou com o mouse

Próxima iterações

- Ranking
- Opções: com/sem som, com/sem pontuação
- Menu, tela de opções

Exemplo de arquivo `partidas.txt`:

```
canela,acne,ala,alce,alça,anca,anel,anã,cal,cana,canal,cela,cena,clã,ela,laca,lance,lança
borrão,aro,bar,barro,boa,boro,borra,broa,oba,obra,obrar,ora,orar,rabo,raro,robô
editor,direto,dito,doer,dor,dote,ido,ode,rei,reto,rio,rito,teor,ter,tio,tiro,trio,tédio
forçar,afro,arco,aro,aço,caro,carro,coar,cor,corar,cão,faro,foca,focar,fora,forca,forra,força,fraco,oca,ora,orar,orca,orçar,raro,roca,roça,roçar
cobrar,arco,aro,aço,bar,barco,barro,baço,boa,boca,borra,braço,broa,broca,brocar,cabo,caro,carro,coar,cobra,cor,corar,cão,oba,obra,obrar,oca,ora,orar,orca,orçar,rabo,raro,roca,roça,roçar
```