---
layout: remark
title: Slide de exemplo
---

<div>

# Código

Os slides usam a biblioteca JavaScript Remark.

Para transformar um documento Markdown em slides, use o layout `remark`:

```
---
layout: remark
title: Título da página
---
```

---

# Código

- O documento é escrito em Markdown
- Use `---` para separar slides
- O documento deve estar contido dentro da tag `div`. Exemplo:

```
---
layout: remark
title: Slides de exemplo
---

<div>

# Slide 1

---

# Slide 2

</div>
```

---

# Destaque de linha

Use um `*` no início de uma linha de código para destacá-la.

Código:

```
   print("Alô, mundo!")
   *print("Tchau, mundo!")
```

Resultado:

```python
print("Alô, mundo!")
*print("Tchau, mundo!")
```

---

class: middle, center

# Slide de título

---

# Slide de título

Use esse código:

```markdown
---

class: middle, center

# Slide de título

---
```

</div>