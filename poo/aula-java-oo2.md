---
layout: remark
title: "Java: orientação a objetos"
---

<!-- TODO:
definir conceito de instância
 -->

<div>

# Conceitos

---

# Programação procedural

Um programa **procedural** consiste de **funções** (ou procedimentos) que **chamam** outras funções, podendo passar parâmetros e receber valores de retorno

Exemplo (pseudocódigo):

```java
int main() {
    Retangulo r;
    // ...
    // chama a função calculaArea passando 
    // como parâmetro o retângulo r
*   double area = calculaArea(r);
}
```

---

# Programação orientada a objetos

Um programa **orientado a objetos** consiste de **objetos** que se comunicam com outros objetos através de **mensagens**

- Uma mensagem pode incluir outros objetos como **parâmetros** e pode **retornar** um objeto
- Ao receber uma mensagem, um objeto **executa** algum código
  - Possivelmente, envia mensagens para outros objetos
- Todo objeto possui um tipo (denominado **classe**)
- Todos os objetos do **mesmo tipo** respondem às mesmas mensagens
- Objetos podem guardar informações em variáveis denominadas **atributos**, e todos os objetos do mesmo tipo possuem os mesmos atributos
- Normalmente os objetos não acessam atributos de outros objetos diretamente, e sim através de mensagens
  - Ex.: um objeto `joao`, da classe `Usuario`, possui os atributos `nome` e `senha`, que são inacessíveis por objetos de outras classes, mas ele responde à mensagem `obterNome`, que retorna o nome; não há mensagem `obterSenha`

---

# Programação orientada a objetos

Exemplo:

```java
int main() {
    Retangulo r;
    // Envia a mensagem "calculaArea" para o
    // objeto r, do tipo Retangulo.
*   double area = r.calculaArea();
}
```

> Cada retângulo é responsável por calcular sua própria área


---

<!-- TODO: exemplo do calculo da idade? -->

# Exemplo: equipe de atletas

- Um sistema permite gerenciar uma equipe de atletas e imprimir, para cada atleta, o seu nome, altura, peso e IMC (índice de massa corporal), que é calculado a partir da altura e peso.
- Usando orientação a objetos, cada atleta será representado por um objeto, e a equipe de atletas também será um objeto.

<div class="uml">
object equipe {
    atletas = [...]
}
object fulano {
    nome = "Fulano"
    altura = 1.85
    peso = 75
}
object sicrana {
    nome = "Sicrana"
    altura = 1.87
    peso = 77
}
equipe --> fulano
equipe --> sicrana
</div>

- O objeto `equipe` responde à mensagem `imprimir` realizando a impressão das informações dos atletas
- O objeto `equipe` responde à mensagem `adicionarAtleta`, que recebe um atleta, e adiciona esse atleta à equipe
- Os objetos `fulano` e `sicrana` respondem às mensagens `obterNome`, `obterAltura`, `obterPeso` e `obterIMC`

---

# Exemplo: equipe de atletas

Um programa orientado a objetos para imprimir informações sobre Fulano e Sicrano seria mais ou menos assim:

- O programa cria um objeto `fulano`, da classe `Atleta`, com nome Fulano, altura 1.85 e peso 75
- O programa cria um objeto `sicrana`, da classe `Atleta`, com nome Sicrana, altura 1.87 e peso 77
- O programa cria um objeto `equipe`, da classe `Equipe`
- O programa envia à equipe a mensagem `adicionarAtleta`, passando o objeto `fulano`
- O programa envia à equipe a mensagem `adicionarAtleta`, passando o objeto `sicrana`
- O programa envia à equipe a mensagem `imprimir`
- `equipe` envia a `fulano` as mensagens `obterNome`, `obterAltura`, `obterPeso` e `obterIMC`
  - `equipe` cria um objeto `s`, da classe `String`, combinando as informações recebidas nas mensagens enviadas a `fulano`
  - `equipe` envia ao objeto `output` a mensagem `print` passando o objeto `s`
- Idem para `sicrana`

---

# Exemplo: termômetro e ar condicionado

- Um `termômetro` é um objeto da classe `Sensor`. Mensagens:
  - `atualizarMedida`: mede a temperatura do ambiente e guarda na memória
  - `obterMedida`: retorna a última medição lida
- Uma `tomadaInteligente` é um objeto da classe `Tomada`, que possui um sensor e um aparelho elétrico; ao ser criado, recebe uma `medidaMaxima`. Mensagens:
  - `atualizar`: obtém uma nova medida do sensor e, se estiver acima da `medidaMaxima`, liga o aparelho elétrico
- Um `arCondicionado` é um objeto da classe `AparelhoEletrico`. Mensagens:
  - `ligar`
  - `desligar`

Como seria um programa orientado a objetos para ligar e desligar automaticamente o ar condicionado com base na temperatura? Simule a execução do programa com mais dois colegas, cada um representando um objeto.

---

class: middle, inverse, center

# Java: usando objetos

---

# Java: Criando um objeto

- Para criar um objeto do tipo `T`, usa-se `new T()`
  - Ou, de forma mais completa, `new T(pâmetro1, parâmetro2, ...)`
- Exemplo com `StringBuffer` -- tipo de string em Java (veja a [documentação](https://docs.oracle.com/javase/7/docs/api/java/lang/StringBuffer.html)):

```java
// Cria um objeto do tipo StringBuffer e atribui à variável `x`:
StringBuffer x = new StringBuffer();
// Cria mais dois objetos, desta vez com um parâmetro
StringBuffer nome = new StringBuffer("Fulano");
StringBuffer sobrenome = new StringBuffer(" de Tal");
```

<div class="uml">
object x {
    valor = ""
}
object nome {
    valor = "Fulano"
}
object sobrenome {
    valor = " de Tal"
}
</div>

---

# Enviando mensagens para um objeto

- Para enviar uma mensagem para um objeto, use `objeto.nomeDaMensagem(parâmetro1, parâmetro2, ...)`. Exemplo:

```java
// Pede para o objeto nome se inverter
nome.reverse();
// Pede para o objeto x adicionar o objeto nome ao final
x.append(nome);
// ... idem para sobrenome
x.append(sobrenome);
// Pede para o objeto x retornar o seu tamanho
int tam = x.length();
```

- Note que `nome`, `sobrenome`, `x` e qualquer outro objeto do tipo `StringBuffer` responde às mensagens `reverse()`, `append()`, dentre [outras](https://docs.oracle.com/javase/7/docs/api/java/lang/StringBuffer.html)

<div class="uml">
object nome {
    valor = "onaluF"
}
object sobrenome {
    valor = " de Tal"
}
object x {
    valor = "onaluF de Tal"
}
object tam {
    valor = 13
}
</div>

---

# Outro exemplo

- A classe [`Pair`](https://docs.oracle.com/javase/8/javafx/api/javafx/util/Pair.html) representa um par de objetos, denominados chave e valor (*key* e *value*)

```java
String k = new String("nome");
String v = new String("Fulano");
Pair p = new Pair(k, v);
String nome = p.getValue();
```

O objeto `p` possui dois atributos, `key` e `value`, cujos valores são, respectivamente, os objetos `k` e `v`; além disso, ele responde à mensagem `getValue()`.

<div class="uml">
object k {
    valor = "nome"
}
object v {
    valor = "Fulano"
}
object p {
    key = k
    value = v
}
object nome {
    valor = v
}
p --> k : key
p --> v : value
nome --> v
</div>

---

class: middle, inverse, center

# Java: definindo classes

---

# Especificando objetos

- Como especificar quais são as mensagens às quais cada objeto responde, e o que eles fazem ao receber cada mensagem?
- Através de uma **classe**. Lembre-se:
  - Todo objeto pertence a uma classe
  - Todos os objetos de uma mesma classe respondem às mesmas **mensagens**
  - Todos os objetos de uma mesma classe possuem os mesmos **atributos**

---

# Exemplo: retângulo

Objetos da classe `Retangulo` respondem às seguintes mensagens:

- `definirDimensoes(a, l)` - define altura (`a`) e largura (`l`) do retângulo
- `obterAltura()` - retorna a altura do retângulo
- `obterLargura()` - retorna a largura do retângulo
- `obterArea()` - retorna a área do retângulo (largura * altura)
- `ehMaiorQue(r)` - indica se o retângulo é maior que outro retângulo, `r` 

Para isso, eles guardam duas informações: largura e altura

Criaremos uma classe `Retangulo` os **atributos** `largura` e `altura` e um **método** para cada mensagem a ser respondida.

---

# Exemplo: retângulo

```java
public class Retangulo {
    private double altura;
    private double largura;

    public void definirDimensoes(double a, double l) {
       altura = a;
       largura = l;
    }
    public double obterAltura() {
        return altura;
    }
    public double obterLargura() {
        return largura;
    }
    public double obterArea() {
        return largura * altura;
    }
    public boolean ehMaiorQue(Retangulo outro) {
        return obterArea() > outro.obterArea();
    }
}
```

---

# Exemplo: retângulo

Exemplo de uso:

```java
public class Programa {
    public static void main(String[] args) {
        // Cria o objeto r, da classe Retangulo
        Retangulo r = new Retangulo();
        // Envia a mensagem "definirAltura" ao objeto r, passando 5 e 7 como parâmetros.
        // Também se diz: chama o método "definirAltura" no objeto r
        r.definirDimensoes(5, 7);

        // Idem para o objeto s
        Retangulo s = new Retangulo();
        s.definirDimensoes(4, 6);

        System.out.println(r.obterArea())
        System.out.println(s.obterArea())
        System.out.println(r.ehMaiorQue(s))
    }
}
```

---

# Exemplo: retângulo

Obervações:

- A classe `Retangulo` **define os métodos** `definirDimensoes`, `obterAltura`, `obterLargura`, `obterArea`
- Os objetos da classe `Retangulo` **respondem às mensagens** `definirDimensoes` etc., executando os métodos respectivos da classe
- Os métodos podem **acessar os atributos** do objeto que recebeu a mensagem
- Os atributos são declarados como **privados**
  - Eles só podem ser acessados por objetos da classe `Retangulo`
- Os métodos são declarados como **públicos**
  - Eles podem ser chamados por objetos de qualquer classe
- Ao criar um retângulo, não é possível definir apenas a altura ou apenas a largura; é necessário passar ambos

---

# Visualizando a execução do programa

Use <http://www.pythontutor.com/java.html#mode=display>

Conceitualmente, a chama de um método é similar à chamada de uma função, com a diferença de que o método recebe um parâmetro implícito, chamado `this`

---

# Exemplo: equipe de atletas

<div class="uml">
skinparam class {
  backgroundColor White
  borderColor black
}
class Equipe {
    atletas : Atleta[]
    imprimir()
    adicionarAtleta(a)
}
class Atleta {
    nome : String
    altura : double
    peso : double
    obterNome() : String
    obterAltura() : double
    obterPeso() : double
    obterIMC() : double
}
note right of Atleta : obterIMC() {\n  return peso / altura²\n}
object equipe {
    atletas = [...]
}
object fulano {
    nome = "Fulano"
    altura = 1.85
    peso = 75
}
object sicrana {
    nome = "Sicrana"
    altura = 1.87
    peso = 77
}
Equipe .. equipe
Atleta .. fulano
Atleta .. sicrana
</div>

- Cada classe especifica os **atributos** que os seus objetos guardam
  - Cada objeto de uma classe pode guardar **valores** diferentes em seus atributos
- Cada classe especifica as **mensagens** às quais os seus objetos respondem
  - As mensagens são especificadas através de **métodos** (equivalentes a **funções**)

---

# Exemplo: termômetro e ar condicionado

<div class="uml">
skinparam class {
  backgroundColor White
  borderColor black
}

class Sensor {
    medida : double
    atualizarMedida()
    obterMedida() : double
}
class Tomada {
    sensor : Sensor
    aparelho : AparelhoEletrico
    conectarSensor(s: Sensor)
    conectarAparelho(a: Aparelho)
    atualizar()
}
class AparelhoEletrico {
    estaLigado : boolean
    ligar();
    desligar();
}
object termômetro {
    medida = 27.3
}
object tomadaInteligente {
    sensor = termômetro
    aparelho = arCondicionado
}
object arCondicionado {
    estaLigado = false
}
object televisao {
    estaLigado = true
}
Sensor .. termômetro
Tomada .. tomadaInteligente
AparelhoEletrico .. arCondicionado
AparelhoEletrico .. televisao
</div>

---

# Definindo classes em Java

Programa principal:

```java
public class Programa {
    public static void main(String[] args) {
        Tomada tomada = new Tomada();
        Sensor termometro = new Sensor();
        AparelhoEletrico arCondicionado = new AparelhoEletrico();

        tomada.conectarAparelho(arCondicionado);
        tomada.conectarSensor(termometro);

        while (true) {
            tomada.atualizar();
        }
    }
}
```

---

# Definindo classes em Java

```java
public class Sensor {
    private double medida;

    public void atualizarMedida() {
        medida = Math.random() * 27;
    }
    public double obterMedida() {
        return medida;
    }
}
```

---

# Definindo classes em Java

```java
public class AparelhoEletrico {
    private boolean estaLigado = false;

    public void ligar() {
        estaLigado = true;
    }
    public void desligar() {
        estaLigado = false;
    }
}
```

---

# Definindo classes em Java

```java
public class Tomada {
    private Sensor sensor;
    private AparelhoEletrico aparelho;

    public void conectarSensor(Sensor s) {
        sensor = s;
    }

    public void conectarAparelho(Aparelho a) {
        aparelho = a;
    }

    public void atualizar() {
        sensor.atualizarMedida();
        double medida = sensor.obterMedida();
        if (medida < 25.0) {
            aparelho.desligar();
        } else {
            aparelho.ligar();
        }
    }
}
```

</div>
