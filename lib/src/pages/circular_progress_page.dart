import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class CircularProgressPage extends StatefulWidget {
  const CircularProgressPage({Key? key}) : super(key: key);

  @override
  State<CircularProgressPage> createState() => _CircularProgressPageState();
}

class _CircularProgressPageState extends State<CircularProgressPage>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late double percentage;
  late double newPercentage;

  @override
  void initState() {
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));

    percentage = 0.0;
    newPercentage = 0.0;

    animationController.addListener(() {
      //debugPrint('Valor controller: ${animationController.value}');
      setState(() {
        percentage =
            lerpDouble(percentage, newPercentage, animationController.value)!;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        backgroundColor: Colors.pink,
        onPressed: () {
          animationController.forward(from: 0.0);
          setState(() {
            percentage = newPercentage;
            newPercentage += 10;
            if (newPercentage > 100) {
              newPercentage = 0;
              percentage = 0;
            }
          });
        },
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(5),
          width: 300,
          height: 300,
          child: CustomPaint(painter: _MyRadialPainter(percentage: percentage)),
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
