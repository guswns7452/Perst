// ignore_for_file: file_names
import 'package:flutter/material.dart';

class StyleAnalysisImage extends StatelessWidget {
  const StyleAnalysisImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 500,
                      color: const Color.fromRGBO(255, 191, 25, 1),
                    ),
                    Positioned(
                      top: 50,
                      /* child: Image(
                      image: AssetImage('assets/style.png'),
                    ), */
                      // 추후에 style 이미지로 대체할 예정
                      child: Container(
                        width: 300,
                        height: 550,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: const Text(
                        /* 이름은 api를 통해 불러온 계정에 저장되어 있는 이름으로 대체 예정 */
                        '전현준님의 스타일 분석 결과',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                      child: const Text(
                        ': Color 분석 결과',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // 색상을 표현하는 원형이 위젯으로 들어갈 예정
                    Container(
                      margin: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                      child: const Text(
                        '깔끔한 느낌의 스타일이군요!',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.fromLTRB(15, 15, 0, 0),
                          child: const Text(
                            ': 스타일 키워드',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          height: 25,
                          width: 80,
                          margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color.fromRGBO(255, 191, 25, 1),
                            ),
                            child: const Text(
                              '#캐주얼',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(15, 10, 0, 0),
                      child: const Text(
                        ': 패션분석',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(25, 0, 0, 0),
                      child: const Text(
                        '- 포인트 아이템 부족',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Container(
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '전현준님의 스타일 분석에 따른 의류 추천',
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
