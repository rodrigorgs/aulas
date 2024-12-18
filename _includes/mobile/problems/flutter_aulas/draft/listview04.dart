import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'listview04.g.dart';

main() {
  runApp(ProviderScope(child: MyApp()));
}

@riverpod
class ItensController extends _$ItensController {
  @override
  Future<List<String>> build() async {
    await Future.delayed(Duration(seconds: 2));
    return [
      'Item 1',
      'Item 2',
      'Item 3',
    ];
  }
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itens = ref.watch(itensControllerProvider);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Meus itens'),
        ),
        body: itens.when(
          data: (data) => ItemListView(itens: data),
          error: (error, stackTrace) => Placeholder(),
          loading: () => Center(child: CircularProgressIndicator()),
        ),
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
    return ListView.builder(
      itemCount: itens.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(itens[index]),
        );
      },
    );
  }
}
