import 'package:flutter/material.dart';
import '../src/pages/circular_graphs_page.dart';
//import '../src/labs/circular_progress_page.dart';

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
      home: const CircularGraphsPage(),
    );
  }
}
