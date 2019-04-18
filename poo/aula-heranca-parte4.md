---
layout: page
title: Herança - parte 4
---

# Classes abstratas

**Classes abstratas** são classes que podem ser estendidas, mas não podem ser instanciadas. O oposto de classe abstrata é classe **concreta**.

Para declarar uma classe como abstrata, use a seguinte sintaxe:

```java
public abstract class NomeDaClasse {
    // OBS.: o public é opcional
}
```

Exercícios: 

- Crie uma classe abstrata e tente instanciá-la
- Agore cria uma subclasse concreta dessa classe e tente instanciá-la

---

# Classes abstratas

Classes abstratas geralmente representam um conjunto de dados ou funcionalidades incompletas, que precisam ser completados pelas subclasses. Exemplo:

<div class="uml">
abstract class Usuario {
    nome
    cpf
    dataNascimento
}
class Estudante extends Usuario {
    matriculaSiac
    curso
}
class Servidor extends Usuario {
    matriculaSiape
    unidadeLotacao
}
class Professor extends Servidor {
    turmas
}
class Terceirizado extends Usuario {
    empresa
}
class Visitante extends Usuario {
    responsavel
}
</div>

Nesse sistema, todos os usuários devem ser criados de acordo com sua categoria. Não é possível criar um `Usuario` genérico. No entanto, a classe `Usuario` existe para que as demais classes possam herdar seus atributos e métodos.

**UML**: Na notação UML, o nome das classes abstratas é escrito em *itálico*.

---

# Métodos abstratos

- Um método abstrato não possui implementação (corpo)
- Apenas classes abstratas podem possuir métodos abstratos
- A implementação dos métodos abstratos deve ser fornecida pelas subclasses concretas
- Exemplo:

```java
public abstract class MinhaClasse {
    public abstract void meuMetodo();
}
```

Note que não há chaves (`{}`), e sim ponto-e-vírgula (`;`).

---

# Exemplo

<div class="uml">
abstract class Animal {
    distanciaPercorrida

    andar()
    treinar()
    {abstract} fazerBarulho()

}
class Cachorro extends Animal {
    fazerBarulho()
}
class Gato extends Animal {
    fazerBarulho()
}
</div>

**UML**: Na notação UML, o nome dos métodos abstratos é escrito em *itálico*.

---

# Exemplo

```java
abstract class Animal {
    int distanciaPercorrida = 0;

    public abstract void fazerBarulho();

    public void andar() {
        distanciaPercorrida++;
    }

    public void treinar() {
        andar();
        fazerBarulho();
    }
}

class Cachorro extends Animal {
    public void fazerBarulho() {
        System.out.println("Au-au!");
    }
}

class Gato extends Animal {
    public void fazerBarulho() {
        System.out.println("Miau!");
    }
}

class Main {
    public static void main(String[] args) {
        Cachorro cao = new Cachorro();
        Gato gato = new Gato();
        cao.treinar();
        gato.treinar();
    }
}
```

Questões:

- Você reparou que `treinar()` chama um método abstrato, `fazerBarulho()`?
- O que aconteceria se o compilador nos deixasse instanciar `Animal` e tentássemos treinar esse animal?

---

# Métodos abstratos

Ao estender uma classe abstrata, é necessário implementar todos os seus métodos abstratos?

<p></p><p></p><p></p><p></p><p></p><p></p><p></p><p></p><p></p><p></p>

<!-- Não se a subclasse também for abstrata -->

---

# Exemplo

<div class="uml">
abstract class Forma {
    {abstract} getArea()
    {abstract} getPerimetro()
}
abstract class Quadrilatero extends Forma {
    largura
    altura

    getArea()
}
class Retangulo extends Quadrilatero {
    getPerimetro()
}
class Paralelogramo extends Quadrilatero {
    angulo

    getPerimetro()
}
</div>

As subclasses que não implementam todos os métodos abstratos da superclasse devem, necessariamente, ser abstratas.

Exercício: escreva o código para este exemplo.

---

# Interfaces

- E se levarmos essa ideia de métodos e classes abstratas ao extremo?
- E se criarmos uma classe em que todos os métodos são abstratos?
- Nesse caso obtemos o que chamamos de **interface**

---

# Interfaces

Exemplo de interface:

```java
public interface MinhaInterface {
    void metodoAbstrato1();
    int metodoAbstrato2();
    float metodoAbstrato3(String x, int y);
}
```

Todos os métodos declarados em uma interface são públicos e abstratos. (Você pode escrever `public abstract` na frente de um método, mas isso seria redundante.)

---

# Exemplo

```java
interface FonteSonora {
    void fazerBarulho();
}
class Gato implements FonteSonora {
    public void fazerBarulho() {
        System.out.println("Miau!");
    }
}
```

Note que:

- usa-se `extends` para fazer uma classe estender outra classe
- usa-se `implements` para fazer uma classe "estender" uma interface (o nome correto é **implementar uma interface**)

---

# Notação UML

Na notação UML, a notação para "implementar uma interface" é uma seta tracejada com um triângulo sem preenchimento na ponta:

<div class="uml">
interface FonteSonora {
    void fazerBarulho()
}
class Gato implements FonteSonora {
    void fazerBarulho()
}
</div>

---

# Para que servem interfaces?

- A herança tem dois propósitos: 
    - promover o reuso de atributos e métodos
    - estabelecer um contrato entre superclasses e subclasses
- Ou seja, quando criamos `Gato` como uma subclasse de `Animal`, sabemos que
    - `Gato` vai herdar os atributos e métodos de `Animal`, evitando esforço e duplicação de código
    - Tudo que um animal tem, um gato também tem. Tudo que um animal faz, um gato também faz. Assim, o gato pode ser usado em qualquer ponto onde se espera um animal. O gato ele segue a especificação de um animal, podendo ou não adicionar atributos ou métodos. 
- A interface serve para estabelecer um contrato entre diferentes classes (mas não promove o reuso de dados e operações, já que ela não os possui)

---

# Para que serve um plugue de tomada?

![]({{site.baseurl}}/poo/images/plugue.webp)

---

# Interfaces na vida real

- Para ligar um aparelho elétrico, deve-se conectá-lo a uma fonte de energia.
- Um exemplo clássico são as tomadas. Nelas pode-se conectar qualquer aparelho elétrico que possua um plugue compatível. Assim, o padrão NBR14136 (padrão brasileiro de tomadas) é como uma interface que define como devem ser os aparelhos elétricos (em particular, os seus plugues) que serão ligados nas tomadas brasileiras.
- Assim, a fonte de energia recebe um aparelho elétrico de forma a fornecer-lhe energia. A única exigência é que esse aparelho elétrico implemente a interface NBR14136. Não importa se é um ventilador, uma TV, uma torradeira...

---

# Interfaces na vida real

Ver também: <https://softwareengineering.stackexchange.com/a/108681/71375>

```java
class FonteDeEnergia110 {
    void forneceEnergia(AparelhoNBR14136 aparelho) {
        aparelho.forneceEnergiaNoPinoRedondo(110);
    }
}

interface AparelhoNBR14136 {
    void forneceEnergiaNoPinoRedondo(int voltagem);
}

class Torradeira implements AparelhoNBR14136 {
    public void forneceEnergiaNoPinoRedondo(int voltagem) {
        aumentaTemperatura(voltagem * 0.05);
    }
}

class Ventilador implements AparelhoNBR14136 {
    public void forneceEnergiaNoPinoRedondo(int voltagem) {
        giraMotor(voltagem * 3.14);
    }
}
```

---

# Interfaces na vida real

Exercício (avançado): considere agora uma fonte de energia projetado para funcionar com aparelhos elétricos que seguem o padrão NEMA (norte-americano):

```java
interface AparelhoNEMA {
    void forneceEnergiaNoPinoChato(int voltagem);
}
class FonteDeEnergiaNorteAmericana {
    void forneceEnergia(AparelhoNEMA aparelho) {
        aparelho.forneceEnergiaNoPinoChato(110);
    }
}
```

O que você deve fazer para ligar seu `Ventilador` (que implementa `AparelhoNBR14136`) nessa fonte? Implemente uma solução em Java.

---

# Herança de interfaces

Uma interface pode estender uma ou mais interfaces, podendo adicionar métodos. Exemplo:

```java
interface FonteSonora {
    void fazBarulho();
}
interface FonteSonoraRegulavel extends FonteSonora {
    void ajustaVolume(int volume);
}
class Radio implements FonteSonoraRegulavel {
    int frequencia;
    int potencia;

    public void fazBarulho() {
        toca(frequencia, potencia);
    }
    public void ajustaVolume(int volume) {
        potencia = Math.pow(10, volume);
    }
}
```

---

# Herança de interfaces

Outro exemplo:

```java
interface FonteSonora {
    void fazBarulho();
}
interface MeioDeTransporte() {
    void anda();
}
interface VeiculoDePasseio extends FonteSonora, MeioDeTransporte {
    void adicionaPessoa(Pessoa p);
}
```

---

# Implementação de múltiplas interfaces

Uma classe pode estender no máximo uma outra classe, mas **uma classe pode implementar várias interfaces**.

Exemplo:

```java
class Pessoa {
    String nome;
    String cpf;
}

interface Pagavel {
    void recebePagamento(double valor);
}
interface Promovivel {
    void promove();
}

class Servidor extends Pessoa implements Pagavel, Promovivel {
    int matriculaSiape;

    void recebePagamento(double valor) {
        // ...
    }
    void promove() {
        // ...
    }
}

class Terceirizado extends Pessoa implements Pagavel {
    void recebePagamento(double valor) {
        // ...
    }
    void promove() {
        // ...
    }
}

class FolhaDePagamento {
    ArrayList<Pagavel> pessoas;

    void pagarTodoMundo() {
        for (Pagavel p : pessoas) {
            p.recebePagamento(1000);
        }
    }
}
```

---

# Interfaces - recapitulando

Interfaces são estruturas semelhantes a classes abstratas, com algumas diferenças:

- São declaradas com a palavra-chave `interface` (e não `class`)
- Todos os seus métodos são abstratos
- Diz-se que uma classe *estende* outra classe, mas que uma classe *implementa* uma interface
- Uma classe pode estender no máximo uma classe, mas pode implementar *várias* interfaces

<!--
https://softwareengineering.stackexchange.com/questions/108240/why-are-interfaces-useful
-->

---

# Exemplo

A classe `TreeSet` implementa um conjunto ordenado de elementos. Ao criar um `TreeSet` usando o construtor sem parâmetros, os elementos de `TreeSet` obrigatoriamente precisam implementar a interface `Comparable` (tradução: Comparável) –- somente dessa forma o `TreeSet` pode determinar a ordem correta entre os elementos:

```java
public interface Comparable {
    /*
     * Retorna 0 se this é igual a obj
     * Retorna um número negativo se this for menor que obj
     * Retorna um número positivo se this for maior que obj
     */
    public int compareTo(Object obj);
}
```

---

# Exemplo

(Primeiro rode o código sem implementar Comparable e veja a mensagem de erro)

```java
package aula;

import java.util.TreeSet;

/* 
 * Ordena pessoas por RG e, se coincidirem,
 * por nome.
 */
public class AMain {
    public static void main(String[] args) {
        TreeSet<Pessoa> set = new TreeSet<>();
        
        set.add(new Pessoa(4, "Fulano"));
        set.add(new Pessoa(2, "Sicrana"));
        set.add(new Pessoa(5, "Beltrano"));
        set.add(new Pessoa(5, "Beltrana"));
        
        System.out.println(set);
    }
}

class Pessoa implements Comparable {
    int rg;
    String nome;
    public Pessoa(int rg, String nome) {
        super();
        this.rg = rg;
        this.nome = nome;
    }
    @Override
    public int compareTo(Object o) {
        Pessoa outra = (Pessoa)o;
        int diff = rg - outra.rg;
        return diff != 0 ? diff : nome.compareTo(outra.nome);
    }
    
    @Override
    public String toString() {
        return "" + rg + " - " + nome;
    }   
}
```

---

# Exemplo

Programa que cria uma janela e desenha formas geométricas que são desenháveis e movíveis (implementam duas interfaces)

<div class="uml">
class ExemploFormas {
    objetos : Collection&lt;Desenhavel&gt;
    ExemploFormas()
    desenhaObjetos()
    moveObjetos(dx, dy)
}
interface Desenhavel {
    desenha()
}
interface Movivel {
    desloca(dx, dy)
}
class Background implements Desenhavel {
    desenha()
}
class Retangulo implements Desenhavel, Movivel {
    x0
    y0
    largura
    altura

    desenha()
    desloca(dx, dy)
}
class Circulo implements Desenhavel, Movivel {
    xCentro
    yCentro
    raio

    desenha()
    desloca(dx, dy)
}
</div>

---

# Exemplo

```java
public class ExemploFormas {
    private Collection<Desenhavel> objetos = new ArrayList<>();

    public ExemploFormas() {
        objetos.add(new Background(LARGURA, ALTURA));
    }

    private void criaCirculo() {
        objetos.add(new Circulo(...));
    }

    private void criaRetangulo() {
        objetos.add(new Retangulo(...));
    }

    private void desenhaObjetos(Graphics g) {
        for (Desenhavel d : objetos) {
            d.desenha(g);
        }
    }
    
    private void moveObjetos(int dx, int dy) {
        for (Desenhavel d : objetos) {
            if (d instanceof Movivel) {
                ((Movivel) d).desloca(dx, dy);
            }
        }
    }
    // ...
}
```

<!-- 
package aula;

import java.awt.Color;
import java.awt.Dimension;
import java.awt.Graphics;
import java.awt.event.KeyEvent;
import java.awt.event.KeyListener;
import java.util.ArrayList;
import java.util.Collection;

import javax.swing.JFrame;
import javax.swing.JPanel;

public class ExemploFormas extends JPanel implements KeyListener {
    private Collection<Desenhavel> objetos = new ArrayList<>();
    public static final int LARGURA = 600;
    public static final int ALTURA = 600;

    public ExemploFormas() {
        objetos.add(new Background(LARGURA, ALTURA));
    }

    private void desenhaObjetos(Graphics g) {
        for (Desenhavel d : objetos) {
            d.desenha(g);
        }
    }

    private void moveObjetos(int dx, int dy) {
        for (Desenhavel d : objetos) {
            if (d instanceof Movivel) {
                ((Movivel) d).desloca(dx, dy);
            }
        }
    }

    private void criaCirculo() {
        objetos.add(new Circulo((int) (Math.random() * LARGURA), (int) (Math.random() * ALTURA),
                (int) (5 + Math.random() * 50)));
    }

    private void criaRetangulo() {
        objetos.add(new Retangulo((int) (Math.random() * LARGURA), (int) (Math.random() * ALTURA),
                (int) (5 + Math.random() * 50), (int) (5 + Math.random() * 50)));
    }

    @Override
    protected void paintComponent(Graphics g) {
        super.paintComponent(g);

        desenhaObjetos(g);
    }

    @Override
    public void keyTyped(KeyEvent e) {
        char keyChar = e.getKeyChar();

        if (keyChar == 27) {
            System.exit(1);
        } else if (keyChar == 'r') {
            criaRetangulo();
        } else if (keyChar == 'c') {
            criaCirculo();
        } else if (keyChar == 'a') {
            moveObjetos(-20, 0);
        } else if (keyChar == 'd') {
            moveObjetos(20, 0);
        } else if (keyChar == 'w') {
            moveObjetos(0, -20);
        } else if (keyChar == 's') {
            moveObjetos(0, 20);
        }
        this.repaint();
    }

    @Override
    public void keyPressed(KeyEvent e) {
    }

    @Override
    public void keyReleased(KeyEvent e) {
    }

    public static void main(String[] args) {
        JFrame frame = new JFrame();
        ExemploFormas panel = new ExemploFormas();
        panel.setPreferredSize(new Dimension(LARGURA, ALTURA));
        frame.add(panel);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.pack();
        frame.setLocationRelativeTo(null);
        frame.setVisible(true);
        frame.addKeyListener(panel);
    }
}

interface Desenhavel {
    void desenha(Graphics g);
}

interface Movivel {
    void desloca(int x, int y);
}

class Background implements Desenhavel {
    int largura;
    int altura;

    public Background(int largura, int altura) {
        super();
        this.largura = largura;
        this.altura = altura;
    }

    @Override
    public void desenha(Graphics g) {
        g.setColor(Color.WHITE);
        g.fillRect(0, 0, largura, altura);
        g.setColor(Color.LIGHT_GRAY);
        g.fillRect(0, 0, largura / 2, altura / 2);
        g.fillRect(largura / 2 + 1, altura / 2 + 1, largura / 2, altura / 2);
    }
}

class Circulo implements Desenhavel, Movivel {
    int xCentro;
    int yCentro;
    int raio;

    public Circulo(int x, int y, int raio) {
        super();
        this.xCentro = x;
        this.yCentro = y;
        this.raio = raio;
    }

    @Override
    public void desloca(int x, int y) {
        this.xCentro += x;
        this.yCentro += y;
    }

    @Override
    public void desenha(Graphics g) {
        g.setColor(Color.MAGENTA);
        g.fillOval(xCentro - raio / 2, yCentro - raio / 2, raio * 2, raio * 2);
    }
}

class Retangulo implements Desenhavel, Movivel {
    int x0;
    int y0;
    int largura;
    int altura;

    public Retangulo(int x, int y, int largura, int altura) {
        super();
        this.x0 = x;
        this.y0 = y;
        this.largura = largura;
        this.altura = altura;
    }

    @Override
    public void desloca(int x, int y) {
        this.x0 += x;
        this.y0 += y;
    }

    @Override
    public void desenha(Graphics g) {
        g.setColor(Color.BLUE);
        g.fillRect(x0, y0, largura, altura);
    }
}
 -->

---

# Exemplo

Collection é uma interface, 

<div class="uml">
interface Collection {
    add(e)
    remove(e)
    contains(e)
    size(e)
}
interface Set extends Collection {
}
interface List extends Collection {
    get(i)
    indexOf(e)
}
interface Queue extends Collection {
    peek()
    poll()
}
abstract class AbstractList extends List {
}
class ArrayList extends AbstractList {
}
class Vector extends AbstractList {
}
abstract class AbstractSet implements Set {
}
class HashSet extends AbstractSet {
}
interface SortedSet extends Set {
}
interface NavigableSet extends SortedSet {
}
class TreeSet implements NavigableSet {
}
</div>