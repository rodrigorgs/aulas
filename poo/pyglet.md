---
layout: page
title: Pyglet
features: []
---

Exemplo:

```python
import pyglet

window = pyglet.window.Window(300, 200)
image = pyglet.resource.image('alface.png')

objeto1 = pyglet.sprite.Sprite(image, 30, 30)
objeto2 = pyglet.sprite.Sprite(image, 90, 10)


@window.event
def on_draw():
    window.clear()
    objeto1.draw()
    objeto2.draw()


@window.event
def on_key_press(symbol, modifiers):
    objeto1.x += 10


@window.event
def on_mouse_press(x, y, button, modifiers):
    if button == pyglet.window.mouse.LEFT:
        objeto2.x = x - objeto2.width // 2
        objeto2.y = y - objeto2.height // 2


pyglet.app.run()
```

Executar no navegador: <https://replit.com/@rodrigorocha/Pyglet#main.py>