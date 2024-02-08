import 'package:flutter/material.dart';
import 'package:kiosk/src/widget/bottom_bar.dart';
import 'package:kiosk/src/widget/phonenumber_keyboard.dart';

class Phonenumber extends StatelessWidget {
  const Phonenumber({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 200,
              ),
              Text(
                '      휴대폰 번호를 입력해주세요.',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                ),
              ),
              phonenumber_keyboard(),
            ],
          ),
          BottomBar(),
        ],
      ),
    );
  }
}
