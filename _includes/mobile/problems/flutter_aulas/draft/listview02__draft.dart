import 'package:flutter/material.dart';

main() {
  Future<List<String>> fetchItens() async {
    await Future.delayed(Duration(seconds: 1));
    return [
      'Item 1',
      'Item 2',
      'Item 3',
      'Item 4',
      'Item 5',
      'Item 6',
      'Item 7',
      'Item 8',
      'Item 9',
      'Item 10'
    ];
  }

  runApp(MyApp(fetchItens: fetchItens));
}

class MyApp extends StatelessWidget {
  final Future<List<String>> Function() fetchItens;

  const MyApp({super.key, required this.fetchItens});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // Substitua o Placeholder por um FutureBuilder
        // que chama fetchItens e exibe um CircularProgressIndicator
        // enquanto os itens são carregados, e depois exibe
        // o ItemListView com os itens carregados.
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
