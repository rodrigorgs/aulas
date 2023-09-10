import 'package:flutter_aulas/pessoa.dart';
import 'package:test/test.dart';
import 'dart:mirrors';

void main() {
  group('Pessoa', () {
    test('deve criar instância de Pessoa', () {
      final pessoa = Pessoa('123.456.789-00', 'John Doe');
      expect(pessoa.cpf, '123.456.789-00');
      expect(pessoa.nome, 'John Doe');
    });

    test('deve atualizar o nome de uma instância de Pessoa', () {
      final pessoa = Pessoa('123.456.789-00', 'John Doe');
      pessoa.nome = 'Jane Doe';
      expect(pessoa.nome, 'Jane Doe');
    });

    test('não deve ser possível atualizar o CPF de uma instância de Pessoa',
        () {
      ClassMirror cp = reflectClass(Pessoa);
      var varCpf = cp.declarations[#cpf] as VariableMirror;
      expect(varCpf.isFinal, isTrue);
    });
  });
}
