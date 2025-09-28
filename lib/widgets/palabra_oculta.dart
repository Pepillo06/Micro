import 'package:flutter/material.dart';

class PalabraOculta extends StatelessWidget {
  final String palabra;
  final List<String> letrasAdivinadas;

  const PalabraOculta({
    super.key,
    required this.palabra,
    required this.letrasAdivinadas,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 10.0,
      runSpacing: 10.0,
      children: palabra.split('').map((letra) {
        // Muestra la letra real si fue adivinada, sino muestra un guion bajo
        String letraAMostrar = letrasAdivinadas.contains(letra) ? letra : '_';

        return Text(
          letraAMostrar,
          style: const TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.w800,
            letterSpacing: 8.0, // Espacio entre las letras
            color: Colors.blueAccent,
          ),
        );
      }).toList(),
    );
  }
}
