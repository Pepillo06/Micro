import 'package:flutter/material.dart';
import 'juego_ahorcado_page.dart';

import 'package:shared_preferences/shared_preferences.dart'; 

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
      
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple), 
    
      useMaterial3: true,
    ),
   
    home: const JuegoAhorcadoPage(), 
  );
}
}
