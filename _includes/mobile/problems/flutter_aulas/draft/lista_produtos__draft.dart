import 'package:flutter/material.dart';

class Produto {
  final String nome;
  final double preco;

  Produto(this.nome, this.preco);
}

void main() {
  final produtos = [
    Produto("Escova", 20.0),
    Produto("Sabonete", 4.0),
    Produto("Condicionador", 9.0),
  ];
  runApp(
    MaterialApp(
        title: "ToDo List",
        home: Scaffold(
          appBar: AppBar(title: Text('Produtos')),
          body: Center(
            child: ListaCompras(produtos: produtos),
          ),
        )),
  );
}

class ListaCompras extends StatelessWidget {
  const ListaCompras({super.key, required List<Produto> produtos});

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      ListTile(
        title: Text('Escova'),
        subtitle: Text('20 reais'),
      ),
      ListTile(
        title: Text('Sabonete'),
        subtitle: Text('4 reais'),
      )
    ]);
  }
}
