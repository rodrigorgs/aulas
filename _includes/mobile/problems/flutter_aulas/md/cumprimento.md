## Cumprimento

Crie um widget `Cumprimento` que recebe um nome e exibe um texto no formato `Olá, <nome>!` (atenção a maiúsculas, minúsculas e pontuação). Fique à vontade para alterar o construtor e o método `build`, mas garanta que o widget pode ser instanciado como no exemplo: `Cumprimento(nome: 'Mundo')`.

<textarea class="code lang-flutter" data-filename="flutter_aulas/lib/cumprimento.dart">
// Arquivo flutter_aulas/lib/cumprimento.dart
import 'package:flutter/material.dart';

void main() {
  runApp(const Cumprimento(nome: 'Mundo'));
}

class Cumprimento extends StatelessWidget {
  const Cumprimento({super.key, String? nome});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
</textarea>

<div class="testcode">
{% include mobile/problems/flutter_aulas/test/cumprimento_test.dart %}
</div>