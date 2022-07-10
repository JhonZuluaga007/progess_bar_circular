import 'dart:math';

import 'package:flutter/material.dart';

class CircularProgressPage extends StatefulWidget {
  const CircularProgressPage({Key? key}) : super(key: key);

  @override
  State<CircularProgressPage> createState() => _CircularProgressPageState();
}

class _CircularProgressPageState extends State<CircularProgressPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(5),
          width: 300,
          height: 300,
          child: CustomPaint(painter: _MyRadialPainter(percentage: 50)),
        ),
      ),
    );
  }
}

class _MyRadialPainter extends CustomPainter {
  final double percentage;
  _MyRadialPainter({required this.percentage});
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = 4
      ..color = Colors.grey
      ..style = PaintingStyle.stroke;

    final Offset center = Offset(size.width * 0.5, size.height / 2);
    final double radius = min(size.width * 0.5, size.height * 0.5);

    canvas.drawCircle(center, radius, paint);

    //Arco
    final paintBow = Paint()
      ..strokeWidth = 4
      ..color = Colors.pink
      ..style = PaintingStyle.stroke;

    //part that must be filled
    double arcAngle = 2 * pi * (percentage / 100);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2,
        arcAngle, false, paintBow);
  }

  @override
  bool shouldRepaint(_MyRadialPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(_MyRadialPainter oldDelegate) => false;
}
