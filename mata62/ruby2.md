---
layout: page
title:  "Ruby - parte 2"
date:   2016-11-30 20:20:00 -0300
---

## Módulos

Um módulo é uma coleção de métodos e constantes. É como uma classe que não pode ser instanciada.

{:.editor}

```ruby
module Geometria
  PI = 3.141592

  def self.area_circulo(r)
    2 * PI * r
  end
end

puts Geometria.area_circulo(5)
puts Geometria::PI
```

Módulos podem ser usados como *mixins*. *Mixin* é um módulo que contém métodos e constantes que podem ser incluídos em outros módulos ou classes. Exemplo:

{:.editor}

```ruby
# O módulo abaixo não faz sentido sozinho;
# ele será usado como mixin
module NomeUtils
  def nome_completo
    "#{@nome} #{@sobrenome}"
  end
end

class Pessoa
  include NomeUtils
  def initialize(nome, sobrenome)
    @nome = nome
    @sobrenome = sobrenome
  end
end

x = Pessoa.new('joao', 'silva')
puts x.nome_completo
```

## Mexendo com arrays

Ruby já vem com vários métodos para manipular arrays. Alguns exemplos:

{:.editor}

```ruby
x = [6, 4, 8, 2, 6]
p x + [10]
p x[0..2]
p x.first
p x.last
p x.size
p x.max
p x.min
p x.reverse
p x.sort
p x.uniq
p x.include?(4)
puts x.join(" | ")
```

### Enumerable

Olhe a [documentação da classe Array](https://ruby-doc.org/core-2.3.3/Array.html). Onde estão definidos os métodos `min` e `max`? Esses métodos estão definidos no módulo `Enumerable`, que é incluído em Array como um *mixin*. Veja a [documentação do módulo Enumerable](https://ruby-doc.org/core-2.3.3/Enumerable.html). Outra classe que inclui `Enumerable` é a classe [Hash](https://ruby-doc.org/core-2.3.3/Hash.html).

### Arrays de strings

Você pode usar `%w(...)` para criar um array de palavras separadas por espaços:

{:.editor}

```ruby
array = %w(abacaxi banana caju damasco)
p array
```

### Métodos que recebem blocos

Alguns métodos de Array (ou de Enumerable) recebem blocos que são executados para cada elemento do array. Exemplos:

{:.editor}

```ruby
# Transformar cada elemento com map
array = [1, 2, 3, 4]
p array.map { |x| x * 2 }  # => [2, 4, 6, 8]

# Filtrar elementos
filtrado = array.select { |x| x % 2 == 0 }
p filtrado    # => [2, 4]

# Checar se algum elemento satisfaz à condição
puts array.any? { |x| x > 5 }  # => false

# Simplesmente executa o bloco para cada elemento
array.each do |x|
  puts "=> #{x}"
end

# Combinando várias coisas
array
  .reverse
  .map { |x| x * 3 }
  .select { |x| x < 10 }
  .each { |x| puts x }
```

## Diversos

Em Ruby, `false` e `nil` são expressões falsas, e qualquer outra coisa é uma expressão verdadeira"

{:.editor}

```ruby
puts 1 if false
puts 2 if nil
puts 3 if true
puts 4 if 0
puts 5 if 999
puts 6 if "alo"
```

Isso é útil para inicializar objetos:

{:.editor}

```ruby
x = nil
x = 1 if rand < 0.5
x = 2 if x.nil?
```

A última linha pode ser escrita de várias formas:

```ruby
x = x || 2   # só atribui 2 se x for nil
x ||= 2      # abreviação do de cima
```

Você vai encontrar o `||=` sendo usado em muitos programas em Ruby.

## Expressões regulares

Expressões regulares são sequências de caracteres que definem padrões de busca em strings. Expressões regulares são geralmente usadas para verificar se uma string segue um formato determinado (ex.: e-mail, número de telefone), para encontrar informações dentro de uma string (ex.: extrair o DDD de um telefone) ou substituir partes de string que seguem um padrão. Exemplos:

{:.editor}

```ruby
# Verificação
x = '555-1234'
if /\d\d\d-\d\d\d\d/.match(x)
  puts 'É um telefone'
end

# Forma equivalente
if /\d\d\d-\d\d\d\d/ =~ x
  puts 'É um telefone'
end

# Extração de informações
x = '<b>oi mundo</b>'
if %r{<b>(.*?)</b>}.match(x)
  puts "Texto interno: " + $1
end

# Substituição
x = "texto   com  muitos  espaços"
puts x.gsub(/  +/, ' ')

# Split
x = "um, dois,  tres,quatro"
array = x.split(/, */)
p array
```

Você pode usar o site <http://rubular.com/> para testar suas expressões regulares.

Um bom guia em português de expressões regulares é o [Expressões Regulares - Guia de Consulta Rápida](http://aurelio.net/regex/guia/).

<!-- 
## Metaprogramação

Em Ruby é fácil escrever um programa que obtém informações sobre os elementos dele mesmo (variáveis, constantes, classes, métodos etc.) e até mesmo modifica a si próprio. Isso é chamado *metaprogramação*.

method_missing.
-->