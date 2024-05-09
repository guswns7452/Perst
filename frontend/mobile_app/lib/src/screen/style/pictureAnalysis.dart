import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:perst/src/screen/style/keywardFashion.dart';
import 'package:perst/src/widget/color_widget.dart';
import 'package:perst/src/widget/style_color_view.dart';

class PictureAnalysis extends StatelessWidget {
  final Map<String, dynamic> result;

  PictureAnalysis(this.result);

  @override
  Widget build(BuildContext context) {
    String styleName = result['styleName'] ?? '';

    List<Map<String, dynamic>> jsonData = [result];
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(20, 30, 20, 0),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Perst',
                  style: TextStyle(
                      color: Color.fromRGBO(255, 191, 25, 1),
                      fontSize: 35,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  '분석결과',
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.w600),
                ),
                Text(
                  ': 색 조합 분석 결과',
                  style: TextStyle(fontSize: 20),
                ),
                StyleColorView(result: result),
                Text(
                  ': 스타일 키워드',
                  style: TextStyle(fontSize: 20),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  padding: EdgeInsets.fromLTRB(10, 3, 10, 3),
                  child: Text(
                    styleName,
                    style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(62, 62, 62, 1),
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  height: 170,
                  width: double.infinity,
                  child: ThreeKeywordFashion(styleKeyword: styleName),
                ),
                SizedBox(height: 20),
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              KeywordFashion(styleKeyword: styleName),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/next.png',
                          height: 20,
                        ),
                        Text(
                          ' 내 스타일에 따른 추천 의류 보러가기',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15,
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
        ],
      ),
    );
  }
}
