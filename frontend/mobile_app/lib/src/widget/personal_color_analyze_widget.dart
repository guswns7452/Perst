import 'package:flutter/material.dart';

class backGround extends StatelessWidget {
  final Color backgroundColor;
  const backGround({required this.backgroundColor, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      color: backgroundColor,
    );
  }
}

class smallBackground extends StatelessWidget {
  final Color firstBackgroundColor;
  const smallBackground({required this.firstBackgroundColor, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 20,
      decoration: BoxDecoration(
          color: firstBackgroundColor, borderRadius: BorderRadius.circular(8)),
    );
  }
}

class bigBackground extends StatelessWidget {
  final Color firstBackgroundColor;
  const bigBackground({required this.firstBackgroundColor, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 20,
      decoration: BoxDecoration(
          color: firstBackgroundColor, borderRadius: BorderRadius.circular(8)),
    );
  }
}
