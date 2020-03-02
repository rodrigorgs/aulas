# Exercício de mock: projeto mock-leilao

[Link para o exercício no GitHub Classroom](https://classroom.github.com/g/5okMX9ub) (veja o prazo da atividade no link)

O projeto `mock-leilao` é um gerenciador de leilões. A classe `EncerradorDeLeilao` é responsável por encerrar os leilões iniciados há pelo menos 7 dias (método `encerra()`). Ela colabora com objetos que implementam as seguintes interfaces: 

- `RepositorioDeLeiloes`: fornece acesso aos leilões armazenados em alguma fonte de dados (por exemplo, um banco de dados). Essa interface especifica um DAO (*data access object*). Métodos:
    - `salvar(Leilao)`: insere um leilão na fonte de dados
    - `atualiza(Leilao)`: atualiza os dados de um leilão
    - `encerrados()`: retorna os leilões encerrados
    - `correntes()`: retornas os leilões que não foram encerrados
- `EnviadorDeEmail`: o método `envia(Leilao)` é responsável por enviar uma mensagem de e-mail com dados de um leilão.

Sua tarefa é implementar 4 testes para o método `encerra()` da classe `EncerradorDeLeilao`, de acordo com a seguinte especificação:

- `deveEncerrarLeiloesQueComecaramUmaSemanaAtras`: dado que o repositório possui dois leilões antigos (criados há pelo menos 1 semana), ao chamar `EncerradorDeLeilao.encerra()`, os dois leilões devem estar encerrados, e o número total de leilões encerrados deve ser 2.
- `naoDeveEncerrarLeiloesQueComecaramMenosDeUmaSemanaAtras`: dado que o repositório possui dois leilões recentes (criados há menos de 7 dias), ao chamar `EncerradorDeLeilao.encerra()`, os dois leilões não devem estar encerrados, e não deve haver nenhuma atualização de dados no repositório de leilões.
- `deveEnviarUmEmailParaCadaLeilao`: dado que o repositório possui exatamente um leilão antigo, ao chamar `EncerradorDeLeilao.encerra()`, deve ser enviado exatamente um e-mail referente a esse leilão.
- `deveContinuarSeDaoFalharNaAtualizacao`: dado que o repositório possui dois leilões antigos, ao chamar `EncerradorDeLeilao.encerra()`, dado que ao atualizar os dados do primeiro leilão é lançada uma `RuntimeException`, o segundo leilão deve ser atualizado no repositório e deve ser enviado um e-mail referente ao segundo leilão, mas não ao primeiro leilão.

--------------

# Script de correção

O script de correção do exercício está disponível para download: [testa-mock-leilao.rb](testa-mock-leilao.rb). Trata-se de um script escrito em Ruby, que deve ser executado na raiz do projeto Java. O script cria mutantes e executa os testes; espera-se que cada mutante provoque a falha de um teste.

