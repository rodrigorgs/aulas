import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'listview03.g.dart';

main() {
  runApp(ProviderScope(child: MyApp()));
}

@riverpod
Future<List<String>> itens(Ref ref) async {
  await Future.delayed(Duration(seconds: 1));
  return [
    'Item 1',
    'Item 2',
    'Item 3',
  ];
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Meus itens'),
        ),
        // Substitua o Placeholder por um código que usa o
        // itensProvider para exibir os itens com a ItemListView.
        // Enquanto os itens são carregados, exiba um CircularProgressIndicator.
        body: Placeholder(),
      ),
    );
  }
}

class ItemListView extends StatelessWidget {
  final List<String> itens;
  ItemListView({
    super.key,
    required this.itens,
  });

  @override
  Widget build(BuildContext context) {
    // Retorne uma lista com os itens
    // Cada item deve ser um ListTile com o texto do item
    // como título.
    return Placeholder();
  }
}
