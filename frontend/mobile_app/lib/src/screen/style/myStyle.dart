// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:perst/src/screen/camera/cameraIntro.dart';

class MyStyle extends StatelessWidget {
  const MyStyle({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            ' Perst',
            style: TextStyle(
                color: Color.fromRGBO(255, 191, 25, 1),
                fontSize: 40,
                fontWeight: FontWeight.bold),
          ),
          Text(
            '  my 스타일분석 이력',
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          // 분석한 이력들이 없을 때
          Container(
            width: double.infinity,
            height: 500,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/Closets.png', height: 80, width: 80),
                SizedBox(
                  height: 8,
                ),
                Text(
                  '등록한 스타일이 없어요.',
                  style: TextStyle(
                      fontSize: 15, color: Color.fromRGBO(153, 153, 153, 1)),
                )
              ],
            ),
          ),
        ],
      ),
      floatingActionButton:
          Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => CameraIntro(),
            ));
          },
          child: Image.asset('assets/add.png', height: 30, width: 30),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          backgroundColor: Colors.black,
        ),
        SizedBox(height: 15)
      ]),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
