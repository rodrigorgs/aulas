---
layout: page
title: "Projeto: sistema acadêmico (2019.2)"
---

Equipes de até 6 pessoas.

<!-- 

Meuhorario: disciplinas com turmas/horários, pré-requisitos, currículo de curso

Orientação acadêmica: guardar histórico do aluno, notas, registrar intenção de matrículas futuras, ordenação topológica

Outros: banca de TCC, avaliação de professores

 -->

O projeto consiste em um sistema desktop para gerenciamento de uma universidade, e deve ser desenvolvido por equipes contendo entre 3 e 6 pessoas. O sistema será desenvolvido incrementalmente, com entregas parciais ao longo do semestre. As entregas serão realizadas no GitHub, através do endereço <https://classroom.github.com/g/spmbcgWX>

## Entrega 0: apresentação no dia 17/09

Para a entrega 0, sua equipe precisará criar um projeto Java contendo as classes do domínio acadêmico (com seus respectivos atributos, construtores, getters e setters, considerando a visibilidade apropriada para cada membro), além de um diagrama de classes representando as classes do projeto. No diagrama de classes, omita os getters e setters para melhorar a legibilidade. Use boas práticas de codificação e de modelagem.

O projeto deve estar no repositório do GitHub antes da apresentação. O diagrama de classes deve estar em um arquivo chamado `classes.png` ou `classes.pdf`, no diretório raiz do projeto.

Na sua modelagem, considere que uma universidade possui um nome, uma sigla, um conjunto de cursos e um conjunto de disciplinas. Um curso possui um conjunto de disciplinas de natureza obrigatória (que são organizadas em semestres sugeridos - ex.: disciplinas do 2º semestre) e um conjunto de disciplinas de natureza optativa, dentre as disciplinas da universidade. Uma disciplina possui um código alfanumérico, um nome, uma carga horária semestral (em horas), e zero ou mais pré-requisitos. Note que os pré-requisitos de uma disciplina podem variar de um curso para outro.

Para testar (parcialmente) se sua modelagem está correta, verifique se é possível instanciar três cursos, `CC`, `SI` e `LC`, e uma disciplina, `Engenharia de Software II (MATA63)`, de 68 h, de tal forma que essa disciplina seja obrigatória de 6º semestre em `CC`, obrigatória de 5º semestre em `SI` e optativa em `LC`.

Na aula do dia 17/09, sua equipe deve apresentar e explicar o diagrama de classes para a turma, esclarecendo quaisquer dúvidas que possam surgir.

## Entrega 1: entrega e apresentação no dia 22/10

Nesta entrega, você adicionará as seguintes funcionalidades:

- **Leitura de dados** do sistema a partir de [arquivo texto](/aulas/mata37/web/dados.txt) fornecido pelo professor. Ver [código de exemplo](le-dados.java) <!-- Single responsibility principle: usar classe dedicada para leitura -->
- Criação de **alunos** da universidade, com nome, número de matrícula (é um identificador único) e senha. Cada aluno pertence a apenas um curso. <!-- override de equals -->
- Criação de **histórico** de um aluno: lista de componentes curriculares cursados por semestre, indicando código, nome, carga horária, natureza, nota e conceito (aprovado, reprovado por nota, reprovado por falta, dispensa, trancamento). Só existe nota quando o conceito é aprovado ou reprovado por nota.
    - Impressão do histórico, com cálculo da carga horária total (optativa e obrigatória) e CR (nota média) do aluno. Considere que o CR é calculado através da média simples das notas. <!-- disciplinas devem ser imutáveis --> <!-- entrega 2: usar composite -->
    - A impressão dos histórico deve poder ser feita em dois formatos diferentes: TXT e HTML <!-- Entrega 2: implementar template method -->
- Impressão do **currículo** do curso, que lista disciplinas obrigatórias, por semestre, e optativas, informando, para cada disciplina, o código, o nome, e a carga horária. <!-- Law of demeter: curso.getComponente().getCargaHoraria()  -->
<!-- - Cálculo de escalonamento do curso. Cada curso adota critérios diferentes. -->
  <!-- padrão Strategy, open/closed principle -->
<!-- - Autenticação de alunos e do coordenador. -->

Neste momento não é necessário criar nenhuma interface com o usuário. No entanto, você deve seguir princípios de projeto orientado a objetos. Alguns aspectos a observar (note que a lista não é completa):

- Certas classes devem ser imutáveis
- Defina o critério de igualidade das classes quando isso for relevante
- Use conjuntos ou listas de acordo com a situação

<!-- 
- Leitura de dados do sistema a partir de arquivo texto fornecido pelo professor
- Interface gráfica
- Qualquer um pode visualizar currículos dos cursos e informações sobre cada disciplina
- Cadastro de alunos de cursos; autenticação via número de matrícula
- Aluno pode indicar disciplinas que já cursou
- Sistema exibe número de alunos que já cursaram cada disciplina
- Documentação:
- Apresentação: demonstração do sistema
 -->

## Entrega 2: entrega e apresentação no dia 19/11

Na entrega 2 você vai criar uma interface gráfica com o usuário usando o Java Swing, o JavaFX ou o Android SDK. Se optar por usar o Java Swing, você pode usar a extensão [WindowBuilder](https://www.eclipse.org/windowbuilder/) para Eclipse.

Considere que a interface gráfica será usada exclusivamente pelo coordenador do curso, que possui todas as permissões. Conside os seguintes casos:

- Coordenador cadastra aluno, informando nome, número de matrícula e semestre de ingresso
  - Sistema exibe mensagem de erro se alguma das informações estiver em branco ou se o aluno já foi cadastrado
- Coordenador lista alunos
- Coordenador seleciona aluno para visualizar informações sobre ele
- Coordenador visualiza histórico de um aluno
  - O formato pode ser HTML ou TXT
- Coordenador lista currículo do curso
- Coordenador visualiza escalonamento de matrícula do curso
  - Há dois critérios: por ordem decrescente de CR (desempatando por ordem crescente de semestre) ou por ordem crescente de semestre (desempatando por ordem decrescente de CR)

Considere uma arquitetura da seguinte forma:

- As classes que representam entidades do sistema (ex.: aluno, universidade, curso...) devem estar em um pacote chamado `*.domain` (onde * é o nome do pacote principal de sua aplicação, como `br.ufba.mata62.team1`)
- As telas do sistema devem estar em um pacote chamado `*.controller`, com sufixo `Controller` (ex.: `CurriculoController`)
- As operações do sistema devem estar em classes do pacote `*.service`, com sufixo `Service` (ex.: `AlunoService`)
- Código de acesso a arquivo deve estar em classes do pacote `*.repository`, com sufixo `Repository`
- Controller, Service e Repository devem ser estruturados em camadas
- Todos os pacotes podem acessar o pacote `*.domain`
- Não deve haver lógica de negócio nos controllers; use os services para isso
- Cenários de erro devem resultar em uma exceção customizada sendo lançada pelo service e tratada pelo controller
- A visualização do histórico em diferentes formatos deve ser implementada com o padrão de projeto Template Method
- A escolha do critério de escalonamento deve ser implementada com o padrão de projeto Strategy
- Siga a lei de Demeter

No dia da entrega, atualize o repositório Git **antes** da aula.

<!-- - Aluno indica disciplinas que pretende cursar no próximo semestre (matrícula)
- Sistema emite sinal sonoro (ou não, a depender da configuração do sistema) cada vez que uma nova matrícula é realizada
- Coordenador aprova ou não matrícula
- Coordenador insere notas dos alunos
- Coordenador encerra semestre atual e inicia novo semestre
- Aluno visualiza histórico
- Apresentação: demonstração do sistema -->

## Entrega 3

A definir.

<!-- - Projeto completo, com testes de unidade
- Critério: cobertura de testes
- Apresentação: demonstração do sistema -->