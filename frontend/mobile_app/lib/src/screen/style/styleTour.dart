import 'package:flutter/material.dart';

class StyleTour extends StatelessWidget {
  const StyleTour({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Text(
          'Perst',
          style: TextStyle(
            fontSize: 45,
            fontWeight: FontWeight.bold,
            color: Color.fromRGBO(255, 191, 25, 1),
          ),
        ),
      ]),
    );
  }
}
