---
layout: page
title: Projeto orientado a objetos
features: [code, uml]
---

## Programa orientado a objetos

- Um programa é composto de objetos
- Todo objeto tem um tipo, que é uma classe (ex.: o objeto `"alô"` é do tipo `string`)
- Objetos podem possuir outros objetos (ex.: uma lista de strings)
- Objetos possuem operações (ex.: adicionar um elemento em uma lista)
- Objetos interagem com outros objetos através de suas operações

Um objeto possui **dados** (que são outros objetos) e **comportamento** (através de suas operações).

## Conceitos: classes, objetos, métodos e atributos

### Classe

- Descreve propriedades (**atributos**) e operações (**métodos**) comuns a uma categoria de objetos (suas instâncias)
- *Exemplo*: em um jogo de corrida, a classe `Carro` descreve o que todos os carros possuem ou fazem:
  - atributos: `cor`, `velocidade`
  - métodos: `acelerar`, `frear`...
- Podemos dizer que uma classe é como um molde, a partir do qual podem ser criados vários objetos, que possuem os mesmos métodos e atributos

<div class="uml">
@startuml
class Carro {
  cor: string
  velocidade: float
  acelerar()
  frear()
}
@enduml
</div>

No diagrama, representamos os atributos `cor` (do tipo `string`) e `velocidade` (do tipo `float`), além dos métodos `acelerar()` e `frear()`.

### Objeto

- Um objeto é criado (**instanciado**) a partir de uma classe e pode ser manipulado através de seus métodos
- Todos os objetos de uma mesma classe possuem os mesmos métodos e atributos, mas os valores dos atributos podem variar de objeto para objeto
- *Exemplo*: meu carro é vermelho e encontra-se a 0 km/h; o carro do vizinho é azul e encontra-se a 25 km/h

<div class="uml">
@startuml
object meuCarro {
  cor = vermelho
  velocidade = 0
}
object carroDoVizinho {
  cor = azul
  velocidade = 25
}
@enduml
</div>

### Método

- Representa uma **ordem** que um objeto pode executar ou uma **pergunta** que ele pode responder.
- Exemplos (classe Carro):
  - acelere o carro!
  - o carro está em movimento?
- Para interagir com um objeto, **chamamos** um de seus métodos (isto é, damos uma ordem ou fazemos uma pergunta a ele)
- Métodos são como funções que têm acesso aos atributos de um objeto. Eles podem podem **receber parâmetros** (que são objetos) e **retornar um valor** (<span class="tooltip">que é um objeto<span class="tooltiptext">Em algumas linguagens, como Java, nem todos os valores são objetos</span></span>)

### Atributo

- É uma **variável** associada a um objeto. Os atributos são declarados em classes, mas seus valores podem variar de um objeto para outro.
- Em alguns casos não é recomendado acessar diretamente os atributos de um objeto; fazemos isso indiretamente através de métodos
- *Exemplo*: não devemos alterar diretamente a velocidade de um objeto da classe `Carro`; em vez disso, devemos chamar o método `acelerar`. Isso vai garantir que a velocidade...
  - aumente de forma gradual
  - não exceda a velocidade máxima

## Projeto orientado a objetos

A partir de uma especificação de um sistema (ou de um problema a ser resolvido com um sistema), podemos planejar como o programa orientado a objetos será estrurado em classes, atributos e métodos. Isso é o que chamamos de **projeto orientado a objetos**.

É comum usarmos diagramas para representar classes, atributos e métodos, bem como relacionamentos entre classes. Esses diagramas são chamados de **diagramas de classe**. A linguagem de modelagem UML define uma notação gráfica para diagramas de classe, e é ela que usaremos aqui.

### Classe Filme

Considere a seguinte especificação:

> O sistema Ufbaflix gerencia **filmes**. Cada filme possui um **título**, um **ano de lançamento** e uma **duração**.

Um bom ponto de partida para o projeto orientado a objetos é identificar os substantivos na especificação; eles geralmente se tornam classes ou atributos.

Eis um exemplo de projeto:

<div class="uml">
@startuml
class Filme {
  titulo: string
  ano: int
  duracao: tempo
}
@enduml
</div>

A título de exemplo, aqui está um diagrama de objetos, ilustrando possíveis instâncias da classe `Filme`:

<div class="uml">
@startuml
object filme1 {
  titulo = O Auto da Compadecida
  ano = 2000
  duracao = 1:30:00
}
object filme2 {
  titulo = Shrek
  ano = 2001
  duracao = 1:55:00
}
@enduml
</div>

### Classe Filme com diretor da classe Pessoa

Aqui um exemplo mais complexo, na qual cada filme possui um diretor (e alguns objetos para exemplificar):

<div class="uml">
@startuml
class Filme {
  titulo: string
  ano: int
  duracao: tempo
}
class Pessoa {
  nome: string
  anoNascimento: int
}
Filme --> Pessoa: diretor
object filme1 {
  titulo = O Auto da Compadecida
  ano = 2000
  duracao = 1:30:00
}
object filme2 {
  titulo = O Bem Amado
  ano = 2010
  duracao = 1:27:00
}
object pessoa1 {
  nome = Guel Arraes
  anoNascimento = 1953
}
filme1 --> pessoa1: diretor
filme2 --> pessoa1: diretor
@enduml
</div>

A seta de `Filme` para `Pessoa` indica que todo objeto do tipo `Filme` possui um atributo, `diretor`, cujo valor é um objeto do tipo `Pessoa`.

> Em um diagrama de classes, uma seta de uma classe `A` para uma classe `B` indica que `A` possui um atributo cujo valor é um objeto do tipo `B`

### Classe Filme com diretor e atores

Vamos agora supor que cada filme possui vários atores:

<div class="uml">
@startuml
class Filme {
  titulo: string
  ano: int
  duracao: tempo
}
class Pessoa {
  nome: string
  anoNascimento: int
}
Filme -right-> "1" Pessoa: diretor
Filme -right-> "*" Pessoa: atores
@enduml
</div>

Aqui, estamos anotando a seta com `1` ou `*`, com o seguinte significado:

- Objetos da classe `Filme` podem ter apenas um `diretor`, da classe `Pessoa`
- Objetos da classe `Filme` podem ter vários `atores`, da classe `Pessoa`

## Exercício: sistema acadêmico

Crie um diagrama de classes para a seguinte especificação:

- Um curso possui alunos, disciplinas e um coordenador
- Cada aluno possui nome e um número de matrícula
- Cada disciplina possui um código, uma carga horária e uma lista de alunos matriculados
- A cada semestre, o coordenador realiza a matrícula, perguntando ao aluno o código da disciplina na qual quer se matricular, e então adiciona o aluno à lista de alunos matriculados na disciplina

## Exercício: outras ideias

- Site de busca de passagens aéreas (Google Flights)
  - Caso de uso. Usuário especifica cidade de origem, cidade de destino, data inicial e final, número de adultos e número de crianças; resultados são voos (aeroporto para aeroporto) de companhias aéreas (dois tipos: voo de ida e voo de volta). Pode haver conexões. Preço.
- Sistema de e-commerce (ex.: Magalu, Amazon)
- Sistema de streaming (ex.: Netflix, Globo+)
- Jogo de xadrez
- Jogo de [cartas](cartas.md)
- Jogo de dominó
- Árvore genealógica
- Programa de ilustração com formas geométricas
- Agenda telefônica (contatos)
- Conta bancária
- Televisão
- Aplicativo de transporte individual (ex.: Uber, 99)
- Aplicativo de delivery de comida (ex.: iFood, Uber Eats)
- Rede social (ex.: Instagram, TikTok)
- Sistema de hospedagem (ex.: AirBnB, Booking)
- Sistema de agendamento de compromissos
- Biblioteca de componentes gráficos (botões, caixa de texto...)
- Biblioteca para manipular vetores