import 'package:flutter/material.dart';
import 'package:kiosk/src/screen/intro.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Intro(),
    );
  }
}
