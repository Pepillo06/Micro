import 'package:flutter/material.dart'; // Necesario para ChangeNotifier
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';

// Lista simple de palabras en mayúsculas
const List<String> _wordList = [
  'FLUTTER',
  'ANDROID',
  'CODIGO',
  'WIDGET',
  'DART',
  'AHORCADO',
];

// Clase que extiende ChangeNotifier, pero no usa NINGÚN widget de UI
class LogicaJuego extends ChangeNotifier {
  String _selectedWord = '';
  List<String> _guessedLetters = [];
  int _incorrectGuesses = 0;
  
  final int maxIncorrectGuesses = 7; 

  int totalWins = 0;
  int totalLosses = 0;

  // --- GETTERS ---
  String get selectedWord => _selectedWord;
  List<String> get guessedLetters => _guessedLetters;
  int get incorrectGuesses => _incorrectGuesses;
  
  // Lógica de estado
  bool get isGameOver => isWinner || isLoser;
  bool get isWinner {
    return _selectedWord.split('').every((letter) => _guessedLetters.contains(letter));
  }
  bool get isLoser => _incorrectGuesses >= maxIncorrectGuesses;

  LogicaJuego() {
    // Estas llamadas NO causan errores, aunque la app no esté corriendo
    _loadScores();
    chooseNewWord();
  }

  // --- MÉTODOS DE JUEGO ---

  void chooseNewWord() {
    final random = Random();
    _selectedWord = _wordList[random.nextInt(_wordList.length)];
    _guessedLetters = [];
    _incorrectGuesses = 0;
    //notifyListeners(); // Descomentar cuando lo conectes a la UI
  }

  void guessLetter(String letter) async {
    if (isGameOver || _guessedLetters.contains(letter)) return;

    _guessedLetters.add(letter);

    if (!_selectedWord.contains(letter)) {
      _incorrectGuesses++;
    }

    // Verifica fin de juego y actualiza puntuaciones
    if (isWinner) {
      totalWins++;
      await _saveScores();
    } else if (isLoser) {
      totalLosses++;
      await _saveScores();
    }

    //notifyListeners(); // Descomentar cuando lo conectes a la UI
  }
  
  // Devuelve la palabra con guiones
  String getDisplayWord() {
    String displayWord = '';
    for (var letter in _selectedWord.split('')) {
      displayWord += _guessedLetters.contains(letter) ? letter : '_';
      displayWord += ' ';
    }
    return displayWord.trim();
  }

  // --- PERSISTENCIA (Métodos funcionales, aunque shared_preferences requiere Flutter) ---

  // NOTA: Para probar esta clase sin la UI de Flutter, estos métodos 
  // lanzarán un error si no corres la app en un dispositivo/emulador, 
  // ya que SharedPreferences es una dependencia de Flutter.
  // Para una prueba de lógica pura, puedes comentar el cuerpo de estos métodos.
  Future<void> _loadScores() async {
     // Aquí iría el código de SharedPreferences
  }

  Future<void> _saveScores() async {
     // Aquí iría el código de SharedPreferences
  }
}