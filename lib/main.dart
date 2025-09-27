// lib/main.dart

import 'package:flutter/material.dart';
// Importa el widget principal de tu juego
import 'juego_ahorcado_page.dart';

// Importante: La librería SharedPreferences necesita esta línea para funcionar correctamente
import 'package:shared_preferences/shared_preferences.dart'; 

void main() {
  // CRUCIAL: Asegura que los servicios de Flutter (como SharedPreferences)
  // estén inicializados antes de que la aplicación se ejecute.
  WidgetsFlutterBinding.ensureInitialized(); 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'El Ahorcado',
      // Quitar el banner de debug para una UI más limpia
      debugShowCheckedModeBanner: false, 
      theme: ThemeData(
        // Usamos deepPurple como color principal
        primarySwatch: Colors.deepPurple, 
        useMaterial3: true,
      ),
      // Apunta a tu widget del juego, NO al widget de contador
      home: const JuegoAhorcadoPage(), 
    );
  }
}