import 'package:flutter/material.dart';
import 'package:progess_bar_circular/src/widgets/radial_progress.dart';

class CircularGraphsPage extends StatefulWidget {
  const CircularGraphsPage({Key? key}) : super(key: key);

  @override
  State<CircularGraphsPage> createState() => _CircularGraphsPageState();
}

class _CircularGraphsPageState extends State<CircularGraphsPage> {
  late double percentage = 0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.refresh),
          onPressed: () {
            setState(() {
              percentage += 10;
              if (percentage > 100) {
                percentage = 0;
              }
            });
          },
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomRadialProgess(
                  percentage: percentage,
                  color: Colors.red,
                ),
                CustomRadialProgess(
                  percentage: percentage,
                  color: Colors.blue,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomRadialProgess(
                  percentage: percentage,
                  color: Colors.purple,
                ),
                CustomRadialProgess(percentage: percentage, color: Colors.pink),
              ],
            ),
          ],
        ));
  }
}

class CustomRadialProgess extends StatelessWidget {
  const CustomRadialProgess(
      {Key? key, required this.percentage, required this.color})
      : super(key: key);

  final double percentage;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      height: 180,
      child: RadialProgress(
        percentage: percentage,
        primaryColor: color,
        primaryThickness: 10,
      ),
    );
  }
}
