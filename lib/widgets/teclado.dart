import 'package:flutter/material.dart';

class Teclado extends StatelessWidget {
  final Function(String) onLetterPressed;
  final List<String> letrasAdivinadas;
  final bool juegoActivo;

  const Teclado({
    required this.onLetterPressed,
    required this.letrasAdivinadas,
    required this.juegoActivo,
    super.key,
  });

  static const List<String> _alphabet = [
    'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M',
    'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'
  ];

  @override
  Widget build(BuildContext context) {
    // Wrap organiza los widgets en filas que fluyen
    return Wrap(
      spacing: 8.0, 
      runSpacing: 8.0, 
      alignment: WrapAlignment.center,
      children: _alphabet.map((letter) {
        final isPressed = letrasAdivinadas.contains(letter);
        
        return SizedBox(
          width: 40,
          height: 40,
          child: ElevatedButton(
            // El botón se deshabilita si ya fue presionado o si el juego terminó
            onPressed: isPressed || !juegoActivo
                ? null 
                : () => onLetterPressed(letter),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.zero,
              backgroundColor: isPressed ? Colors.grey[700] : Colors.blue,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: Text(
              letter,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        );
      }).toList(),
    );
  }
}