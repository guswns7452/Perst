import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          'Perst : 당신만을 위한 의류 스타일 추천 서비스',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      color: Color.fromRGBO(217, 217, 217, 1),
      width: double.infinity,
      height: 60,
    );
  }
}
