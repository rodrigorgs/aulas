---
layout: triple-page
title: Exercício da Batalha Pokémon
features: [code, python]
---

## Batalha Pokémon

Para essas questões, você deverá baixar o projeto [tupy-samples](https://github.com/rodrigorgs/tupy-samples/archive/refs/heads/master.zip) e então executar o script localizado em `pokemon/batalha-pokemon.py`.

Responda às questões apenas com o uso do ambiente Tupy; NÃO responda com base no código-fonte do script.

## Qual a classe do objeto pikachu?

Modifique o código ao lado para que ele retorne o nome da classe do objeto referenciado pela variável `pikachu`

<textarea class="code lang-python">
def resposta():
  return "NomeDaClasse"
</textarea>

<div class="testcode">
assert resposta() == "Pokemon", "Resposta errada"
</div>

## Quais são os atributos presentes no objeto pikachu?

Retorne um conjunto de strings com os nomes dos atributos do objeto referenciado pela variável `pikachu`.

Exemplo:

```python
def resposta():
  return {"peso", "altura"}
```

<textarea class="code lang-python">
def resposta():
  return {
    "abc",
    "def",
    # ...
  }
</textarea>

<div class="testcode">
assert resposta() == {"angle", "file", "forca", "vida", "x", "y"}, "Resposta errada"
</div>

## Quais são os valores iniciais dos atributos de pikachu?

Retorne um dicionário, cuja chave é o nome de um atributo, e o valor é o valor inicial desse atributo.

<textarea class="code lang-python">
def resposta():
  return {
    "atributo1": 5.0,
    "atributo2": "alguma string",
    # ...
  }
</textarea>

<div class="testcode">
assert resposta() == {
  "angle": 0,
  "file": "pikachu.png",
  "forca": 30,
  "vida": 100,
  "x": 200.0,
  "y": 300.0}, "Resposta errada"
</div>

## Quais são os métodos da pokeball?

Retorne um conjunto de strings com os nomes dos métodos da classe Pokeball.

<textarea class="code lang-python">
def resposta():
  return { "metodo1", "metodo2" }
</textarea>

<div class="testcode">
assert resposta() == {"destroy", "joga"}, "Resposta errada"
</div>

## Quais são as classes dos objetos referenciados pelas variáveis globais?

Considere as variáveis globais do ambiente. Retorne um conjunto de strings com os nomes das classes dos objetos referenciados por essas variáveis.

<textarea class="code lang-python">
def resposta():
  return { "Classe1", "Classe2" }
</textarea>

<div class="testcode">
assert resposta() == {"Campo", "Pokemon", "Pokeball"}, "Resposta errada"
</div>

## Quais atributos são modificados pelo método evolui da classe Pokemon?

Retorne um conjunto de strings com os nomes dos atributos que são modificados pelo método evolui da classe Pokemon.

<textarea class="code lang-python">
def resposta():
  return { "atributo1", "atributo2" }
</textarea>

<div class="testcode">
assert resposta() == {"file", "forca", "vida"}, "Resposta errada"
</div>

## Identifique o nome de um método da classe Pokemon que retorna True ou False

<textarea class="code lang-python">
def resposta():
  return "metodo1"
</textarea>

<div class="testcode">
assert resposta() == "pode_ser_capturado", "Resposta errada"
</div>

## Quais métodos da classe Pokemon recebem parâmetros?

Retorne um conjunto de strings com os nomes dos métodos da classe `Pokemon` que recebem parâmetros.

<textarea class="code lang-python">
def resposta():
  return { "método1", "método2" }
</textarea>

<div class="testcode">
assert resposta() == {"ataca", "recebe_dano"}, "Resposta errada"
</div>

## Objetos de qual ou quais classes podem receber dano?

Retorne um conjunto de strings com os nomes das classes cujos objetos podem receber dano.

<textarea class="code lang-python">
def resposta():
  return { "Classe1", "Classe2" }
</textarea>

<div class="testcode">
assert resposta() == {"Pokemon"}, "Resposta errada"
</div>

## Crie uma nova pokeball. Use-a para capturar um pokemon.

Você fez o que foi pedido? Responda sim ou não.

<textarea class="code lang-python">
def resposta():
  return "talvez"
</textarea>

<div class="testcode">
assert resposta() == "sim", "Resposta errada"
</div>

## Crie um novo pókemon a partir da imagem 'bulbasaur.png'. Ele possui os mesmos métodos dos objetos referenciados pelas variáveis pikachu e charmander?

Responda sim ou não.

<textarea class="code lang-python">
def resposta():
  return "talvez"
</textarea>

<div class="testcode">
assert resposta() == "sim", "Resposta errada"
</div>

## Qual o mínimo de ataques que um pokemon precisa desferir para fazer outro pokemon desmaiar?

Considere o melhor cenário possível: o pokémon mais forte atacando o pokémon mais fraco, sem sofrer dano.

<textarea class="code lang-python">
def resposta():
  return 50
</textarea>

<div class="testcode">
assert resposta() == 2, "Resposta errada"
</div>

## É possível capturar um pokemon desmaiado?

Responda sim ou não.

<textarea class="code lang-python">
def resposta():
  return "talvez"
</textarea>

<div class="testcode">
assert resposta() == "não", "Resposta errada"
</div>
