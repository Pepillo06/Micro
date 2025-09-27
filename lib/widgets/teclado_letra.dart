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
}