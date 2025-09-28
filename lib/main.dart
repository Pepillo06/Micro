import 'package:flutter/material.dart';
import 'juego_ahorcado_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

 @override
Widget build(BuildContext context) {
  return MaterialApp(
    title: 'El Ahorcado',
    debugShowCheckedModeBanner: false, 
    theme: ThemeData(
      // CORREGIDO: Usamos ColorScheme en lugar de primarySwatch
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple), 
      // fontFamily y primarySwatch eliminados.
      useMaterial3: true,
    ),
    // Agregamos el 'const' que faltaba aquí
    home: const JuegoAhorcadoPage(), 
  );
}
}
