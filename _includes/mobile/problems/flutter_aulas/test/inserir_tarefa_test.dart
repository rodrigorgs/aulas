import 'package:flutter_aulas/inserir_tarefa.dart';
import 'package:test/test.dart';

void main() {
  group('inserirTarefa', () {
    test('deve inserir tarefa com prioridade padrão', () {
      List<Map<String, Object>> tarefas = [];
      final titulo = 'Comprar leite';
      final resultado = inserirTarefa(tarefas, titulo);
      expect(resultado, isTrue);
      expect(tarefas, [
        {'titulo': titulo, 'prioridade': 5},
      ]);
    });

    test('deve inserir tarefa com prioridade especificada', () {
      List<Map<String, Object>> tarefas = [];
      final titulo = 'Comprar pão';
      final prioridade = 3;
      final resultado = inserirTarefa(tarefas, titulo, prioridade);
      expect(resultado, isTrue);
      expect(tarefas, [
        {'titulo': titulo, 'prioridade': prioridade},
      ]);
    });

    test('não deve inserir tarefa com prioridade inválida', () {
      List<Map<String, Object>> tarefas = [];
      final titulo = 'Comprar açúcar';
      final prioridade = 0;
      final resultado = inserirTarefa(tarefas, titulo, prioridade);
      expect(resultado, isFalse);
      expect(tarefas, isEmpty);
    });
  });
}
