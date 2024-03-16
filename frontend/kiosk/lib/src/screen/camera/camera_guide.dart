import 'package:flutter/material.dart';
import 'package:kiosk/src/screen/camera/camera.dart';
import 'package:kiosk/src/widget/bottom_bar.dart';

class CameraGuide extends StatelessWidget {
  const CameraGuide({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(65, 65, 65, 0.91),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                SizedBox(
                  height: 160,
                ),
                Container(
                  width: 500,
                  child: Text(
                    '사진 가이드',
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                Container(
                  width: 500,
                  child: Text(
                    '양 발끝을 선에 맞춰서 정자세로 서주세요.',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w200,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 30),
                  width: 500,
                  height: 635,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                      width: 4,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Image.asset('assets/man.png'),
                  alignment: Alignment.bottomCenter,
                ),
              ],
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CameraScreen()));
              },
              child: Text(
                '사진 찍으러 가기',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              style: TextButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
              ),
            ),
            BottomBar(),
          ],
        ),
      ),
    );
  }
}
