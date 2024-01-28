import 'package:flutter/material.dart';
import 'package:perst/src/screen/auth/intro.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Intro(),
    );
  }
}
