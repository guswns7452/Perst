import 'package:flutter/material.dart';
import 'package:kiosk/src/widget/camera_guide.dart';

class CameraIntro extends StatelessWidget {
  const CameraIntro({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    '사진을 찍고 스타일을 분석해보세요.',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              Container(
                height: 93,
                width: double.infinity,
                color: Colors.black,
              ),
              Container(
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
              ),
            ],
          ),
          Positioned(
            bottom: 85.0,
            left: 0,
            right: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CameraGuide()));
                      },
                      style: OutlinedButton.styleFrom(
                        shape: CircleBorder(),
                        primary: Colors.white,
                        padding: EdgeInsets.all(30),
                        backgroundColor: Colors.white,
                      ),
                      child: Image.asset(
                        'assets/camera.png',
                        width: 80,
                        height: 80,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
