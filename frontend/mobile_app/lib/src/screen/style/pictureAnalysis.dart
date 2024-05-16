import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:perst/src/screen/style/keywardFashion.dart';
import 'package:perst/src/widget/style_color_view.dart';
import '../../widget/google_drive_image.dart';
import '../../widget/keyward_fashion_widget.dart';

class PictureAnalysis extends StatelessWidget {
  final Map<String, dynamic> result;

  PictureAnalysis(this.result);

  @override
  Widget build(BuildContext context) {
    String styleName = result['styleName'] ?? '';
    String styleImageId = result['styleFileID'] ?? '';

    List<Map<String, dynamic>> jsonData = [result];
    return Scaffold(
      body: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ' Perst',
                      style: TextStyle(
                          color: Color.fromRGBO(255, 191, 25, 1),
                          fontSize: 45,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Container(
                          width: 300,
                          height: 470,
                          child: google_drive_image(id: styleImageId)),
                    ),
                    SizedBox(height: 20),
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '분석결과',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w800),
                          ),
                          Text(
                            ': 색 조합',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                          StyleColorView(result: result),
                          SizedBox(height: 20),
                          Text(
                            ': 스타일 키워드',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            padding: EdgeInsets.fromLTRB(10, 3, 10, 3),
                            child: Text(
                              styleName,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(62, 62, 62, 1),
                              borderRadius: BorderRadius.circular(7),
                            ),
                          ),
                          SizedBox(height: 15),
                          Container(
                            height: 200,
                            width: double.infinity,
                            child: ThreeKeywordFashion(styleKeyword: styleName),
                          ),
                          SizedBox(height: 15),
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
                              child: Text(
                                '➤ 내 스타일에 따른 추천 의류 보러가기',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 21,
                                    fontWeight: FontWeight.w600,
                                    color: const Color.fromARGB(255, 0, 0, 0)),
                              ),
                              style: TextButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                  backgroundColor: Colors.transparent),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15)
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
    ;
  }
}
