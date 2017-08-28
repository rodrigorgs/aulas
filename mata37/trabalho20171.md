---
layout: page
title: Especificação do trabalho prático (2017.1)
---

Você aprendeu os fundamentos da programação e os praticou através de exercícios pequenos e especializados para cada conteúdo. Você escreveu dezenas de programas que leem da entrada padrão e escrevem na saída padrão. Você passou horas olhando para um terminal que só produz texto e só lê do teclado.  **Agora é hora de aplicar todos os seus conhecimentos em um projeto um pouco maior, com mais cores, imagens e interação!**

Sua tarefa é criar um jogo digital. Mas você não estará sozinho nessa jornada: você pode recrutar até 3 colegas seus.

## Especificação

Você deve criar um **jogo** simples usando a biblioteca SDL (valor: **1,6**) e um **vídeo de demonstração** do jogo (valor: **0,4**). Recomenda-se usar a [biblioteca ILP Game](sdl/ilpgame) para tornar esse processo mais fácil. Clique [aqui](sdl/ilpgame) para aprender mais.

Envie a formação da sua equipe (**de 1 a 4 pessoas**) e uma breve descrição do jogo para mim: <rodrigorgs@ufba.br> (ou me comunique em aula). Eu vou avaliar se a ideia é válida para a disciplina (nem muito fácil e nem muito difícil).

O jogo deve ser entregue **até o dia 29/08/2017** por e-mail para <rodrigorgs@ufba.br>. Anexe um **arquivo `.zip`** contendo os seguintes itens:

- código-fonte (incluindo o arquivo `ilpgame.h`, se for usado)
- arquivos necessários para rodar o jogo (imagens, fontes de texto etc.)
- um arquivo `README.txt` com instruções para compilar o jogo e instruções para jogar o jogo.

No mesmo e-mail, indique o **link para o vídeo de demonstração do jogo** no YouTube, com **até 2 minutos**.

Na aula do dia **30/08/2017**, **todos os vídeos serão exibidos**. Logo após, cada equipe será chamada em particular para **responder a perguntas sobre o código-fonte do jogo**. Espera-se que cada membro conheça e saiba explicar uma parte significativa do código-fonte do jogo, e cada membro será avaliado pelas suas respostas às perguntas do professor. Enquanto uma equipe explica seu código, as outras equipes podem **jogar os jogos dos colegas :)**

Você pode **copiar código** da Internet para enriquecer seu jogo, desde que (1) o código copiado não represente uma parte significativa do código total do jogo; (2) você saiba explicar o código copiado. Recomenda-se indicar, através de comentários no código-fonte, o endereço de onde o código foi copiado.

## Prêmios

Serão distribuídos prêmios em 4 categorias, valendo 0,1 ponto extra para cada um dos membros das equipes premiadas:

- Melhor título
- Mais divertido
- Mais completo
- Menos bugado

## Orientações

Inspiração:

- Vídeos de jogos feitos em universidades
    + [Laboratório de Programação I, UFCG](https://www.youtube.com/results?search_query=%28pygame+OR+lab+prog+1%29+ufcg)
    + [Desenvolvimento de Jogos, Faculdade Ruy Barbosa, 2011](https://www.youtube.com/playlist?list=PL79AAB0814FBA4674)
    + [Desenvolvimento de Jogos, Faculdade Ruy Barbosa, 2013](https://www.youtube.com/playlist?list=PLL_iKJ-wRbvuDzBf4oi9LNMxac41GiN0Z)
- Ideias para ter ideias de jogos
    + Pegue um jogo tradicional e implemente.
    + Pegue um jogo tradicional e modifique uma coisa. Que tal um clone do jogo Pong inspirado no frescobol? E se além de mover a raquete para cima e para baixo na tela, você pudesse alterar a sua inclinação? E se a bola estivesse sujeita à ação da gravidade? E se fossem duas bolas no lugar de uma? E se fossem 4 raquetes, uma em cada lado da tela?
    + Misture elementos de gêneros diferentes de jogo. Que tal um [jogo de futebol com carros](https://www.rocketleague.com/)? Ou um [jogo de quebra-cabeça onde você precisa combinar peças para derrotar inimigos em uma caverna](https://en.wikipedia.org/wiki/10000000_(video_game))?
    + Use situações do seu cotidiano ou do cotidiano de outras pessoas para fazer um jogo. Que tal um jogo onde você é motorista do Buzufba? Ou um jogo onde você deve desviar das pessoas enquanto anda e envia mensagens de texto no celular? Ou um [jogo sobre o dia-a-dia de um oficial de imigração](http://papersplea.se/)?
- Jogos
    + [Jogos para Windows 3.1](https://archive.org/details/softwarelibrary_win3_games?&sort=-downloads) -- ver também [Melhores Jogos para Windows 3.1](http://www.arkade.com.br/direto-pre-historia-melhores-jogos-windows-31/)
    + [Jogos para DOS](https://archive.org/details/softwarelibrary_msdos_games)
    + <http://www.lessmilk.com/games>
    + <http://experimentalgameplay.com/>
    + [The 50 Best Free Games On PC - Rock, Paper, Shotgun](https://www.rockpapershotgun.com/2016/10/31/the-50-best-free-games-on-pc/)
    + <http://puzzlescriptgallery.tumblr.com/>, <http://www.draknek.org/games/puzzlescript/>
    + Lista (bagunçada) de jogos simples: Ski (Win31), BangBang (Win31), Pong, JezzBall (Win31), Donkey.bas, PipeDream (Win31), Sokoban, Snakes, Campo minado, Labirinto, Infinite scroller + jump (jogo do dinossauro), Jogo do arqueiro (Win31), Jogo da memória, Batalha naval, 21/Blackjack, Jogo da velha, Quiz, Golf, Mastermind, Genius/Simon Says, Reversi, Space invaders, Asteroids, Ligue 4 / ConnectFour, Poker, Bomberman, Sokobond, Editor de pixel art, Damas, Apostar em resultado de dados, Onde está Carmen San Diego, Corrida de carro top-down, Jogo de tiro top-down, jogo bullet hell top down, Palavras cruzadas, Bust-A-Move / Bubble shooter (jogo da bolinha), room escape, rock band, Bow and arrow (win31), lunar lander, Angry birds (simplificado), Timberman (mobile), 2048, Tetris, Breakout, Match3/Bejewled/Candy Crush, Tiro ao alvo (de lado, alvo fica se mexendo, jogador controla ângulo do disparo), Egg Catcher, Flappy Bird, Slime voleyball, snake vertical.
+ Geradores de ideias de jogos
    - <http://orteil.dashnet.org/gamegen>
    - <http://ygd.bafta.org/resources/game-idea-generator>
    - <http://genr8rs.com/Generator/Development/GameIdeaGenerator>
    - <https://inventwithpython.com/blog/2012/07/30/need-a-game-idea-a-list-of-game-mechanics-and-a-random-mechanic-mixer/>

Recursos e ferramentas:

- Arte para jogos
    + Gráficos: <http://kenney.nl/>, <http://www.lostgarden.com/search/label/free%20game%20graphics>, <https://v-play.net/game-resources/16-sites-featuring-free-game-graphics>
    + Música: <http://incompetech.com/music/royalty-free/>
    + Efeitos sonoros: <http://www.bfxr.net/>, <http://freesound.org/>, <https://v-play.net/game-resources/16-sites-featuring-free-game-sounds>
- Software para gravação de tela
    + Windows: <http://www.makeuseof.com/tag/show-dont-tell-3-best-free-screencasting-tools-for-windows/>
    + Linux: <https://askubuntu.com/questions/4428/how-to-record-my-screen>
    + Mac: [QuicktTime Player](https://www.abeautifulsite.net/recording-a-screencast-with-quicktime)
- Software para edição de vídeo
    + [YouTube Editor (online)](https://www.youtube.com/editor)
    + outros...
