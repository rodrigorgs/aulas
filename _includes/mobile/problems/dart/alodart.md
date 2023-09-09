## Alo Dart

<textarea class="code lang-dart" data-filename="flutter_aulas/lib/alodart.dart">
String dizAlo(String nome, [String saudacao = 'Alô']){
  return "$saudacao, $nome!";
}
</textarea>

<div class="testcode">
import 'package:flutter_aulas/alodart.dart';
import 'package:test/test.dart';

void main() {
  // unit test dizAlo
  test('dizAlo', () {
    expect(dizAlo('João', 'Olá'), 'Olá, João!');
    expect(dizAlo('Maria'), 'Alô, Maria!');
    expect(dizAlo('Fulano', 'Oi'), 'Oi, Fulano!');
  });
}
</div>