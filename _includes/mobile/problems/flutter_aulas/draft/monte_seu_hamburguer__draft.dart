import 'package:flutter/material.dart';

class Item {
  final String nome;
  final double preco;
  bool selecionado;

  Item(this.nome, this.preco, [this.selecionado = false]);
}

void main() {
  final itens = [
    Item("Pão", 2.0, true),
    Item("Alface", 1.0),
    Item("Tomate", 2.0),
    Item("Queijo", 3.0),
    Item("Presunto", 3.0),
    Item("Maionese", 2.0),
    Item("Ovo", 2.0),
    Item("Bacon", 3.0),
  ];
  runApp(
    MaterialApp(
        title: "Monte seu Hamburguer",
        home: Scaffold(
          appBar: AppBar(title: Text('Escolha os itens')),
          body: Center(
            child: TelaMontagem(itens: itens),
          ),
        )),
  );
}

class TelaMontagem extends StatefulWidget {
  final List<Item> itens;
  const TelaMontagem({super.key, required this.itens});

  @override
  State<TelaMontagem> createState() => _TelaMontagemState();
}

class _TelaMontagemState extends State<TelaMontagem> {
  double total() {
    return 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            children: [
              ListTile(
                title: Text('Pão'),
                subtitle: Text('2 reais'),
                trailing: Checkbox(value: true, onChanged: (v) {}),
              ),
              ListTile(
                title: Text('Alface'),
                subtitle: Text('1 reais'),
                trailing: Checkbox(value: false, onChanged: (v) {}),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8.0),
          child: Text('Total: ${total()} reais'),
        ),
      ],
    );
  }
}
