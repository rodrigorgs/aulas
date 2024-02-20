import 'package:flutter/material.dart';

void main() {
  runApp(buildApp());
}

Widget buildApp() {
  // Construa o app segundo a tela de referência.
  // Para isso, substitua o Placeholder pelos
  // widgets adequados.
  //
  // ATENÇÃO:
  // - Não modifique o código dentro de main.
  // - Não altere o nome desta função.
  // - Mantenha o MaterialApp e o Scaffold.
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      body: Center(
        child: Placeholder(),
      ),
    ),
  );
}