# Exercício do SISFILA em Rails

Link do exercício: <https://classroom.github.com/g/kf0gZ4Wd>

Neste exercício, você precisará criar testes de sistema para a aplicação web SISFILA, criada em Rails. Os testes devem ser escritos em Java, usando o framework Selenium, e devem usar o padrão Page Object, de forma que o código de teste não deve acessar o objeto WebDriver (exceto para inicialização e encerramento).

## Configuração da aplicação SISFILA

Para testar o SISFILA, você precisará baixar **a branch `test` do [repositório do SISFILA](https://gitlab.com/rodrigorgs/sisfila)** configurar o seu ambiente de execução e iniciar a aplicação através de seu servidor web embutido. Aqui mostraremos como fazer isso com o [Codeanywhere](https://codeanywhere.com/), um ambiente de desenvolvimento online. Você precisará criar uma conta (gratuita) nos serviço, se ainda não tiver. Note que com a conta gratuita você só consegue criar um *container*.

### Configuração com o Codeanywhere

Crie um projeto. Na caixa de diálogo `Connection Wizard`, digite um nome qualquer sob `Name`, escolha a *stack* Ruby com Ubuntu 16.04, e clique em `Create`.

Na aba que se abre com informações sobre o container, role a página até o final, onde há duas URLs. A última delas, no formato `http://port-XX.<nomeDoContainer>-<username><idNumerico>.codeanyapp.com/`, é a que usaremos como base para acessar a aplicação. Anote essa URL para futura referência.

Clique na aba do terminal e execute os seguintes comandos:

```bash
sudo apt-get update
sudo apt-get install -y redis-server
git clone https://gitlab.com/rodrigorgs/sisfila -b test
cd sisfila
bundle install --without production
rake db:migrate
redis-server &
rails server &
```

Acesse o caminho `/reset` da aplicação, trocando `XX` por 3000. A URL deve ficar algo do tipo `http://port-3000.<nomeDoContainer>-<username><idNumerico>.codeanyapp.com/reset`. Isso vai criar os usuários admin@example.com (senha: admin2222) e tela@example.com (senha: tela2222).

## Acesso

Alguns caminhos importantes:

- `/admin` - interface admin, onde pode-se criar, editar, consultar e excluir qualquer entidade do sistema
- `/` - interface pública com link para o telão e para uma página de consulta de posição de aluno
- `/tela` - interface do telão onde os estudantes inserem seus nomes nas filas
- `/reset` - apaga todos os registros do banco de dados e recria os registros iniciais
- `/cria-cenario` - cria um cenário de teste com diversos colegiados, alunos e grupos. Veja os dados criados na interface admin.


## Casos de teste

Você deve criar os seguintes testes, reusando ao máximo o cenário de teste criando em `/cria-cenario` e as classes disponíveis no código base do exercício:

- Dado que não há usuário autenticado, o telão não deve mostrar o campo de texto para digitar número de matrícula
- Quando o usuário digita no telão uma matrícula que não está associada a um colegiado, o sistema deve informar "Número de matrícula não encontrado"
- Dado que um aluno não está na fila, quando ele digita o seu número de matrícula no telão, o sistema deve informar o nome e a posição do aluno na fila correta
- Dado que o aluno já está na fila, quando ele digita o seu número de matrícula no telão, o sistema deve informar a posição do aluno na fila
- Dado que existe um aluno na primeira posição da fila mais prioritária de um colegiado (aguardando ser chamado), quando este colegiado chama o próximo da fila, o telão deve exibir o nome desse aluno
- Dado que existe um aluno sendo atendido em um colegiado, quando este colegiado chama o próximo da fila, o telão deve parar de exibir o nome desse aluno
- Dado que um colegiado possui duas filas, e que existe exatamente um aluno aguardando atendimento em cada fila, quando o aluno na segunda fila consulta sua posição, o sistema deve informar que ele está na segunda posição
- Dado que existem dois alunos, um de cada colegiado, e que um aluno está sendo atendido e o outro é o próximo a ser atendido pelo seu colegiado, quando este colegiado chama o próximo aluno, o telão deve mostrar o nome de ambos os alunos
- Dado que existe um aluno que é o próximo a ser chamado na fila de seu colegiado, quando o coordenador de colegiado chama o próximo da fila, o sistema deve exibir ao coordenador o nome desse aluno

Além disso, você deve criar mais dois testes relevantes, a seu critério. No arquivo `README.md` do seu projeto, você deve descrever esses dois testes, assim como informar quais métodos do seu código Java implementam esses dois testes.

Siga as convenções adotadas no código fornecido como base.
