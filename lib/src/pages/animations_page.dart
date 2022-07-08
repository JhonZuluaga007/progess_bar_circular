import 'package:flutter/material.dart';
import 'dart:math' as math;

class AnimationsPage extends StatelessWidget {
  const AnimationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SquareAnimation(),
      ),
    );
  }
}

class SquareAnimation extends StatefulWidget {
  const SquareAnimation({
    Key? key,
  }) : super(key: key);

  @override
  State<SquareAnimation> createState() => _SquareAnimationState();
}

class _SquareAnimationState extends State<SquareAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> rotation;

  late Animation<double> opacity;
  late Animation<double> opacityOut;

  late Animation<double> moveRight;
  late Animation<double> enlarge;

  @override
  void initState() {
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 4000));
    rotation = Tween(begin: 0.0, end: 2 * math.pi).animate(
        CurvedAnimation(parent: animationController, curve: Curves.bounceOut));

    opacity = Tween(begin: 0.1, end: 1.0).animate(CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.0, 0.25, curve: Curves.easeInOut)));

    opacityOut = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.75, 1.0, curve: Curves.easeInOut)));

    moveRight = Tween(begin: 0.0, end: 200.0).animate(CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.0, 0.25, curve: Curves.easeInOut)));

    enlarge = Tween(begin: 0.0, end: 2.0).animate(CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.0, 0.25, curve: Curves.easeInOut)));

    animationController.addListener(() {
      print('Status: ${animationController.status}');
      if (animationController.status == AnimationStatus.completed) {
        animationController.repeat();
        //animationController.reverse();
        //animationController.reset();
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Play / Reproduction
    animationController.forward();
    return AnimatedBuilder(
      animation: animationController,
      child: _Rectangulo(),
      builder: (context, childRectangulo) {
        return Transform.translate(
          offset: Offset(moveRight.value, 0),
          child: Transform.rotate(
              angle: rotation.value,
              child: Opacity(
                opacity: opacity.value - opacityOut.value,
                child: Transform.scale(
                    scale: enlarge.value, child: childRectangulo),
              )),
        );
      },
    );
  }
}

class _Rectangulo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
      decoration: const BoxDecoration(color: Colors.blue),
    );
  }
}
