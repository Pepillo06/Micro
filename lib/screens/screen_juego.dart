import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/logica_juego.dart'; 
import '../widgets/imagen_ahorcado.dart';
import '../widgets/teclado.dart';      

class JuegoScreen extends StatelessWidget {
  const JuegoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Escucha los cambios en LogicaJuego
    return Consumer<LogicaJuego>(
      builder: (context, logicaJuego, child) {
        
        // Muestra el diálogo de fin de juego si es necesario
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (logicaJuego.isGameOver && Navigator.of(context).canPop()) {
            _showGameOverDialog(context, logicaJuego);
          }
        });
        
        return Scaffold(
          appBar: AppBar(
            title: const Text('Juego del Ahorcado'),
            actions: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  // Muestra las puntuaciones guardadas
                  child: Text('G: ${logicaJuego.totalWins} | P: ${logicaJuego.totalLosses}',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                // 1. Imagen del Ahorcado
                ImagenAhorcado(fallosIncorrectos: logicaJuego.incorrectGuesses),

                // 2. Palabra Oculta
                Text(
                  logicaJuego.getDisplayWord(),
                  style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, letterSpacing: 8.0),
                ),

                // 3. Teclado
                Teclado(
                  onLetterPressed: (letter) {
                    // Llama al método de la lógica
                    logicaJuego.guessLetter(letter); 
                  },
                  letrasAdivinadas: logicaJuego.guessedLetters,
                  juegoActivo: !logicaJuego.isGameOver,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showGameOverDialog(BuildContext context, LogicaJuego logicaJuego) {
    final title = logicaJuego.isWinner ? '¡Ganaste! 🎉' : '¡Perdiste! 💀';
    final content = logicaJuego.isWinner 
        ? '¡Felicidades! Lograste adivinar la palabra.'
        : 'La palabra era: ${logicaJuego.selectedWord}';

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              child: const Text('Jugar de Nuevo'),
              onPressed: () {
                Navigator.of(context).pop();
                logicaJuego.chooseNewWord();
              },
            ),
          ],
        );
      },
    );
  }
}