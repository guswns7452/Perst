import 'package:flutter/material.dart';
import 'package:perst/src/screen/camera/cameraGuide.dart';

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
                height: 80,
                width: double.infinity,
                color: Colors.black,
              ),
            ],
          ),
          Positioned(
            bottom: 35.0,
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
                        foregroundColor: Colors.white,
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(30),
                        backgroundColor: Colors.white,
                      ),
                      child: Image.asset(
                        'assets/camera.png',
                        width: 30,
                        height: 30,
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
