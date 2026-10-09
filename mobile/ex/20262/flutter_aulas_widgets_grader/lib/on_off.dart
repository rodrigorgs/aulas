// Arquivo flutter_aulas/lib/on_off.dart
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
