import 'dart:io';
import 'dart:math';

void main() {
  final palabras = ['flutter', 'dart', 'codigo', 'ahorcado', 'programa'];
  final palabra = palabras[Random().nextInt(palabras.length)];
  var letrasAdivinadas = <String>{};
  var intentosRestantes = 6;

  print('¡Bienvenido al juego del ahorcado!');
  while (intentosRestantes > 0) {
    var display = palabra
        .split('')
        .map((letra) => letrasAdivinadas.contains(letra) ? letra : '_')
        .join(' ');
    print('\nPalabra: $display');
    print('Intentos restantes: $intentosRestantes');
    stdout.write('Ingresa una letra: ');
    var entrada = stdin.readLineSync()?.toLowerCase();
    if (entrada == null ||
        entrada.length != 1 ||
        !RegExp(r'^[a-z]$').hasMatch(entrada)) {
      print('Por favor, ingresa una sola letra válida.');
      continue;
    }
    if (letrasAdivinadas.contains(entrada)) {
      print('Ya has adivinado esa letra.');
      continue;
    }
    letrasAdivinadas.add(entrada);
    if (!palabra.contains(entrada)) {
      intentosRestantes--;
      print('¡Incorrecto!');
    } else {
      print('¡Correcto!');
    }
    if (palabra.split('').every((letra) => letrasAdivinadas.contains(letra))) {
      print('\n¡Felicidades! Has adivinado la palabra: $palabra');
      return;
    }
  }
  print('\n¡Has perdido! La palabra era: $palabra');
}
