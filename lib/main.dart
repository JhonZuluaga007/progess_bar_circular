import 'package:flutter/material.dart';
import 'package:progess_bar_circular/src/pages/animations_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ProgressBarCircular App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AnimationsPage(),
    );
  }
}
