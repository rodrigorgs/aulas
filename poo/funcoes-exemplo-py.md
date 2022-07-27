---
layout: page
title: Funções - exemplo mais completo
features: [code, python, uml]
---

## Um sistema acadêmico

Imagine que queremos criar um sistema acadêmico segundo a seguinte **especificação**:

> O sistema permite **cadastrar no histórico do aluno as disciplinas cursadas e suas notas**, **imprimir o histórico** de um aluno (com listas de disciplinas e notas, bem como média geral), bem como **indicar se o aluno pode se formar**. O diploma só deve ser concedido a alunos com média geral igual ou superior a 5.0, e que tenham obtido na disciplina TCC nota igual ou superior a 7.0. Uma disciplina pode ser cursada várias vezes.

Vamos usar funções para escrever um programa organizado e fácil de compreender. Então, vamos começar identificando as ações que o sistema tem que realizar; cada ação vai virar uma função. A partir daí podemos identificar as seguintes funções a serem implementadas:

- `cadastrar_nota(historico, disciplina, nota)`: cadastra disciplina e nota em um determinado histórico
- `imprimir_historico(historico)`: imprime disciplina e notas do histórico, bem como a média geral
- `pode_se_formar(historico)`: indica se o aluno pode se formar a partir da análise do histórico

A partir daí vamos implementar as funções. Enquanto implementamos, podemos identificar novas funções que podem ser implementadas para tornar o código mais legível.

### Cadastrar nota

Primeiro, temos que decidir como vamos representar o histórico. Uma forma simples é como uma lista de itens, onde cada item é uma lista contendo nome da disciplina e nota. Algo assim:

```python
historico_fulano = [
  ["ILP": 8.3],
  ["POO": 9.5],
  ["TCC": 2.0],
  ["TCC": 7.0]
]
```

A partir daí podemos definir a função `cadastrar_nota`:

```python
def cadastrar_nota(historico, disciplina, nota):
  historico.append([disciplina, nota])
```

Tão simples que pode parecer que não vale a pena criar uma função só para isso. Mas criar a função possui  vantagens:

- Um programa que chama `cadastrar_nota(h, "POO", 9.5)` é mais fácil de entender do que um programa que chama `h.append(["POO", 9.5])`. A *intenção* fica muito mais clara.
- Se quisermos mudar a forma como representamos o histórico (por exemplo, usando dicionários), basta alterar a função `cadastrar_nota`. Se vários pontos do programa chamam `cadastrar_nota`, todos eles já passariam a funcionar com a nova representação. Do contrário, se não criássemos a função, seria necessário modificar vários pontos do programa para adaptar à nova representação.
- A mesma coisa se quisermos mudar alguma coisa na especificação; por exemplo, podemos exigir que cada disciplina seja cursada somente uma vez.

### Imprimir histórico

Antes de implementar `imprimir_historico`, vamos pensar sobre sua especificação. Essa função deve imprimir duas coisas:

- a lista de disciplinas com notas
- a média geral

Podemos, portanto, implementá-la assim:

```python
def imprimir_historico(historico):
  imprimir_notas(historico)
  imprimir_media_geral(historico)
```

Aqui estamos usando a técnica de **refinamentos sucessivos**, dividindo um problema complexo (imprimir um histórico) em problemas mais simples (imprimir uma lista de notas, imprimir uma média)

Agora é preciso implementar as novas funções:

```python
def imprimir_notas(historico):
  for item in historico:
    disciplina = item[0]
    nota = item[1]
    print(disciplina, "- nota", nota)
```

```python
def imprimir_media_geral(historico):
  media = 0
  for item in historico:
    nota = item[1]
    media = media + nota
  media = media / len(historico)
  print("Média geral:", media)
```

Agora nossa função `imprimir_historico` já está pronta para ser usada.

### Determinar se aluno pode ser formar

Por fim, a função `pode_se_formar` pode ser assim escrita:

```python
def pode_se_formar(historico):
  media = calcular_media_geral(historico)
  maior_nota_de_tcc = calcular_maior_nota(historico, "TCC")
  return media >= 5.0 and maior_nota_de_tcc >= 7.0
```

Agora só precisamos implementar as funções `calcular_media_geral(historico)` e `calcular_maior_nota(historico, disciplina)`.

Mas espere! Já estamos calculando a média geral dentro da função `imprimir_media_geral`! No entanto, não podemos chamar essa função, porque ela não *retorna* a média, apenas a imprime. 

Caímos no erro de criar uma função tagarela, e por isso não conseguimos reusá-la aqui. Mas não tem problema; é normal só percebermos como melhorar o nosso código à medida que vamos escrevendo novas funções. Vamos então começar definindo a função `calcular_media_geral(historico)` e então re-escrever `imprimir_media_geral` para usar essa função:

```python
def calcular_media_geral(historico):
  media = 0
  for item in historico:
    nota = item[1]
    media = media + nota
  media = media / len(historico)
  return media

def imprimir_media_geral(historico):
  media = calcular_media_geral(historico)
  print("Média geral:", media)
```

> Re-escrever parte de um programa para torná-lo mais fácil de entender ou modificar sem, no entanto, mudar o que o programa faz é chamado de **refatoração**

Agora só falta definir `calcular_maior_nota`:

```python
def calcular_maior_nota(historico, disciplina):
  maior_nota = 0.0
  for item in historico:
    disciplina = item[0]
    nota = item[1]
    if disciplina == "TCC" and nota > maior_nota:
      maior_nota = nota
  return maior_nota
```

### Diagrama de chamadas entre funções

Podemos representar em um diagrama quais funções chamam quais:

<div class="uml">
@startdot
digraph G {
  subgraph top_level {
    rank = "same"
    cadastrar_nota
    imprimir_historico
    pode_se_formar
  }
  cadastrar_nota
  imprimir_historico -> imprimir_notas
  imprimir_historico -> imprimir_media_geral
  imprimir_media_geral -> calcular_media_geral
  pode_se_formar -> calcular_media_geral
  pode_se_formar -> calcular_maior_nota
}
@enddot
</div>

Dividir o programa em funções, além de deixá-lo mais organizado e fácil de entender, evita duplicação de código. Basta ver que `calcular_media_geral` é chamada por duas funções diferentes.

## Funções de entrada/saída

A lógica do nosso programa está totalmente implementada. Se quisermos, podemos criar funções adicionais só para cuidar da interação com o usuário. Aqui está um exemplo de programa completo:

<textarea class="code lang-python">
def cadastrar_nota(historico, disciplina, nota):
  historico.append([disciplina, nota])

def imprimir_historico(historico):
  imprimir_notas(historico)
  imprimir_media_geral(historico)

def imprimir_notas(historico):
  for item in historico:
    disciplina = item[0]
    nota = item[1]
    print(disciplina, "- nota", nota)

def calcular_media_geral(historico):
  media = 0
  for item in historico:
    nota = item[1]
    media = media + nota
  media = media / len(historico)
  return media

def imprimir_media_geral(historico):
  media = calcular_media_geral(historico)
  print("Média geral:", media)

def pode_se_formar(historico):
  media = calcular_media_geral(historico)
  maior_nota_de_tcc = calcular_maior_nota(historico, "TCC")
  return media >= 5.0 and maior_nota_de_tcc >= 7.0

def calcular_maior_nota(historico, disciplina):
  maior_nota = 0.0
  for item in historico:
    disciplina = item[0]
    nota = item[1]
    if disciplina == "TCC" and nota > maior_nota:
      maior_nota = nota
  return maior_nota

def menu():
  opcao = 0
  hist = []

  while opcao != 4:
    print()
    print("Escolha uma opção:")
    print("1. Cadastrar nota")
    print("2. Imprimir histórico")
    print("3. Verificar se pode se formar")
    print("4. Sair")
    
    opcao = input_opcao(1, 4)
    if opcao == 1:
      tela_cadastrar_nota(hist)
    elif opcao == 2:
      tela_imprimir_historico(hist)
    elif opcao == 3:
      tela_pode_se_formar(hist)

def input_opcao(minimo, maximo):
  num = int(input())
  while num < minimo or num > maximo:
    print("Opção inválida. Digite um número entre", minimo, "e", maximo)
    num = int(input())
  return num

def input_float(minimo, maximo):
  num = float(input())
  while num < minimo or num > maximo:
    print("Valor inválido. Digite um número entre", minimo, "e", maximo)
    num = float(input())
  return num  

def tela_cadastrar_nota(historico):
  print("Digite nome da disciplina")
  disciplina = input()
  print("Digite nota da disciplina", disciplina)
  nota = input_float(0.0, 10.0)
  cadastrar_nota(historico, disciplina, nota)
  print("Cadastro realizado.")

def tela_imprimir_historico(historico):
  print("Histórico:")
  imprimir_historico(historico)

def tela_pode_se_formar(historico):
  if pode_se_formar(historico):
    print("O aluno pode se formar.")
  else:
    print("O aluno ainda não pode se formar.")

# Programa principal
menu()
</textarea>

Aqui o diagrama de chamadas de funções para entender melhor como o programa está organizado:

<div class="uml">
@startdot
digraph G {
  rankdir=LR
  subgraph cluster_ui {
    label = "Interface com o usuário"
    menu -> tela_cadastrar_nota
    menu -> tela_imprimir_historico
    menu -> tela_pode_se_formar
    menu -> input_opcao
    tela_cadastrar_nota -> input_float
    
    subgraph inputs {
      rank = "same"
      input_opcao
      input_float
    }
  }

  subgraph cluster_logica {
    label = "Lógica do sistema"
    subgraph top_level {
      rank = "same"
      cadastrar_nota
      imprimir_historico
      pode_se_formar
    }

    imprimir_historico -> imprimir_notas
    imprimir_historico -> imprimir_media_geral
    imprimir_media_geral -> calcular_media_geral
    pode_se_formar -> calcular_media_geral
    pode_se_formar -> calcular_maior_nota
  }

  tela_cadastrar_nota -> cadastrar_nota
  tela_pode_se_formar -> pode_se_formar
  tela_imprimir_historico -> imprimir_historico
}
@enddot
</div>

## Desafio

Altere o programa para permitir gerenciar históricos de vários alunos.
