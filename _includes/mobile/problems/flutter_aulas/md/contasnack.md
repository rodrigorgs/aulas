## Contador

Crie um `StatelessWidget` chamado `Contador`, que exibe três botões: `+1`, `+5` e `+25`. Ao clicar em cada um deles, o contador é incrementado em 1, 5 e 25, respectivamente, e uma snackbar é exibida com o texto "Contador: <N>", onde <N> é o valor atual do contador. 

Use uma duração de 500 milissegundos para a snackbar.

OBS.: Não é uma boa prática guardar o estado do contador dentro de um StatelessWidget, mas vamos fazer isso por enquanto para aprender como funciona.


<textarea class="code lang-flutter" data-filename="flutter_aulas/lib/contasnack.dart">
// Arquivo flutter_aulas/lib/contasnack.dart
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: const Text('Contador'),
      ),
      body: Contador(),
    ),
  ));
}

class Contador extends StatelessWidget {
  const Contador({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

</textarea>

<div class="testcode">
{% include mobile/problems/flutter_aulas/test/contasnack_test.dart %}
</div>