import 'package:flutter/material.dart';
import 'package:kiosk/src/screen/auth/phonenumber.dart';
import 'package:kiosk/src/screen/camera/cameraIntro.dart';

class Intro extends StatelessWidget {
  const Intro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(left: 30),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Perst',
                      style: TextStyle(
                        fontSize: 70,
                        fontWeight: FontWeight.w700,
                        color: Color.fromRGBO(249, 212, 35, 1),
                      ),
                    ),
                    Text(
                      '당신만을 위한 의류 스타일 추천',
                      style: TextStyle(
                        color: Color.fromRGBO(146, 146, 146, 1),
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(30, 10, 20, 10),
                padding: EdgeInsets.fromLTRB(15, 15, 10, 15),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Color.fromRGBO(249, 212, 35, 1),
                ),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(left: 10),
                      child: Text(
                        '내 스타일 분석해보기',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Text(
                        '현재 내가 입고있는 옷을 등록하고, 내 정보를 입력해보세요!\n제가 분석해드릴께요!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        TextButton(
                          style: TextButton.styleFrom(
                            primary: Color.fromRGBO(103, 103, 103, 1),
                            textStyle: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                            backgroundColor: Colors.white,
                            padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const CameraIntro()));
                          },
                          child: const Text('사진 찍으러 가기'),
                        ),
                        Image.asset(
                          'assets/fashion_designer.png',
                          width: 90,
                          height: 90,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 5, 10, 20),
                padding: EdgeInsets.fromLTRB(10, 0, 10, 15),
                width: double.infinity,
                child: Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(15, 14, 10, 14),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(77, 83, 241, 0.7),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '스타일 둘러보기',
                              style: TextStyle(
                                fontSize: 23,
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              '원하는 스타일을 선택해보세요!\n더 많은 코디를 볼 수 있어요!',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                TextButton(
                                  style: TextButton.styleFrom(
                                    primary: Color.fromRGBO(103, 103, 103, 1),
                                    textStyle: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    backgroundColor: Colors.white,
                                    padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                                  ),
                                  onPressed: () {},
                                  child: const Text(
                                    '둘러보기',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ),
                                Image.asset(
                                  'assets/keyword.png',
                                  width: 70,
                                  height: 70,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Flexible(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(15, 14, 10, 14),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(255, 41, 170, 0.78),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '휴대전화 연동하기',
                              style: TextStyle(
                                fontSize: 23,
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              '휴대전화와 연동하여 정보를 입력해보세요!\n편하게 내 스타일을 둘러볼 수 있어요!',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                TextButton(
                                  style: TextButton.styleFrom(
                                    primary: Color.fromRGBO(103, 103, 103, 1),
                                    textStyle: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    backgroundColor: Colors.white,
                                    padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Phonenumber()));
                                  },
                                  child: const Text(
                                    '연동하기',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ),
                                Image.asset(
                                  'assets/smartphone.png',
                                  width: 70,
                                  height: 70,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(230, 20, 230, 180),
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    minimumSize: Size.zero,
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '매장 지도 보러가기  ',
                        style: TextStyle(
                          fontSize: 23,
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Image.asset(
                        'assets/map.png',
                        width: 30,
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),
            ],
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
    );
  }
}
