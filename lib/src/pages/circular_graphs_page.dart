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
      body: Center(
        child: Container(
          width: 300,
          height: 300,
          child: RadialProgress(percentage: percentage),
        ),
      ),
    );
  }
}
