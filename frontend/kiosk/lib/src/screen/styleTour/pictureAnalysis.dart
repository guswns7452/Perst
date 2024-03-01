import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kiosk/src/screen/styleTour/keywordFashion.dart';
import 'package:kiosk/src/widget/bottom_bar.dart';

class PictureAnalysis extends StatelessWidget {
  static const platform = MethodChannel('com.example.kiosk/android');
  const PictureAnalysis({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(40, 50, 20, 0),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Perst',
                  style: TextStyle(
                      color: Color.fromRGBO(255, 191, 25, 1),
                      fontSize: 50,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  '분석결과',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                ),
                Text(
                  ': 색 조합 분석 결과',
                  style: TextStyle(fontSize: 27),
                ),
                // TODO: 여기 사이에 색 분석한거 들어가야함.
                //   위젯으로 만들 예정
                //   2, 3, 4, 5, 6 color 조합 정도로 만들 예정
                //   일단 Sizedbox로 자리잡기
                SizedBox(
                  height: 300,
                ),
                Text(
                  ': 스타일 키워드',
                  style: TextStyle(fontSize: 27),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.fromLTRB(10, 3, 10, 3),
                  child: Text(
                    // 여기에 키워드 분석한 결과 넣기.
                    '캐주얼',
                    style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 191, 25, 1),
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(50, 0, 50, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        'assets/fashion.png',
                        height: 300,
                      ),
                      Image.asset(
                        'assets/fashion.png',
                        height: 300,
                      ),
                      Image.asset(
                        'assets/fashion.png',
                        height: 300,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 50),
                Center(
                  // 여기 넘어갈때 스타일 키워드 넘겨주기!
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const KeywordFashion()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/next.png',
                          height: 30,
                        ),
                        Text(
                          ' 내 스타일에 따른 추천 의류 보러가기',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                      ],
                    ),
                    style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7),
                        ),
                        backgroundColor: Colors.black),
                  ),
                ),
              ],
            ),
          ),
          BottomBar(),
        ],
      ),
    );
  }
}
