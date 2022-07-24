---
layout: page
title: Diagramas UML
features: [uml]
---

Diagramas UML podem ser adicionados com o [PlantUML](https://plantuml.com/). O código do PlantUML deve estar dentro de uma `div` com a classe `uml`. Exemplo:

```html
<div class="uml">
class Throwable {
}
class Error extends Throwable {
}
class Exception extends Throwable {
}
class RuntimeException extends Exception {
}
</div>
```

Resultado:

<div class="uml">
class Throwable {
}
class Error extends Throwable {
}
class Exception extends Throwable {
}
class RuntimeException extends Exception {
}
</div>

Diagramas de classe podem ser descritos em uma linguagem similar a Java.
