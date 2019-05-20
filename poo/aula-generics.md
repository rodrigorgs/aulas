---
layout: page
title: Generics
---

# Generics

Generics permitem criar uma classe ou método que operam sobre vários tipos de forma que o compilador pode detectar problemas de tipo.

---

# Collections

É o exemplo clássico de generics na biblioteca padrão Java. Exemplo do Wikipedia:

```java
List v = new ArrayList();
v.add("test");
Integer i = (Integer)v.get(0); // Run time error

/////////////

List<String> v = new ArrayList<String>();
v.add("test");
Integer i = v.get(0); // (type error)  compilation-time error
```

---

# Método genérico

```java
	public static <T> T primeiro(T[] array) {
		return array[0];
	}
```

<!-- Alternativas: sobrecarga (uma versão do método para cada tipo) ou usar Object[] (requer cast) -->

Geralmente usa-se a letra `T` para denotar um tipo genérico.

---

# Método genérico

```java
public static <T> ArrayList<T> encaixota(T valor) {
    ArrayList<T> a = new ArrayList<>();
    a.add(valor);
    return a;
}
```

---

# Classe genérica

Ver Thinking in Java, p. 440. Classe Holder de automóvel, depois Holder de Object, depois Holder com generics, depois Dupla.

---

Se você instanciar uma classe genérica sem informar os tipos, assume-se que os tipos são `Object`.

---

# Uso de curingas, extends e super

