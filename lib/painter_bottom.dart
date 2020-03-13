import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomPainter extends CustomPainter {
  final BuildContext context;

  BottomPainter({this.context});

  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    Paint paint = Paint();
    path.addOval(Rect.fromCircle(center: Offset(size.width * 0.10, 00.0), radius: size.width * 0.30));

    paint.color = Theme.of(context).primaryColorLight;
    canvas.drawPath(path, paint);

    path = Path();
    path.addOval(Rect.fromCenter(center: Offset(size.width * 0.70, 20.0), height: 140.0, width: 120.0));

    path = Path();
    path.addOval(Rect.fromCenter(center: Offset(size.height, size.height * 0.70), height: 140.0, width: 120.0));

    path.close();

    paint.color = Theme.of(context).primaryColorLight;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
