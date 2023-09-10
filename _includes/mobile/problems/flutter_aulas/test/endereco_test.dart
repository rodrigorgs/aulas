// BEGIN: 0f3b4c9fjw3d
import 'package:flutter_aulas/endereco.dart';
import 'package:test/test.dart';

void main() {
  group('criaEtiqueta', () {
    test('com endereço', () {
      final cliente = Cliente('João', Endereco('12345-678', 'São Paulo'));
      expect(criaEtiqueta(cliente), 'João - CEP 12345-678');
    });

    test('sem endereço', () {
      final cliente = Cliente('Maria');
      expect(criaEtiqueta(cliente), 'Maria - CEP não informado');
    });
  });
}
// END: 0f3b4c9fjw3d