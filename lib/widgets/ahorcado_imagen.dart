import 'package:flutter/material.dart';

class AhorcadoImagen extends StatelessWidget {
  final int errores;
  const AhorcadoImagen({super.key, required this.errores});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 250,
        height: 250,
        child: CustomPaint(painter: _AhorcadoPainter(errores: errores)),
      ),
    );
  }
}

class _AhorcadoPainter extends CustomPainter {
  final int errores;
  _AhorcadoPainter({required this.errores});
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 4.0
      ..style = PaintingStyle.stroke;
    final double centroX = size.width / 2;
    final double topeY = 20;
    final double baseY = size.height - 10;
    final double cuerdaX = centroX + 50;
    canvas.drawLine(Offset(0, baseY), Offset(size.width, baseY), paint);
    canvas.drawLine(Offset(centroX, baseY), Offset(centroX, topeY), paint);
    canvas.drawLine(Offset(centroX, topeY), Offset(cuerdaX, topeY), paint);
    canvas.drawLine(Offset(cuerdaX, topeY), Offset(cuerdaX, topeY + 20), paint);
    if (errores >= 1) {
      canvas.drawCircle(Offset(cuerdaX, topeY + 40), 20, paint);
    }
    if (errores >= 2) {
      canvas.drawLine(
        Offset(cuerdaX, topeY + 60),
        Offset(cuerdaX, topeY + 120),
        paint,
      );
    }
    if (errores >= 3) {
      canvas.drawLine(
        Offset(cuerdaX, topeY + 70),
        Offset(cuerdaX - 25, topeY + 95),
        paint,
      );
    }
    if (errores >= 4) {
      canvas.drawLine(
        Offset(cuerdaX, topeY + 70),
        Offset(cuerdaX + 25, topeY + 95),
        paint,
      );
    }
    if (errores >= 5) {
      canvas.drawLine(
        Offset(cuerdaX, topeY + 120),
        Offset(cuerdaX - 25, topeY + 145),
        paint,
      );
    }
    if (errores >= 6) {
      canvas.drawLine(
        Offset(cuerdaX, topeY + 120),
        Offset(cuerdaX + 25, topeY + 145),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _AhorcadoPainter oldDelegate) {
    return oldDelegate.errores != errores;
  }
}
