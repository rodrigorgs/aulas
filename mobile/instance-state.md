---
layout: page
title: Exercícios de Android
---


```java
@Override
protected void onSaveInstanceState(Bundle outState) {
    super.onSaveInstanceState(outState);

    outState.putString("chave", "valor que vai ser salvo");
}

@Override
protected void onRestoreInstanceState(Bundle savedInstanceState) {
    super.onRestoreInstanceState(savedInstanceState);

    String valorSalvo = savedInstanceState.getString("chave");
    Log.d("", valorSalvo);
}
```