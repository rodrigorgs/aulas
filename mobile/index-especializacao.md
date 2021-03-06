---
layout: page
title: Desenvolvimento para dispositivos móveis - 2021
---
## Conteúdo

- Visão geral da computação móvel (história, ecossistema)
- Plataformas para dispositivos móveis (tecnologias, mercado)
- Desenvolvimento de apps Android
- Desenvolvimento de apps web e híbridos

# Avaliações

As avaliações serão realizadas em grupos de 4 pessoas.

- (4,0) [Desenvolvimento de 2 pequenos apps com Android SDK](exercicios-android)
  - Correção automática no GitHub
  - Exercício em dupla ou individual
- (6,0) [Workshop sobre alguma tecnologia para desenvolvimento mobile](workshop)
  - Em equipes de 4 pessoas
  - 1,0 ponto para guia de configuração
  - 3,0 pontos para apresentação
  - 2,0 pontos para realização de exercícios de outros workshops (revisão por pares)

<!-- 
# Orientações

- [Guia de Laboratório](https://docs.google.com/document/d/13sOy6BJv51Xiud7gHsxtIdgrnDOrTgB7VNpOvEomo7I/edit)
- [Orientações Gerais sobre os Exercícios](https://docs.google.com/document/d/1J1uNZaPkjvmxpWM4N-mXa6OiCQKkmleF0npnvBSyG9k/edit)
 -->

# Notas de aula

- Introdução
  - Mercado de apps: [A corrida do ouro da App Store](https://speakerdeck.com/rodrigorgs/a-corrida-do-ouro-da-app-store-at-mobile-day) ([versão .key](https://drive.google.com/file/d/0BxqQol81uO5UVUtxRjV6QWk5eWc/view?usp=sharing))
  - [Introdução aos dispositivos móveis](https://drive.google.com/open?id=0BxqQol81uO5UN3BBTThmdWE2OFk)
  - [Nativo vs. web vs. híbrido vs. nativo multiplataforma](https://docs.google.com/presentation/d/1BOJgJeV-48F_wKH9Kar2hqva500EA1mUxL1vQtra8V8/edit?usp=sharing)
  - Ver também as leituras recomendadas (abaixo)
- Android
    + [Instalação](https://docs.google.com/presentation/d/13iFDtHQ-HxVs8ofT0UEiqeOjuFcn_FhtfFGxm7zrPUg/edit)
    + [Introdução ao Android](https://speakerdeck.com/rodrigorgs/introducao-ao-android)
      + Guardando o estado de uma Activity antes de ela ser destruída para poder restaurar o estado quando ela for construída novamente (enquanto o aplicativo está sendo executado): [onSave/RestoreInstanceState](instance-state)
    + [ListView](https://speakerdeck.com/rodrigorgs/listview-android-sdk) ([arquivo original do Keynote](https://drive.google.com/file/d/0BxqQol81uO5UUG0tTnExR2xXblE/view?usp=sharing))
    + [SQLite](https://speakerdeck.com/rodrigorgs/sqlite-android-sdk) ([arquivo original do Keynote](https://drive.google.com/open?id=0BxqQol81uO5UeXZ4VWxVN2JDLXc))
    + [Serviços Web](https://speakerdeck.com/rodrigorgs/servico-rest-android-sdk) ([arquivo original do Keynote](https://drive.google.com/open?id=0BxqQol81uO5UNnhLeFJMMzZ4Yk0))
      - [Acessando serviços Web com a biblioteca Retrofit](retrofit)
      - [Acessando serviços Web com a API nativa do Android](https://speakerdeck.com/rodrigorgs/cliente-rest-android-sdk) ([arquivo original do Keynote](https://drive.google.com/open?id=0BxqQol81uO5USXBOWV9WU0RIWFU), [exemplo de código](rest.zip))
    + [Multithreading](https://speakerdeck.com/rodrigorgs/multithreading-android-sdk) ([arquivo original do Keynote](https://drive.google.com/open?id=0BxqQol81uO5UOG0tcFdYVVg4Z1U))
      - [Exemplo de código](async-task.zip)
- Web
    - [Introdução ao desenvolvimento web](https://drive.google.com/open?id=14mwlqq2vf4wFBGY3AAf908A6DvwgRyDPyQWT-OYReXc)
    - [Design web responsivo](https://drive.google.com/open?id=1pyYqQxGmk7XL9ZF_bKtir57jIkHVE3HCPG4LvKKT56E)
    - [Cordova](https://drive.google.com/open?id=1JSlr3Zfmtcydzktu-v8KQxeGjc19GKq2BA60PObz-WM)
    - [ES6 e TypeScript](https://drive.google.com/open?id=1tK-mleL0MPsohCff0E8tuxeyijwprZwsIqmIwoy46gA)
    - [Angular](https://drive.google.com/open?id=1bGoa9sWTEhMVuPognjLgzP7BmjurpIfevEpg3NjAHUg)
    - [Ionic](https://drive.google.com/open?id=1DcuMmkFe8Yx80n37B71uw31h3lq_Rdh4iwROZEw7zCk)
- iOS
    + [Start Developing iOS Apps (Swift)](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/)
    + [Minicurso de programação para iOS (Objective-C)](https://speakerdeck.com/rodrigorgs/minicurso-de-ios-at-mobile-day)
    + [Exemplo de app iOS simples com Storyboard](https://github.com/rodrigorgs/exemplo-ios-storyboard)
    + [Exemplo de app iOS simples com SwiftUI](https://github.com/rodrigorgs/exemplo-ios-swiftui)`

# Leituras recomendadas

- [10 Engineering Challenges Due to the Nature of Mobile Applications](https://blog.pragmaticengineer.com/10-engineering-challenges-due-to-the-nature-of-mobile-applications/)
- [Sistemas e dispositivos móveis nas universidades públicas: desafios e oportunidades](https://docs.google.com/document/d/1xkv2en13stqj3EnCGcdv29qvAT2dRk5YT1vJ85UrrVg/edit#)
- gov.uk Service Manual: [Making sure your service works well on mobile](https://www.gov.uk/service-manual/technology/working-with-mobile-technology) e [We're not ‘appy. Not ‘appy at all.](https://gds.blog.gov.uk/2013/03/12/were-not-appy-not-appy-at-all/)

# Referências

Em português:

- [K19 - Desenvolvimento Mobile com Android](http://www.stratura.com.br/uploads/fgfgdfgsdfg_1354214000.pdf)
- [Marlon Carvalho - Curso de Android](https://github.com/marloncarvalho/curso-android)

Em inglês:

- [Android Developers](https://developer.android.com/?hl=pt-br) (oficial)
- [Vogella - Android Development](http://www.vogella.com/android.html)

