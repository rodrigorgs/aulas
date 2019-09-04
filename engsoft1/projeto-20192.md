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

O projeto deve estar no repositório do GitHub antes da apresentação. O diagrama de classes deve estar em um arquivo chamado `classes.png`, no diretório raiz do projeto.

Na sua modelagem, considere que uma universidade possui um nome, uma sigla, um conjunto de cursos e um conjunto de disciplinas. Um curso possui um conjunto de disciplinas de natureza obrigatória (que são organizadas em semestres sugeridos - ex.: disciplinas do 2º semestre) e um conjunto de disciplinas de natureza optativa, dentre as disciplinas da universidade. Uma disciplina possui um código alfanumérico, um nome, uma carga horária semestral (em horas), e zero ou mais pré-requisitos. Note que os pré-requisitos de uma disciplina podem variar de um curso para outro.

Para testar (parcialmente) se sua modelagem está correta, verifique se é possível instanciar três cursos, `CC`, `SI` e `LC`, e uma disciplina, `Engenharia de Software II (MATA63)`, de 68 h, de tal forma que essa disciplina seja obrigatória de 6º semestre em `CC`, obrigatória de 5º semestre em `SI` e optativa em `LC`.

Na aula do dia 17/09, sua equipe deve apresentar e explicar o diagrama de classes para a turma, esclarecendo quaisquer dúvidas que possam surgir.

## Entrega 1

- Leitura de dados do sistema a partir de arquivo texto fornecido pelo professor
- Interface gráfica
- Qualquer um pode visualizar currículos dos cursos e informações sobre cada disciplina
- Cadastro de alunos de cursos; autenticação via número de matrícula
- Aluno pode indicar disciplinas que já cursou
- Sistema exibe número de alunos que já cursaram cada disciplina
- Documentação:
- Apresentação: demonstração do sistema

## Entrega 2

- Aluno indica disciplinas que pretende cursar no próximo semestre (matrícula)
- Sistema emite sinal sonoro (ou não, a depender da configuração do sistema) cada vez que uma nova matrícula é realizada
- Coordenador aprova ou não matrícula
- Coordenador insere notas dos alunos
- Coordenador encerra semestre atual e inicia novo semestre
- Aluno visualiza histórico
- Apresentação: demonstração do sistema

## Entrega 3

- Projeto completo, com testes de unidade
- Critério: cobertura de testes
- Apresentação: demonstração do sistema