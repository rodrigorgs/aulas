# Exercício JSISFILA

O SISFILA é uma aplicação web implementada em Ruby on Rails para gerenciar filas de atendimento. Ele foi usado para agilizar o atendimento de alunos na matrícula presencial de 3 cursos da UFBA para o semestre 2018.2. Seu nome é uma homenagem aos nomes de alguns sistemas criados pela STI-UFBA, como SISCON, SISBIC, SISBIEX, SISPER, SISAU, entre outros.

Neste exercício você desenvolverá e testará um sistema baseado no SISFILA, o JSISFILA, implementado em Java, a partir de uma especificação.

Durante a aula criaremos um *design* orientado a objetos a partir da especificação. Todos devem seguir esse *design* na hora de implementar e testar.

Nota para o instrutor: especificar limites de cobertura: <https://www.eclemma.org/jacoco/trunk/doc/check-mojo.html>

## Exercício 1

Implemente os requisitos iniciais e crie testes automatizados para eles. Use como base o código em <https://classroom.github.com/g/pcl40VAm>. Você pode criar novos métodos e atributos se necessário. Para fins didáticos, sugere-se o uso de TDD.

## Requisitos iniciais

- Inicialmente, o sistema precisa atender a apenas um colegiado
- O colegiado é identificado unicamente por uma string formada por exclusivamente por letras maiúsculas (ex.: BCC, BSI, LC...), e por um nome (obrigatório)
    - O sistema deve permitir que o usuário digite letras minúsculas, mas estas devem ser convertidas para maiúsculas
- O colegiado possui alunos
- Todo aluno possui um número de matrícula, que é um número de 9 dígitos que o identifica unicamente
- Durante a matrícula presencial, o aluno pode digitar seu número de matrícula em um telão, para entrar no final da fila de atendimento
  - Se o número de matrícula for inválido, o sistema deve informar que a matrícula é inválida
  - Se o número de matrícula for válido, mas não estiver na lista do colegiado, o sistema deve informar que não está na lista do colegiado
  - Se o aluno estiver sendo atendido no momento, ele não pode entrar na fila (o sistema deve informar que ele já está sendo atendido)
  - Se o aluno já estiver na fila e não tiver sido atendido ainda, ele não pode entrar na fila novamente
- Pode-se consultar a posição na fila de qualquer pessoa através de seu número de matrícula. Possíveis resultados:
  - "Está na sua vez"
  - "Você é o Xº da fila"
  - "Você já foi atendido"
  - "Você não está na fila"
- O sistema deve informar a quantidade de atendimentos realizados (ou em andamento) e o número de atendimentos a serem realizados.
- O sistema deve informar o total de alunos atendidos.
- O colegiado pode ver quem é o aluno atual na fila e chamar o próximo aluno da fila

## Evolução: múltiplos colegiados

- O sistema possui múltiplos colegiados. Cada aluno pode estar em no máximo um colegiado.
- Cada colegiado possui uma fila
- Ao digitar o número de matrícula, o aluno deve ir para a fila do colegiado ao qual pertence.

## Evolução: múltiplas filas e grupos

- Em um dado momento, um colegiado pode atender a múltiplas filas, sendo que cada possui um código (até 5 caracteres) e uma prioridade, que é um número inteiro positivo (quanto menor, mais prioritário)
- Não pode haver duas filas com a mesma prioridade.
  + Se as filas A e B têm prioridades 1 e 2, respectivamente, e cria-se uma fila C com a prioridade 1, então as filas A e B passam a ter prioridade 2 e 3, respectivamente (shift down)
- Cada fila está associada a um grupo de alunos de um colegiado. Por exemplo, pode haver um grupo "alunos formandos", um grupo "alunos com coeficiente de rendimento maior que 6,0" etc.
  - Um aluno pode pertencer a mais de um grupo
  - O grupo não pode conter alunos de múltiplos colegiados
- Ao digitar o número de matrícula, o aluno deve ir para a fila mais prioritária associada a um grupo ao qual ele pertence
- Quando o colegiado chama o próximo aluno, deve-se chamar o próximo aluno da fila mais prioritária que ainda tiver alunos a serem chamados.
- Naturalmente, todas as operações devem continuar funcionando

## Evolução: múltiplos postos de atendimento