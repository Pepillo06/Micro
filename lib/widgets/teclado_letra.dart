import 'package:flutter/material.dart';

class TecladoLetra extends StatelessWidget {
  final String letra;
  final bool habilitado;
  final bool adivinada;
  final bool equivocada;
  final Function(String) onPresionar;
const TecladoLetra({
    super.key,
    required this.letra,
    required this.habilitado,
    required this.adivinada,
    required this.equivocada,
    required this.onPresionar,
  });


   @override
  Widget build(BuildContext context) {
    Color colorFondo;
    
    if (adivinada) {
      colorFondo = Colors.green.shade700;
    } else if (equivocada) {
      colorFondo = Colors.red.shade700;
    } else {
      colorFondo = Colors.deepPurple;
    }

    return SizedBox(
      width: 50,
      height: 50,
      child: ElevatedButton(
        onPressed: habilitado
            ? () => onPresionar(letra)
            : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: colorFondo,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.zero,
          disabledBackgroundColor: colorFondo, 
        ),
        child: Text(
          letra,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}



