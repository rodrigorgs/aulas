import 'package:flutter/material.dart';

void main() {
  runApp(buildApp());
}

Widget buildApp() {
  // Construa o app segundo a tela de referência.
  // Para isso, substitua o Placeholder pelos
  // widgets adequados.
  //
  // - As barras superior e inferior possuem 50 pixels de altura
  // e a cor é Colors.blueGrey.shade100.
  // - Os ícones da barra inferior são, da esquerda para a direita,
  // Icons.home, Icons.favorite e Icons.history.
  // - O texto principal está afastado 16 pixels das bordas.
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      body: Column(
        children: [
          Text("Início"),
          Text(
            "1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30",
          ),
          Icon(Icons.home),
        ],
      ),
    ),
  );
}