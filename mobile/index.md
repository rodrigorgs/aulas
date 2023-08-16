---
layout: page
title: Desenvolvimento de Aplicativos Móveis - 2023.2
---
<!-- 
# Informações básicas

- Site: [v.ht/matc89](http://v.ht/matc89)
- Professor: Rodrigo Rocha <rodrigorgs@ufba.br>
- Aulas:
  - QUA, 18:30, sala 210 do PAF I
  - SEX, 18:30, lab 143 do IME

**Conteúdo**: Conceitos de desenvolvimento de apps para dispositivos móveis. Desenvolvimento de aplicativos nativos com Android SDK e linguagem Java. Noções da aplicação de tecnologias da web para dispositivos móveis.
 -->
<!-- 
# Avaliações

- (3,0) [Desenvolvimento de pequenos apps com Android SDK](exercicios-android) (individual)
- (5,0) [Workshop de tecnologia de desenvolvimento mobile](workshop) (em equipes de até 6 pessoas, a partir de 16/11)
  - (1,0) Guia de configuração
  - (1,5) Workshop: parte teórica
  - (2,0) Workshop: desenvolvimento
  - (0,5) Exercício proposto (bem especificado, nível de dificuldade adequado)
- (2,0) Resolução de exercícios de **dois** workshops (mesmas equipes do workshop)
-->

<!--    
    * Exercício 1: Hello World
    * Exercício 2: Navegação
    * Exercício 3: Lista

# Orientações

- [Guia de Laboratório](https://docs.google.com/document/d/13sOy6BJv51Xiud7gHsxtIdgrnDOrTgB7VNpOvEomo7I/edit)
- [Orientações Gerais sobre os Exercícios](https://docs.google.com/document/d/1J1uNZaPkjvmxpWM4N-mXa6OiCQKkmleF0npnvBSyG9k/edit)
-->

# Programa

- Introdução: Evolução de dispositivos computacionais e aplicativos. Design de interfaces para diferentes tamanhos de tela. Distribuição de aplicativos. Abordagens para desenvolvimento de aplicativos.
- Android: plataforma, ambiente de desenvolvimento e SDK.
- Flutter: conceitos iniciais, linguagem Dart, criação de interfaces gráficas, interação, navegação, gerenciamento de estado.

<!-- 
# Exercícios

Primeiramente, veja [como fazer os exercícios](https://docs.google.com/presentation/d/11AntLlFpDEDVDFjMKZLlIz2XMshifSEnElz5dqlTSbs/edit?usp=sharing).

- [Exercícios de Dart](https://classroom.github.com/a/X12g1jra)
- [Exercícios de Flutter - parte 1](https://classroom.github.com/a/_eUZUjRc) - **Atenção**: no exercício do Snackbar, use uma duração de 500 milissegundos.
- [Exercícios de Flutter - parte 2](https://classroom.github.com/a/LOuoCp4b)

# Projeto

Veja [informações sobre o projeto](20231/projeto-flutter)
-->

# Slides

<!-- [Guia de laboratório](https://docs.google.com/document/d/1Ebvb6pw5KAQ2SlgIb3kTvbIrhhlrLXkLYf6GAQVbiUg/edit?usp=sharing) -->

- Introdução
  - Mercado de apps: [A corrida do ouro da App Store](https://speakerdeck.com/rodrigorgs/a-corrida-do-ouro-da-app-store-at-mobile-day) ([versão .key](https://drive.google.com/file/d/0BxqQol81uO5UVUtxRjV6QWk5eWc/view?usp=sharing&resourcekey=0-_i5EkDKMr2iFmsd7538Y-g))
  - [Desenvolvimento para dispositivos móveis: uma visão geral](https://docs.google.com/presentation/d/1HIecqkfBAoaQ19FjchJX3KT6OwOgNy7TicvKwOw8C8M/edit)

<!-- 
- Android
  - [Ecossistema Android](https://docs.google.com/presentation/d/1q_24FLFzH0N4b8I8kdCwNdsVPdmNrzWlsupQ19ruvdQ/edit)
  - [Introdução ao desenvolvimento com Android SDK](https://speakerdeck.com/rodrigorgs/introducao-ao-android)
- Flutter
  - [Linguagem Dart](https://docs.google.com/presentation/d/1GjP68nGHteIkoR8quvcm_HrZ7Zyn6Hp8jkFgy6ElHC8/edit)
  - [Introdução ao Flutter](https://docs.google.com/presentation/d/1dcSDogvICDwkXkJwtJeXhHTk5i4o1rukE3285w6oS90/edit)
  - [Desenvolvimento de apps com Flutter](https://docs.google.com/presentation/d/1A8FBRqqPQF72GGiHpfNuAMC7p09VgNdl9x1A84YiXkU/edit#slide=id.p)
 -->
<!-- 
- Notas sobre os exercícios
  - [Guia de laboratório](https://docs.google.com/document/d/13sOy6BJv51Xiud7gHsxtIdgrnDOrTgB7VNpOvEomo7I/edit)
  - [Como fazer os exercícios](https://docs.google.com/presentation/d/1MUvztR37W7q0djQ8r4uMp9q1qQTc3vCCWueuR6WKVFA/edit)
  - Os exercícios serão corrigidos na AVD `3.2 QVGA (ADP2)`
   -->
  <!-- - [Orientações gerais sobre os exercícios](https://docs.google.com/document/d/1J1uNZaPkjvmxpWM4N-mXa6OiCQKkmleF0npnvBSyG9k/edit) -->

<!--   
- Android
    + [Instalação](https://docs.google.com/presentation/d/13iFDtHQ-HxVs8ofT0UEiqeOjuFcn_FhtfFGxm7zrPUg/edit)
    + [Introdução ao Android](https://speakerdeck.com/rodrigorgs/introducao-ao-android)
        + Guardando o estado de uma Activity antes de ela ser destruída para poder restaurar o estado quando ela for construída novamente (enquanto o aplicativo está sendo executado): [onSave/RestoreInstanceState](instance-state)
    + [ListView](https://speakerdeck.com/rodrigorgs/listview-android-sdk) ([arquivo original do Keynote](https://drive.google.com/file/d/0BxqQol81uO5UUG0tTnExR2xXblE/view?usp=sharing))
    + Persistência de dados
      + [SQLiteOpenHelper](https://speakerdeck.com/rodrigorgs/sqlite-android-sdk) ([arquivo original do Keynote](https://drive.google.com/open?id=0BxqQol81uO5UeXZ4VWxVN2JDLXc))
      + [Biblioteca Room](https://developer.android.com/training/data-storage/room) - ver [exemplo de código usando Room](https://github.com/rodrigorgs/exemplo-android-room)
    + [Serviços Web](https://speakerdeck.com/rodrigorgs/servico-rest-android-sdk) ([arquivo original do Keynote](https://drive.google.com/open?id=0BxqQol81uO5UNnhLeFJMMzZ4Yk0))
      - [Acessando serviços Web com a biblioteca Retrofit](retrofit)
      - [Acessando serviços Web com a API nativa do Android](https://speakerdeck.com/rodrigorgs/cliente-rest-android-sdk) ([arquivo original do Keynote](https://drive.google.com/open?id=0BxqQol81uO5USXBOWV9WU0RIWFU), [exemplo de código](rest.zip))
    + [Multithreading](https://speakerdeck.com/rodrigorgs/multithreading-android-sdk) ([arquivo original do Keynote](https://drive.google.com/open?id=0BxqQol81uO5UOG0tcFdYVVg4Z1U))
      - [Exemplo de código](async-task.zip)
- iOS
    + [Start Developing iOS Apps (Swift)](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/)
    + [Minicurso de programação para iOS (Objective-C)](https://speakerdeck.com/rodrigorgs/minicurso-de-ios-at-mobile-day)
    + [Exemplo de app iOS simples com Storyboard](https://github.com/rodrigorgs/exemplo-ios-storyboard)
    + [Exemplo de app iOS simples com SwiftUI](https://github.com/rodrigorgs/exemplo-ios-swiftui)
- Web
    - [Introdução ao desenvolvimento web](https://drive.google.com/open?id=14mwlqq2vf4wFBGY3AAf908A6DvwgRyDPyQWT-OYReXc)
    - [Design web responsivo](https://drive.google.com/open?id=1pyYqQxGmk7XL9ZF_bKtir57jIkHVE3HCPG4LvKKT56E)
    - [Cordova](https://drive.google.com/open?id=1JSlr3Zfmtcydzktu-v8KQxeGjc19GKq2BA60PObz-WM)
    - [ES6 e TypeScript](https://drive.google.com/open?id=1tK-mleL0MPsohCff0E8tuxeyijwprZwsIqmIwoy46gA)
    - [Angular](https://drive.google.com/open?id=1bGoa9sWTEhMVuPognjLgzP7BmjurpIfevEpg3NjAHUg)
    - [Ionic](https://drive.google.com/open?id=1DcuMmkFe8Yx80n37B71uw31h3lq_Rdh4iwROZEw7zCk)
-->

# Leituras complementares

- [10 Engineering Challenges Due to the Nature of Mobile Applications](https://blog.pragmaticengineer.com/10-engineering-challenges-due-to-the-nature-of-mobile-applications/)
- [Sistemas e dispositivos móveis nas universidades públicas: desafios e oportunidades](https://docs.google.com/document/d/1xkv2en13stqj3EnCGcdv29qvAT2dRk5YT1vJ85UrrVg/edit#)
- gov.uk Service Manual: [Making sure your service works well on mobile](https://www.gov.uk/service-manual/technology/working-with-mobile-technology) e [We're not ‘appy. Not ‘appy at all.](https://gds.blog.gov.uk/2013/03/12/were-not-appy-not-appy-at-all/)
- [Introdução aos dispositivos móveis](https://docs.google.com/presentation/d/11YIeaJ22oQgixFvy4QqGU0_SwSRbVOywI0yR2XoASwk/edit)
- [Nativo vs. web vs. híbrido vs. nativo multiplataforma](https://docs.google.com/presentation/d/1BOJgJeV-48F_wKH9Kar2hqva500EA1mUxL1vQtra8V8/edit?usp=sharing)

<!-- 
# Bibliografia e referências

- GRIFFITHS, Dawn; GRIFFITHS, David. Use a cabeça!: desenvolvendo para Android. Alta Books; 2ª edição, 2019.
- GARDNER, Lyza Danger; GRIGSBY, Jason. Use a cabeça! Mobile Web. Alta Books; 1ª edição, 2013.

Referências em inglês:

- [Android Developers](https://developer.android.com/?hl=pt-br) (oficial)
- [Vogella - Android Development](http://www.vogella.com/android.html)
 -->

<img src="mobile.png" width="100" height="100">