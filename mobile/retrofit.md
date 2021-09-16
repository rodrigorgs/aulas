---
layout: remark
title: "Java: orientação a objetos"
---

<div>

# Retrofit

- É uma biblioteca Java para requisições HTTP
- Disponível em <https://square.github.io/retrofit/>

<!--
- Seu uso é [recomendado pela Google no projeto Jetpack](https://developer.android.com/jetpack/androidx/explorer)
-->

---

# Instalação

No arquivo `app/build.gradle`, em `dependencies`, adicione:

```java
implementation 'com.squareup.retrofit2:retrofit:2.9.0'
implementation 'com.squareup.retrofit2:converter-gson:2.9.0'
```

Observação: Retrofit requer API 21 ou mais recente. Você pode precisar alterar o parâmetro de configuração `minSdkVersion` no mesmo arquivo.

---

# Instalação

Você também vai precisar adicionar a permissão de acesso à Internet no arquivo `app/src/main/AndroidManifest.xml`:

```xml
<?xml version="1.0" encoding="utf-8"?>
<manifest ...>

  <uses-permission android:name="android.permission.INTERNET"/>

  <application ...>
    ...
  </application>
</manifest>
```

---

# Exemplo de uso

- Usaremos o <https://jsonplaceholder.typicode.com/>, que possui um exemplo de [serviço para gerenciar listas de afazeres](https://jsonplaceholder.typicode.com/todos/1) (TODO lists).
- Primeiramente, crie uma classe para representar um TODO

```java
public class Todo {
    private Long userId;
    private Long id;
    private String title;
    private boolean completed;

    // getters e setters
    // ...
}
```

---

# Exemplo de uso

Agora crie a interface TodoService, que [especifica como são as chamadas ao serviço](https://square.github.io/retrofit/) de lista de afazeres.

```java
public interface TodoService {
    @GET("/todos/{id}")
    public Call<Todo> getTodoById(@Path("id") Long id);

    @GET("/todos")
    public Call<List<Todo>> getTodos();

    @POST("/todos")
    public Call<Todo> createTodo(@Body Todo todo);
}
```

A implementação dessa interface será criada automaticamente pelo Retrofit com base nas anotações de código.

---

# Exemplo de uso

Agora, edite sua Activity principal para inicializar a API:

```java
public class MainActivity extends AppCompatActivity {
  private Retrofit retrofit;
  private TodoService todoService;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
      // ...
      retrofit = new Retrofit.Builder()
        .baseUrl("https://jsonplaceholder.typicode.com/")
        .addConverterFactory(GsonConverterFactory.create())
        .build();

      todoService = retrofit.create(TodoService.class);
      // ...
    }
}
```

---

# Exemplo de uso

Por fim, para fazer uma requisição assíncrona:

```java
Call<Todo> call = todoService.getTodoById(2L);

call.enqueue(new Callback<Todo>() {
  @Override
  public void onResponse(Call<Todo> call, Response<Todo> response) {
    Todo todo = response.body();
    Log.i("meuapp", "TODO: " + todo.getTitle());
  }

  @Override
  public void onFailure(Call<Todo> call, Throwable t) {
    Log.i("meuapp", "falhou");
  }
});
```

---

# Exemplo de uso

Você também pode usar `call.execute()` para fazer uma chamada síncrona (assumindo que seu código já está executando em uma thread separada).

</div>