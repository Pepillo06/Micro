
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; 
import 'models/logica_juego.dart';      // Importa la lógica
import 'screens/screen_juego.dart';      // Importa la pantalla

void main() {
  runApp(
    // Envolvemos la app en el provider
    ChangeNotifierProvider(
      create: (context) => LogicaJuego(),
      child: const AhorcadoApp(),
    ),
  );
}

class AhorcadoApp extends StatelessWidget {
  const AhorcadoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Juego del Ahorcado',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // Usamos el nombre de la clase en el archivo 'juego_screen.dart'
      home: const JuegoScreen(), 
    );
  }
}