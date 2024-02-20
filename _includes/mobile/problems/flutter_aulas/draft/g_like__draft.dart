import 'package:flutter/material.dart';

void main() {
  runApp(buildApp());
}

Widget buildApp() {
  // Construa o app segundo a tela de referência.
  // Para isso, substitua o Placeholder pelos
  // widgets adequados.
  //
  // - A distância entre o ícone e o texto é de 8 pixels.
  // - O enchimento ao redor do conjunto (ícone e texto)
  // é de 16 pixels.
  // - A cor do enchimento é Colors.blueGrey.shade100
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      body: Center(
        child: Placeholder(),
      ),
    ),
  );
}