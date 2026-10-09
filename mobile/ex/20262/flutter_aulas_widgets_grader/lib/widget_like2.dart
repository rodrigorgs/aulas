import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: Center(
          child: Placeholder(), // troque por BotaoLike(),
        ),
      ),
    ),
  );
}

// Crie o widget BotaoLike, que é um ElevatedButton que contém
// um ícone e um texto. O ícone é um coração preenchido.
// Opcionalmente BotaoLike pode receber um parâmetro nomeado,
// chamado texto, que é o texto a ser exibido no botão.
// Se o parâmetro não for fornecido, o texto padrão é "Like".
// ...
