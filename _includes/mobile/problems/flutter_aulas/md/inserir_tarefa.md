## Tarefa

Uma tarefa é representada por um dicionário (`Map`) com os seguintes campos:

- `titulo`: título da tarefa (string)
- `prioridade`: grau de urgência da tarefa (int)

Crie uma função, `inserirTarefa`, com três parâmetros posicionais: uma lista de tarefas, um título e, opcionalmente uma prioridade. A função deve adicionar ao final da lista uma tarefa com as informações fornecidades. Se a prioridade não for informada, deve-se assumir que é 5. Se a prioridade for menor que 1, ela não deve ser inserida e a função deve retornar `false`; do contrário, a função deve retornar `true`.

<textarea class="code lang-dart" data-filename="flutter_aulas/lib/inserir_tarefa.dart">
// Arquivo flutter_aulas/lib/inserir_tarefa.dart
// Defina aqui a função inserirTarefa


// Exemplo de uso:
void main() {
  var tarefas = [
    {'titulo': 'Comprar pão', 'prioridade': 3},
    {'titulo': 'Comprar leite', 'prioridade': 1},
    {'titulo': 'Comprar manteiga', 'prioridade': 2},
  ];

  print(tarefas);
  print(inserirTarefa(tarefas, 'Comprar café'));
  print(tarefas);
}
</textarea>

<div class="testcode">
{% include mobile/problems/flutter_aulas/test/inserir_tarefa_test.dart %}
</div>