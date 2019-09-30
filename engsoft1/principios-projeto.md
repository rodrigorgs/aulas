---
layout: page
title: Princípios de projeto orientado a objetos
---

## Leitura recomendada

- Livro [Engenharia de Software Moderna](https://engsoftmoderna.info/) (prof. Marco Tulio Valente, UFMG) [slides](https://docs.google.com/presentation/d/1pCz8hpS7ufqmTlLizmbWw54O54l6-twUbMr1ChmdYCw/edit#slide=id.g4ffa9ac22f_0_0) e [texto](https://docs.google.com/document/d/e/2PACX-1vTwzbOdLCUNLQEPBY933dEgJNAHKDNHsJA56dQqRZWqYawBvmg-m-HU66emL8-X6zVxUkA-UPRoz5_B/pub)
- [Sintomas de design de software podre](https://blog.coderockr.com/posts/2015/sintomas-de-design-de-software-podre/)
- [Pensamento funcional: imutabilidade](https://imasters.com.br/back-end/pensamento-funcional-imutabilidade) (ler até o final da seção "Classe imutável 'tradicional'")
- [equals e hashCode](https://blog.algaworks.com/entendendo-o-equals-e-hashcode/)

## Leitura complementar

- Robert C. Martin. [The principles of OOD](http://butunclebob.com/ArticleS.UncleBob.PrinciplesOfOod) (SOLID principles)
- Robert C. Martin. [Design Principles and Design Patterns](http://www.cvc.uab.es/shared/teach/a21291/temes/object_oriented_design/materials_adicionals/principles_and_patterns.pdf)
    - rigidity, fragility, immobility, and viscosity
- Maurício Aniche. Orientação a Objetos e SOLID para Ninjas.
- [SOLID, GRASP, and Other Basic Principles of Object-Oriented Design](https://dzone.com/articles/solid-grasp-and-other-basic-principles-of-object-o)
- Martin Fowler. [Is High Quality Software Worth the Cost?](https://martinfowler.com/articles/is-quality-worth-cost.html)
- Martin Fowler; Kent Beck. [Refactoring: Improving the Design of Existing Code](http://www.laputan.org/pub/patterns/fowler/smells.pdf) (capítulo 3: Bad Smells in Code)
- Acoplamento, coesão e métricas (CBO, LCOM)
    - [Métricas para Programas Orientados a Objetos (CK)](https://homepages.dcc.ufmg.br/~figueiredo/disciplinas/aulas/metricas-ck_v01.pdf)
- David Parnas. [On the Criteria To Be Used in Decomposing Systems into Modules](https://www.win.tue.nl/~wstomv/edu/2ip30/references/criteria_for_modularization.pdf)

## Notas de aula

- Ao projetar um sistema orientado a objetos, devemos observar algumas **propriedades de projeto**:
  - **integridade conceitual**: uso consistente das mesmas decisões em diversas partes do projeto, incluindo nomes de identificadores, mecanismos de passagem de dados e tratamento de erros, forma de organização de classes...
  - **ocultamento de informação**: aspectos da implementação que são propensos a mudanças devem ser escondidos dos clientes, de forma que alterações nessas implementações não devem requerer modificações nos clientes.
  - **coesão**: cada classe deve ter uma única responsabilidade; assim, para cada classe haverá apenas uma razão para alterá-la
  - **acoplamento fraco**: cada classe deve depender de pouca ou nenhuma informação de outras classes, de forma que seja mais fácil substituir as dependências. Ver também: ocultamento de informação.
- Ao avaliar um projeto, devemos verificar se ele apresenta certos [**sintomas** de projetos ruins (*design podre*)](http://www.cvc.uab.es/shared/teach/a21291/temes/object_oriented_design/materials_adicionals/principles_and_patterns.pdf):
  - **rigidez**: um software rígido é aquele que é difícil de alterar; mesmo um pequena mudança (para corrigir um bug simples, por exemplo) requer outras mudanças, que requer outras mudanças... Com um software rígido, é difícil estimar quanto tempo uma mudança vai levar para ser implementada.
  - **fragilidade**: um software frágil é aquele que no qual uma mudança em uma parte do código introduz bugs em diversas outras partes, mesmo partes que não têm nada a ver com a parte que foi alterada.
  - **imobilidade**: um software imóvel é aquele que possui muitas partes difíceis de serem reusadas em outros contextos (possivelmente devido a fortes acoplamentos). Isso pode ser observado quando se deseja implementar uma funcionalidade muito similar a outra que já foi implementada, mas é mais fácil reimplementar a funcionalidade do que reusar o que já foi implementado.
  - **viscosidade**: um software viscoso é aquele no qual é mais fácil implementar mudanças com gambiarras do que da forma "certa", isto é, que preserva a integridade conceitual.
- Algumas propriedades de objetos ou de referências para objetos:
  - **imutabilidade**: um objeto é imutável se, após sua criação, não pode ter seus dados alterados. O contrário de mutável é imutável. Considere uma classe com um atributo privado que deve ser apenas lido por objetos de outras classes (através de um *getter*), mas não deve ser alterado. Esse atributo deve corresponder a uma classe imutável ou então o *getter* deve retornar uma cópia. Isso é muito comum com listas, que são mutáveis em Java. Ver método `Collections.unmodifiableList()`.
  - **igualidade, identidade**. Duas referências são idênticas se apontam para o mesmo objeto (em geral, o endereço na memória onde o objeto foi alocado é a sua identidade). Em Java, usa-se `==` para determinar se duas referências são idênticas. Dois objetos são iguais (ou equivalentes) se satisfazem a um determinado critério de igualidade. Em Java, usa-se `equals()` para determinar se dois objetos são iguais. Para implementar um critério de igualdade em uma classe, você deve sobrescrever os métodos `equals()` e `hashCode()`.
  - **nulabilidade**: Uma referência é nulável se ela pode assumir o valor `null`.
- Princípios de projeto. Princípios SOLID:
  - **Single Responsibility Principle (SRP)**: cada classe deve ter uma única responsabilidade (ver também: *coesão*).
  - **Open/Closed Principle (OCP)**: classes devem ser abertas para extensão, mas fechadas para modificação. Em outras palavras, escreva classes de forma que seja possível alterar certos aspectos do seu comportamento sem precisar alterar o código-fonte da classe. Isso pode ser feito, por exemplo, através da herança.
  - **Liskov Substitution Principle (LSP)**: objetos de uma classe devem poder ser substituídos por objetos de uma subclasse sem prejudicar o funcionamento correto do programa.
  - **Interface Segregation Principle (ISP)**: É melhor criar múltiplas interfaces específicas do que uma interface geral, com múltiplas responsabilidades. Dessa forma, evita-se criar uma dependência entre um cliente e métodos que ele não usa (mas que estariam definidos em uma interface mais geral).
  - **Dependency Inversion Principle (DIP)**: dependa de interfaces, não de classes concretas. É comum programar de forma que classes de mais alto nível (mais abstratas, genéricas) dependam de classes de mais baixo nível (mais concretas, detalhadas). Através deste princípio, faz-se com que ambos dependam de uma mesma interface.
- Outros princípios de projeto orientado a objetos:
  - [**Lei de Demeter**](https://dzone.com/articles/the-genius-of-the-law-of-demeter): "fale com seus amigos; não fale com amigos de amigos". Dentro de um método de um objeto (cliente), só chame métodos de objetos que são: (1) recebidos como parâmetro, ou (2) criados localmente, ou (3) atributos do objeto, ou (4) variáveis globais (ex.: atributos estáticos).
  - **Favoreça composição a herança**.
  - **Encapsule o que muda**. Similar a *ocultamento de informação*.
  - **Programe para interfaces, não para implementações**. Ver *DIP*.
- Princípios mais gerais (não se aplicam somente a orientação a objetos)
  - **DRY** (Don't repeat yourself): evitar duplicação de código (usar abstrações para evitar repetição). "Cada porção de conhecimento em um sistema deve possuir uma representação única, de autoridade e livre de ambiguidades em todo o sistema"
  - **KISS** (Keep it simple, st\*\*\*\*): busque soluções simples; evite complexidade desnecessária.
  - **YAGNI** (You aren't gonna need it): não implemente algo pensando que pode ser útil no futuro; implementado quando (e se) for necessário.

<!-- 

- Propriedades de projeto (integridade conceitual, ocultamento de informação, coesão, acoplamento, EXTENSIBILIDADE)
- Princípios de projeto


- Rigidez, fragilidade, imobilidade, viscosidade
- Ocultamento de informação
- Imutabilidade
  - Disciplinas são imutáveis
- Padrão Strategy
  - Critério para escalonamento depende do curso
- SOLID: Interface Segregation Principle
  - Login => Loggable (tem usuário/senha), ParticipanteDeDisciplina (inclui professor, monitores, alunos)
- (Nullability)
- (Identity, equality, uniqueness)
- Padrão Composite
  - Disciplina tem professor ou conjunto de professores (?)
  - Cálculo de carga horária de disciplina e de carga horária de um conjunto de disciplinas
- Padrão Decorator
- Law of Demeter
  - Universidade => Curso => ComponenteCurricular => Disciplina
  - Ver Eclipse: generate delegate methods
- Template Method
  - Arquivos de saída com cabeçalho, corpo e rodapé
- SOLID: Liskov Substitution Principle
- Padrão Observer
  - Hollywood principle

- SOLID: Single Responsibility Principle
  - Classe para leitura de arquivos
- SOLID: Open/Closed Principle
  - Critério de escalonamento
  - Tipos de disciplina (ACCS)
  - Aproveitamento de carga horária (tipos de atividades)
- SOLID: Dependency Inversion Principle
  - Dois formatos de arquivo de entrada para ler
  - Ou dois formatos de arquivo de saída... (TXT e HTML)

- ACCS pode ser cursada duas vezes

DRY, Encapsulate what changes, composition over inheritance, Programming for Interface not implementation, 

-

https://pt.slideshare.net/makabee/solid-49254559


.......

# Exemplo de ocultamento de informação

class Pessoa {
  String nome;
  int idade;

  int getIdade() {
    return idade;
  }
}

==> 

class Pessoa {
  String nome;
  Date dataNascimento;

  int getIdade() {
    return Math.floor((Date.now() - dataNascimento) / 365);
  }
}

.......

Encapsulamento de Collections. Exemplo do deque de cartas.

.......
 
# Exemplo de coesão

- Falta de coesão: a classe Disciplina lê a disciplina de um arquivo.
- Coesão: Disciplina representa os dados. Para ler, usa-se DisciplinaReader.

..........

# Inversão de dependência

DisciplinaReader deve ser uma interface, implementada por DisciplinaArquivoReader, DisciplinaBDReader...

# Herança vs composição

Stack extends ArrayList?

# LSP

Exemplo: quadrado extends retângulo

 -->
