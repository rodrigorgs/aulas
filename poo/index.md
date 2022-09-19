---
layout: page
title: MATA55 - Programação orientada a objetos - 2022.2
---

## Informações básicas

- Professor: Rodrigo Rocha <rodrigorgs@ufba.br>
- Monitor: Caio Miranda <caiomp@ufba.br>
- Aulas:
  - SEG, 13:00, lab 143 do IME
  - QUA, 13:00, sala 108 do PAF I

## Avaliações

- [3,0] Pequenos exercícios de código em Python (individual) - exercícios indicados **em negrito** nesta página
- [4,0] [Projeto em Python (em equipe)](projeto-jogo-oo) - jogo usando a biblioteca [Pyglet](pyglet)
- [3,0] Prova escrita sobre programação orientada a objetos com Java (individual)

<!-- - [4,0] Projeto em Python (em equipe) - [sopa de letrinhas](sopa-de-letrinhas) usando a biblioteca [Pyglet](pyglet) -->

## Política de honestidade

Para aprender a programar você precisa praticar muito. Por isso, para aproveitar melhor a disciplina, este você deverá resolver os exercícios práticos individualmente. Fique à vontade para discutir as questões com colegas, mas jamais compartilhe o código-fonte da solução. Nós levamos a política de honestidade muito a sério e utilizaremos soluções computacionais para identificar cópias das soluções submetidas.

## Conteúdo

**Introdução: paradigmas de linguagens de programação e programação orientada a objetos**

- [Introdução à programação orientada a objetos](https://docs.google.com/presentation/d/1bdzbS51fA-BewCaC0gMNuTSQWtDXfrHKVRiR3I-URnY/edit)

**Parte 1: revisão e aprofundamento sobre a linguagem Python e funções**

- Introdução a Python
  - [Introdução à linguagem Python](/aulas/ilp/00b-intro-python)
  - [Revisão da linguagem Python](/aulas/ilp) (material da disciplina de Introdução à Lógica de Programação)
  - **[Exercícios de Python básico](ex-python-intro)**
- Revendo Python sob o ponto de vista da programação orientada a objetos: 
  - [Objetos, referências, identidade, mutabilidade](intro-objetos-py)
- Programação procedural (programa construído a partir de funções)
  - [Funções](intro-funcoes-py): parâmetros, retorno, funções tagarelas
  - [Variáveis e funções](funcoes-variaveis): escopo, variáveis locais e globais, sombreamento, reatribuição e passagem de objetos mutáveis como parâmetro
  - [Recursos extras de funções em Python](funcoes-python): parâmetros *default* e argumentos nomeados
  - **[Exercícios de funções em Python](ex-python-funcoes)**
  - [Construindo programa procedural a partir de uma especificação](funcoes-exemplo-py): especificação, refatoração, diagramas
- Outros tópicos em Python
  - [Módulos e pacotes](python-modules)
  - Manipulando arquivos

**Parte 2: programação orientada a objetos com Python**

- Importância: as principais linguagens de programação são orientadas a objetos. Ver ranking do [TIOBE](https://www.tiobe.com/tiobe-index/) e [PYPL](https://pypl.github.io/PYPL.html)
- Conceitos básicos de orientação a objetos: [1](https://docs.google.com/presentation/d/1bNv_WTRK7ncIDEkAWZ3q2WdZu5vi5Ran-8gT_As1c8A/edit) e [2](projeto-oo)
- Classes, objetos, métodos, atributos e construtores: [1](https://docs.google.com/presentation/d/19bN5IqfxQADgGKLlZ67mLPuQLYC_SKAtltJCNSKzkdE/edit) e [2](definindo-classes)
- **[Exercícios sobre classes](ex-python-oo)**
- [Encapsulamento, visibilidade, propriedades](https://docs.google.com/presentation/d/14DtBOvTD-30YsbB5CpDTKU-E0GYdhxV0Mpwd_8WGc6U/edit)
- **[Exercício: rede social](ex-python-rede-social)**
- **[Exercícios envolvendo propriedades](ex-python-oo2)**
- [Membros estáticos](https://docs.google.com/presentation/d/1UrWfmWoLe9xsb5WmU2mMCHw0AEWOqiRgO_AbyNpvQ_0/edit)
- **[Exercícios sobre membros estáticos](ex-python-static)**
- [Enums](https://docs.google.com/presentation/d/1g59YNwbirJTdeCS27CGqPsMJ6wr8wvoIKzaJsb2x5kQ/edit)
- **[Exercícios sobre enums](ex-python-enum)**
- [Sobrecarga de operadores](https://docs.google.com/presentation/d/1UfZ7swOojM6QOnZa5mA9VCZmvby1Dd9bniIOuaiPYI0/edit)
- Exceções
- Herança, polimorfismo, sobrecarga de operadores
- Tipagem estática; optional, generics
- Extra: reflexão, testes de unidade

**Parte 3: Java**

- Linguagem Java
- Construtores
- Visibilidade
- Static e final
- Herança, classes abstratas e interfaces
- Collections e Generics
- Exceções checadas e não-checadas

<!-- - [Construindo um programa OO a partir de uma especificação](exemplo-classes) -->
<!-- - [Usando objetos](usando-objetos): objetos, atributos, métodos -->

**Material complementar**

[Diferenças entre Java e Python](https://docs.google.com/presentation/d/1zKDn5ifd4CCN3o8ZqlgOlS-sWF78BRTyMURRX5Crnmw/edit)

<!-- 
| Categoria | Conteúdo                                                                           |
|-----------|------------------------------------------------------------------------------------|
| Intro     | [Introdução à programação orientada a objetos][intro]                              |
| .         |                                                                                    |
| Java      | [Eclipse, uma IDE para Java][eclipse]                                              |
| Java      | [Alô mundo, pacotes](aula-java-alomundo)                                           |
| Java      | [Programação procedural em Java](aula-java-programacao) (com exercícios)           |
| Java      | [Ecossistema Java: Javadoc, Maven](aula-java-ecossistema) (javadoc, maven)         |
| Java      | [Referências, identidade e igualdade][referencias].                                |
| .         |                                                                                    |
| OO        | [Classes, atributos, métodos](aula-java-oo2)                                       |
| OO        | [Classes, atributos, métodos, construtores, this](aula-classes)                    |
| OO        | [Orientação a objetos básica (static e final)](aula-java-oo)                       |
| .         |                                                                                    |
| OO        | [Classes, construtores, garbage collector, this][construtores]                     |
|           | - [Quiz][quiz1]                                                                    |
| Java      | [Sobrecarga (overload)](aula-overload)                                             |
| Java      | [Enums](aula-enums) -- exemplo: [cartas de baralho](cartas)                        |
| OO        | Encapsulamento: [Pacotes, modificadores de acesso, getters e setters](aula-acesso) |
|           | - [Quiz][quiz2]                                                                    |
| .         |                                                                                    |
| Java      | [Collections](aula-collections)                                                    |
| Java      | [Exceções](aula-excecoes)                                                          |
| OO        | Encapsulamento: [Imutabilidade e referências escapando](aula-imutabilidade)        |
| .         |                                                                                    |
| OO        | [Herança](aula-heranca-parte1.md).                                                 |
| OO        | .. [Sobreposição](aula-heranca-parte2.md)                                          |
| OO        | .. [Polimorfismo](aula-heranca-parte3.md)                                          |
| OO        | .. [Classes e métodos abstratos](aula-heranca-parte4.md)                           |
| OO        | [Tipos e interfaces](aula-interfaces)                                              |
| .         |                                                                                    |
| OO        | [Generics](aula-generics).                                                         |
| OO        | [Classes internas](aula-classes-internas).                                         |
| OO        | Reflection, annotations                                                            |
| Skills    | Debugging                                                                          |
| Skills    | Controle de versão                                                                 |
| Skills    | Testes de unidade                                                                  |
| Skills    | [Refatoração](aula-refactoring)                                                    |
 -->
<!-- | OO        | [Modelagem conceitual](aula-modelagem)                                             | -->
<!-- | OO        | UML: diagramas de classes e de objetos                                                            | -->

[intro]: https://docs.google.com/presentation/d/1bdzbS51fA-BewCaC0gMNuTSQWtDXfrHKVRiR3I-URnY/edit
[eclipse]: https://docs.google.com/presentation/d/1BohOI0Ky0cqwsze7U-PnJc_qU9u9dbKtvUOwiH63HIY/edit?usp=sharing
[referencias]: https://docs.google.com/presentation/d/13w59yenVXOT4vXk14c5-JMgP62ty3LPkBHCMpwk61zM/edit
[construtores]: https://docs.google.com/presentation/d/1U1eChwz2O0TnrF04DiUQ5fEANGflUVdCPtR_azmNgdo/edit
[acesso]: https://docs.google.com/presentation/d/1MRqTOvbEnzAspcvW8_wWkKZSNJU1a6l3TVGTGSjkvMQ/edit
[quiz1]: https://create.kahoot.it/details/programacao-orientada-a-objetos-com-java-parte-1/93655e8b-0866-41fa-ba09-439c8709cc8b
[quiz2]: https://create.kahoot.it/details/programacao-orientada-a-objetos-parte-2/3ef15af5-873c-40e9-bb1e-1a6a7316fcc7

<!-- 
Alguns slides disponíveis no [Drive da disciplina](https://drive.google.com/open?id=1JxHnqlfg74vCFhJf1LfS3d4w70Ev8qBN)

Outros slides ou notas de aula:

- [Herança parte 1](aula-heranca-parte1)
- [Herança parte 2 (sobreposição)](aula-heranca-parte2)
- [Herança parte 3 (polimorfismo)](aula-heranca-parte3)
- [Herança parte 4 (classes abstratas e interfaces)](aula-heranca-parte4)
- [Refatoração](aula-refactoring)
- [Enums](aula-enums)
- [Exceções](aula-excecoes)
- [Classes internas](aula-classes-internas)
- [Generics](aula-generics) -->

<!-- 
# Bibliografia recomendada

Os livros a seguir estão disponíveis nas bibliotecas da UFBA:

- SANTOS, Rafael. Introdução à programação orientada a objetos usando Java. Rio de Janeiro, RJ: Elsevier, c2003. 319, [6] p. ISBN 9788535212068 (broch.).
- DEITEL, Harvey M.; DEITEL, Paul J. Java: como programar. 8.ed. São Paulo, SP. Pearson Prentice Hall, 2010. xxix 1144 p. ISBN 9788576055631(broch.).
- ECKEL, Bruce. Thinking in Java. 2nd ed. Upper Saddle River, NJ: Prentice Hall, 2000. 1127 p. ISBN 0130273635 (broch.). -->
