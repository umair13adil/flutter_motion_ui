import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TopPainter extends CustomPainter {
  final BuildContext context;

  TopPainter({this.context});

  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    Paint paint = Paint();
    path.lineTo(0, size.height * 0.86);
    path.quadraticBezierTo(size.width * 0.10, size.height * 0.55, size.width * 0.22, size.height * 0.70);
    path.quadraticBezierTo(size.width * 0.35, size.height * 0.95, size.width, size.height * 0.60);
    path.lineTo(size.width, 0);
    path.close();

    paint.color = Theme.of(context).primaryColor;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
