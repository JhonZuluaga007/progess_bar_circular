import 'dart:math';

import 'package:flutter/material.dart';

class RadialProgress extends StatefulWidget {
  const RadialProgress({
    Key? key,
    required this.percentage,
    this.primaryColor = Colors.blue,
    this.secondaryColor = Colors.grey,
    this.primaryThickness = 6,
    this.secondaryThickness = 4,
  }) : super(key: key);

  final double percentage;
  final Color? primaryColor;
  final Color? secondaryColor;
  final double? primaryThickness;
  final double? secondaryThickness;

  @override
  State<RadialProgress> createState() => _RadialProgressState();
}

class _RadialProgressState extends State<RadialProgress>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late double percentageAfter;

  @override
  void initState() {
    percentageAfter = widget.percentage;
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    animationController.forward(from: 0.0);
    final differenceAnimate = widget.percentage - percentageAfter;
    percentageAfter = widget.percentage;

    return AnimatedBuilder(
        animation: animationController,
        builder: (context, chield) {
          return Container(
            padding: const EdgeInsets.all(10),
            width: double.infinity,
            height: double.infinity,
            child: CustomPaint(
              painter: _MyRadialPainter(
                percentage: (widget.percentage - differenceAnimate) +
                    (differenceAnimate * animationController.value),
                primaryColor: widget.primaryColor!,
                secondaryColor: widget.secondaryColor!,
                primaryThickness: widget.primaryThickness!,
                secondaryThickness: widget.secondaryThickness!,
              ),
            ),
          );
        });
  }
}

class _MyRadialPainter extends CustomPainter {
  final double percentage;
  final Color primaryColor;
  final Color secondaryColor;
  final double primaryThickness;
  final double secondaryThickness;
  _MyRadialPainter(
      {required this.percentage,
      required this.primaryColor,
      required this.secondaryColor,
      required this.primaryThickness,
      required this.secondaryThickness});
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = secondaryThickness
      ..color = secondaryColor
      ..style = PaintingStyle.stroke;

    final Offset center = Offset(size.width * 0.5, size.height / 2);
    final double radius = min(size.width * 0.5, size.height * 0.5);

    canvas.drawCircle(center, radius, paint);

    //Arco
    final paintBow = Paint()
      ..strokeCap = StrokeCap.round
      ..strokeWidth = primaryThickness
      ..color = primaryColor
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
