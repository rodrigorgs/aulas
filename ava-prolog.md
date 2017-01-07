---
layout: page
title:  "Trabalho de Prolog"
date:   2017-01-06 16:40:00 -0300
categories: avaliacao
---

## Especificação

Considere uma base de conhecimento acadêmica com fatos no seguinte formato:

- `disciplina(X)`: `X` é uma disciplina. Exemplo: `disciplina(mata56)`.
- `prereq(X, Y)`: a disciplina `X` é pré-requisito para a disciplina `Y`. Exemplo: `prereq(mata56, mata64)`.
- `turma(D, C)`: a disciplina `D` possui uma turma com código `C`. Exemplo: `turma(mata56, t1)`.
- `aulas(turma(D, C), ListaHorarios)`: a turma `turma(D, C)` possui os horários listados em `ListaHorarios`, onde cada item de `ListaHorarios` está no seguinte formato:
    - `horario(Dia, Ini, Fim)`: horário de aula no dia da semana `Dia` iniciando às `Ini` horas e finalizando às `Fim` horas. Exemplo: `horario(seg, 13, 15)`.
    - Exemplo de aulas: `aulas(turma(mata56, t1), [horario(qua, 16, 18), horario(sex, 16, 18)])`.

Crie regras para os seguintes predicados:

- `prereq_transitivo(X, Y)`: a disciplina `X` é pré-requisito de `Y`, direta ou indiretamente.
- `choque_horario(H1, H2)`: existe choque entre os horários `H1` e `H2`.
- `choque_turma(T1, T2)`: existe choque de horário entre as turmas `T1` e `T2`. Observação: para saber se há choque de horário entre as turmas, é preciso definir quais são as aulas de cada turma.
- `alocacao_invalida(ListaTurmas)`: considerando que um aluno está tentando se matricular nas turmas pertences a `ListaTurmas`, indica se essa alocação de matrícula é inválida. Considere que a alocação é inválida se qualquer uma das seguintes condições é verdadeira:
    - a alocação quebra algum pré-requisito
    - existe choque de horário
    - a alocação (`ListaTurmas`) contém duas ou mais turmas da mesma disciplina
- `carga_horaria_horarios(ListaHorarios, C)`: a carga horária semanal dos horários listados é igual a `C`.
- `carga_horaria_turmas(ListaTurmas, C)`: a carga horária semanal das turmas listadas é igual a `C`.

## Corretor automático

<http://162.243.187.95/>
