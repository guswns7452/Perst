import 'package:flutter/material.dart';

class Colorwidget1 extends StatelessWidget {
  const Colorwidget1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.black),
            ),
            Container(
              width: 90,
              height: 90,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromARGB(255, 109, 109, 109)),
            ),
            Container(
              width: 80,
              height: 80,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromARGB(255, 203, 203, 203)),
            ),
          ],
        ),
      ),
    );
  }
}
