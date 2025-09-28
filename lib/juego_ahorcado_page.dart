
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart'; 

import 'widgets/ahorcado_imagen.dart';
import 'widgets/palabra_oculta.dart';
import 'widgets/teclado_letra.dart';
  
class JuegoAhorcadoPage extends StatefulWidget {
  const JuegoAhorcadoPage({super.key});

  @override
  State<JuegoAhorcadoPage> createState() => _JuegoAhorcadoPageState();
}

class _JuegoAhorcadoPageState extends State<JuegoAhorcadoPage> {
  final List<String> _palabras = [
    'FLUTTER', 'DART', 'WIDGET', 'COLUMNA', 'ESTADO', 'PROGRAMACION', 'VISUALCODE', 'GITHUB', 'ANDROID'
  ];
  
  String _palabraSeleccionada = '';
  List<String> _letrasAdivinadas = [];
  List<String> _letrasEquivocadas = [];
  final int _maxIntentos = 6; 

  int _partidasJugadas = 0;
  int _partidasGanadas = 0;
  int _partidasPerdidas = 0;




@override
  void initState() {
    super.initState();
    _cargarPuntuaciones();
    _iniciarNuevoJuego();
  }

  Future<void> _cargarPuntuaciones() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _partidasJugadas = prefs.getInt('jugadas') ?? 0;
      _partidasGanadas = prefs.getInt('ganadas') ?? 0;
      _partidasPerdidas = prefs.getInt('perdidas') ?? 0;
    });
  }

  Future<void> _guardarPuntuaciones() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('jugadas', _partidasJugadas);
    await prefs.setInt('ganadas', _partidasGanadas);
    await prefs.setInt('perdidas', _partidasPerdidas);
  }

  void _iniciarNuevoJuego() {
    setState(() {
      final random = Random();
      _palabraSeleccionada = _palabras[random.nextInt(_palabras.length)].toUpperCase(); 
      _letrasAdivinadas = [];
      _letrasEquivocadas = [];
    });
  }

  bool _juegoGanado() {
    return _palabraSeleccionada.split('').every((letra) => _letrasAdivinadas.contains(letra));
  }

  void _manejarIntento(String letra) {
    if (_letrasAdivinadas.contains(letra) ||
        _letrasEquivocadas.contains(letra)) {
      return;
    }

    setState(() {
      if (_palabraSeleccionada.contains(letra)) {
        _letrasAdivinadas.add(letra);
      } else {
        _letrasEquivocadas.add(letra);
      }
      _verificarFinDeJuego();
    });
  }

 void _verificarFinDeJuego() {
    String titulo = '';
    String contenido = '';
    Color color = Colors.transparent; 
    if (_juegoGanado()) {
        setState(() { 
            _partidasJugadas++;
            _partidasGanadas++;
            _guardarPuntuaciones();
        });
        titulo = '¡Felicidades! 🎉';
        contenido = '¡Has ganado! La palabra era $_palabraSeleccionada.';
        color = Colors.green;

        _mostrarDialogo(titulo, contenido, color);
    
    } else if (_letrasEquivocadas.length >= _maxIntentos) {
        setState(() { 
            _partidasJugadas++;
            _partidasPerdidas++;
            _guardarPuntuaciones();
        });
        titulo = '¡Has Perdido! 😵';
        contenido = 'La palabra era $_palabraSeleccionada. ¡Inténtalo de nuevo!';
        color = Colors.red;

        _mostrarDialogo(titulo, contenido, color);
    }
}

  void _mostrarDialogo(String titulo, String contenido, Color color) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(titulo, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
        content: Text(contenido, style: const TextStyle(fontSize: 16)),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _iniciarNuevoJuego();
            },
            child: const Text('Jugar de Nuevo', style: TextStyle(color: Colors.blue)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int intentosRestantes = _maxIntentos - _letrasEquivocadas.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('El Ahorcado - Flutter', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            AhorcadoImagen(errores: _letrasEquivocadas.length),
            
            const SizedBox(height: 25),

            PalabraOculta(
              palabra: _palabraSeleccionada,
              letrasAdivinadas: _letrasAdivinadas,
            ),

            const SizedBox(height: 30),
            
            _buildInfoCard(intentosRestantes),

            const SizedBox(height: 20),

            _construirTeclado(),

            const SizedBox(height: 30),

            _buildScoreBoard(),
          ],
        ),
      ),
    );
  }
  
  Widget _buildInfoCard(int intentosRestantes) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Text(
              'Intentos Restantes',
              style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
            ),
            const SizedBox(height: 5),
            Text(
              '$intentosRestantes',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: intentosRestantes <= 2 ? Colors.red : Colors.green,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Errores: ${_letrasEquivocadas.length} | Aciertos: ${_letrasAdivinadas.length}',
              style: const TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScoreBoard() {
    return Column(
      children: [
        const Text(
          'Histórico de Puntuaciones',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueGrey),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _scoreItem('Jugadas', _partidasJugadas, Colors.blue),
            _scoreItem('Ganadas', _partidasGanadas, Colors.green),
            _scoreItem('Perdidas', _partidasPerdidas, Colors.red),
          ],
        ),
      ],
    );
  }

  Widget _scoreItem(String titulo, int score, Color color) {
    return Column(
      children: [
        Text(titulo, style: TextStyle(fontSize: 14, color: color)),
        Text('$score', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: color)),
      ],
    );
  }
Widget _construirTeclado() {
    const String alfabeto = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    bool juegoActivo = _letrasEquivocadas.length < _maxIntentos && !_juegoGanado();

    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      alignment: WrapAlignment.center,
      children: alfabeto.split('').map<Widget>((letra) { 
        bool esAdivinada = _letrasAdivinadas.contains(letra);
        bool esEquivocada = _letrasEquivocadas.contains(letra);
        bool yaIntentada = esAdivinada || esEquivocada;

        return TecladoLetra(
          letra: letra,
          habilitado: juegoActivo && !yaIntentada,
          adivinada: esAdivinada,
          equivocada: esEquivocada,
          onPresionar: _manejarIntento,
        );
      }).toList(),
    );
  }
}



