import 'package:flutter/material.dart';

void main() {
  runApp(buildApp());
}

Widget buildApp() {
  // Construa o app segundo a tela de referência.
  // Para isso, substitua o Placeholder pelos
  // widgets adequados.
  //
  // O espaçamento ao redor do texto é de 16 pixels.
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      body: Center(
        child: Placeholder(),
      ),
    ),
  );
}