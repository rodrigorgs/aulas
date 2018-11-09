# Exercício do SISFILA em Rails

(**especificação incompleta**)

Para testar o SISFILA, você precisará configurar o seu ambiente de execução e iniciar a aplicação através de seu servidor web embutido. Aqui mostraremos como fazer isso com o [Codeanywhere](https://codeanywhere.com/), um ambiente de desenvolvimento online. Você precisará criar uma conta (gratuita) nos serviço, se ainda não tiver. Note que com a conta gratuita você só consegue criar um *container*.

## Configuração com o Codeanywhere

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
- `/` - interface pública com link para o telão e para uma página de consulta
- `/tela` - interface do telão onde os estudantes inserem seus nomes nas filas
- `/reset` - apaga todos os registros do banco de dados e recria os registros iniciais
