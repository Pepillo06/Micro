import 'package:flutter/material.dart';

class JuegoAhorcadoPage extends StatelessWidget {
  const JuegoAhorcadoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('El Ahorcado'),
      ),
      body: const Center(
        child: Text(
          '¡Bienvenido al juego del ahorcado!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}