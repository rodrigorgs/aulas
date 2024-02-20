import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(body: Inicio()),
  ));
}

class Inicio extends StatelessWidget {
  const Inicio({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      child: Center(
        child: BotaoOnOff(),
      ),
    );
  }
}

///
/// Transforme este widget em um stateful widget
/// e faça com que o botão alterne entre "On" e "Off"
/// quando for clicado.
///
/// O valor inicial do botão deve ser "Off".
///
class BotaoOnOff extends StatelessWidget {
  BotaoOnOff({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: Text("Off"),
    );
  }
}
