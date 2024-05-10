import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:perst/src/connect/mypage_connect.dart';
import 'package:perst/src/screen/style/keywardFashion.dart';
import 'package:perst/src/widget/color_widget.dart';
import 'package:perst/src/widget/style_color_view.dart';

class StyleHistoryDetail extends StatefulWidget {
  final int number;

  StyleHistoryDetail({required this.number, Key? key}) : super(key: key);

  @override
  State<StyleHistoryDetail> createState() => _StyleHistoryDetailState();
}

class _StyleHistoryDetailState extends State<StyleHistoryDetail> {
  final mypageConnection = Get.put((MypageConnect()));
  late Map<String, dynamic>? result;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future _fetchData() async {
    setState(() {
      isLoading = true;
    });

    result = await mypageConnection.styleHistoryDetail(widget.number);

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    String styleName = result?['styleName'] ?? '';

    return isLoading
        ? Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '로딩중입니다...',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 20),
                  CircularProgressIndicator(),
                ],
              ),
            ),
          )
        : Scaffold(
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
                            fontSize: 45,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 20),
                      Text(
                        '분석결과',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w700),
                      ),
                      Text(
                        ': 색 조합 분석 결과',
                        style: TextStyle(fontSize: 20),
                      ),
                      StyleColorView(result: result),
                      SizedBox(height: 20),
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
                        height: 230,
                        width: double.infinity,
                        child: ThreeKeywordFashion(styleKeyword: styleName),
                      ),
                      SizedBox(height: 30),
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
                                    fontSize: 21,
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
