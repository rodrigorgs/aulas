---
layout: page
title: Classes internas
---

# Classes internas

É possível definir uma classe dentro de outra classe; isso é o que chamamos de **classe interna**:

```java
public class ClasseExterna {
  int x;

  class ClasseInterna {
    int y;
  }
}
```

---

# Por que usar classes internas

Possivelmente trata-se de uma classe que só faz sentido em conjunto com a classe externa.

---

# Classe interna

Em geral, um objeto de uma classe interna precisa estar associado a um objeto da classe externa, e tem acesso a todos os seus membros (inclusive os privados).

```java
class ClasseExterna {
	private int x;
	
	public ClasseExterna(int valor) {
		x = valor;
	}
	
	public void roda() {
		ClasseInterna ci = new ClasseInterna();
		ci.imprimeX();
	}

	public class ClasseInterna {
		int y;
		
		public void imprimeX() {
			System.out.println(x);
		}
	}
}

public class Main {
	public static void main(String[] args) {
		ClasseExterna ce = new ClasseExterna(5);
		ce.roda();
	}
}
```

---

# Instanciando classe interna fora da classe externa

Nesse caso, você deve prefixar o `new` com o objeto da classe externa ao qual o novo objeto será vinculado.

```java
public class Main {
	public static void main(String[] args) {
		ClasseExterna ce = new ClasseExterna(5);
    ClasseInterna ci = ce.new ClasseInterna();
		ci.imprimeX();
	}
}
```

---

# Modificadores

- A classe interna pode ter modificadores de visibilidade: `public`, `protected`, `private` ou nenhum (privado ao pacote).
- A classe interna pode ser declarada com `static` caso ela não precise acessar nenhum membro da classe externa. Nesse caso, a classe interna pode ser instanciada mesmo sem uma instância da classe externa.
- Você pode declarar uma classe interna dentro de um método!

---

# Classes internas anônimas

Exemplo inicial:

```java
import java.util.Arrays;
import java.util.List;
import java.util.function.Consumer;

public class Main {
  public static void main(String[] args) {
    new Exemplo().executa();
  }
}

class Exemplo {
  public void executa() {
    // Usando impressora para imprimir um número
    Impressora impressora = new Impressora();
    impressora.accept(5);

    // Usando impressora com forEach
    List<Integer> list = Arrays.asList(3, 7, 5, 1);
    list.forEach(impressora);
  }
}

class Impressora implements Consumer<Integer> {
  @Override
  public void accept(Integer t) {
      System.out.println(t);
  }
}
```

---

# Classes internas anônimas

Se você quer criar uma classe para instanciar uma única vez, você pode criar uma classe implicitamente.

```java
class Exemplo {
  public void executa() {
    // Usando impressora com forEach
    List<Integer> list = Arrays.asList(3, 7, 5, 1);
    list.forEach(new Consumer<Integer>() {
		@Override
		public void accept(Integer t) {
			System.out.println(t);
		}
	});
  }
}
```

---

# Outro exemplo

```java
public class Main extends JFrame {
	public Main() {
		JButton botao = new JButton("Confirmar");
		add(botao);
		pack();
	    setVisible(true);
	    setDefaultCloseOperation(EXIT_ON_CLOSE);
	 
		botao.addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent e) {
				JOptionPane.showMessageDialog(Main.this, "Confirmado");
			}
		});
	}
	
	public static void main(String[] args) {
		new Main();
	}
}
```

---

# Uso do this

No exemplo anterior, note que, dentro da classe interna, `this` refere-se ao objeto da classe interna. Se você quiser se referir ao objeto correspondete da classe externa, use `NomeDaClasseExterna.this`.