# Aplicação da prova

## Preparação

1. Edite o arquivo `_layouts/lisp.html` se for necessário alterar algo no template.
2. Troque a senha no arquivo `login.php`.
3. Crie a prova como arquivo `.md` na raiz do site.
4. Faça o build com o comando `jekyll build`.
5. Execute o comando `./empacota.sh`, passando o caminho para o arquivo HTML da prova (dentro de `_site`) e o caminho onde será gerada a prova.
6. Copie a pasta gerada para um pendrive.

## Dependências

1. PHP (>= 5.0), com a extensão mysqli (`sudo apt-get install php-mysql` -- em alguns casos é `php5-mysql`)
2. MySQL

## Configuração

1. Copie a pasta gerada do pendrive para o computador do laboratório.
2. Altere os dados de conexão ao banco de dados no arquivo `save.php`, se necessário.
3. Crie o banco de dados `mata56`, se ainda não existir: `mysql -uroot -proot` e, a seguir, `CREATE DATABASE mata56;`.
4. Abra um terminal na pasta copiada para o computador e inicie o servidor web embutido: `sudo php -S 0.0.0.0:80 -t .`

## Execução da prova

1. O aluno deve acessar o endereço `$IP:$PORTA/aulas`, onde `$IP` é o IP da máquina e `$PORTA` é a porta na qual o servidor web está rodando.
2. O aluno deve clicar no botão `Login`, preencher seus dados e clicar em cancelar.
3. O professor irá até cada um dos alunos, clicará em `Login`, preencherá a senha definida no arquivo `login.php` e clicará em `Enviar`. Se a senha estiver correta, os dados do aluno aparecerão no topo, do lado esquerdo.	
4. A partir daí o aluno deve realizar a prova e, ao final, clicar no botão `Enviar respostas`.	

## Após a prova

1. Pare o servidor PHP (Ctrl+C) e o MySQL (Ctrl+D).
2. Execute o comando `mysqldump -uroot -proot mata56 | gzip > /tmp/respostas.sql.gz`
3. Copie o arquivo resultante para o pendrive.

--------------------

# Correção da prova

## Importação dos dados

1. Conecte ao MySQL e crie um banco de dados chamado `mata56`. Ex.: `mysql -uroot -proot`; `create database mata56;`
2. Importe os dados salvos. Ex.: `gzcat /tmp/respostas.sql.gz | mysql -uroot -proot mata56`

## Preparação

1. Edite o arquivo `_layouts/lisp.html` se for necessário alterar algo no template.
2. Se necessário, altere a senha do banco de dados nos arquivos `login.php` e `load.php`.
3. Crie um link simbólico de `_site` em `/tmp/mata56`: ``cd _site; ln -s `pwd` /tmp/mata56``
4. Inicie o servidor PHP: `cd /tmp; php -S localhost:8000 -t .`

## Web

1. Acesse <http://localhost:8000/aulas/lib/submissao/list.php?apostila=prova-funcional>. Troque `prova-funcional` pelo nome da apostila configurado no código-fonte da prova, em uma linha iniciada por `window.apostila = `.
2. Pegue os ids listados e coloque-os no arquivo `assets/submissao/submissao.js`, onde tem `respostaIds = `.
3. Troque os testes em `assets/submissao/submissao.js`, onde tem `officialTests = `.

## Correção

1. Acesse <http://localhost:8000/mata56/prova-lisp.html> (ou qualquer que seja a página da prova, servida pelo servidor PHP).
2. Clique no botão `>>` para avançar e `<<`.

