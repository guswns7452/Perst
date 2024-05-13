import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:perst/src/connect/personal_color_connect.dart';
import 'package:perst/src/model/color_model.dart';
import 'package:perst/src/model/color_radio_model.dart';

final GetStorage _storage = GetStorage();

class PersonalColorResult extends StatefulWidget {
  final String season;
  final List<Map<String, dynamic>> personalSelects;

  const PersonalColorResult(
      {Key? key, required this.season, required this.personalSelects})
      : super(key: key);

  @override
  State<PersonalColorResult> createState() => _PersonalColorResultState();
}

class _PersonalColorResultState extends State<PersonalColorResult> {
  final personalColorConnection = Get.put(PersonalColorConnect());
  late Map<String, dynamic> result;
  late int personalSelectTimesFirst;
  late int personalSelectTimesSecond;
  late String firstRatio;
  late String secondRatio;
  late double firstWidth;
  late double secondWidth;
  late String hue;
  late String saturation;
  late String value;
  late List<ResultColorList> colorList;
  bool isLoading = true;
  String name = _storage.read("name");

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
    });

    result = await personalColorConnection.personalAnalyze(
        widget.personalSelects[0]['personalSelectType'],
        9,
        widget.personalSelects);

    setState(() {
      colorList = [
        ResultColorList(
            result["personalColorRepresentative"][0]["red"],
            result["personalColorRepresentative"][0]["green"],
            result["personalColorRepresentative"][0]["blue"]),
        ResultColorList(
            result["personalColorRepresentative"][1]["red"],
            result["personalColorRepresentative"][1]["green"],
            result["personalColorRepresentative"][1]["blue"]),
        ResultColorList(
            result["personalColorRepresentative"][2]["red"],
            result["personalColorRepresentative"][2]["green"],
            result["personalColorRepresentative"][2]["blue"]),
        ResultColorList(
            result["personalColorRepresentative"][3]["red"],
            result["personalColorRepresentative"][3]["green"],
            result["personalColorRepresentative"][3]["blue"])
      ];

      firstRatio =
          (result["personalSelects"][0]["personalSelectTimes"] / 9 * 100)
              .toStringAsFixed(2);
      secondRatio =
          (result["personalSelects"][1]["personalSelectTimes"] / 9 * 100)
              .toStringAsFixed(2);
      String firstWidthSt =
          (result["personalSelects"][0]["personalSelectTimes"] / 9 * 150)
              .toStringAsFixed(2);
      firstWidth = double.parse(firstWidthSt);
      String secondWidthSt =
          (result["personalSelects"][1]["personalSelectTimes"] / 9 * 150)
              .toStringAsFixed(2);
      secondWidth = double.parse(secondWidthSt);
    });

    hue = result["personalColorInfo"]["hue"];
    saturation = result["personalColorInfo"]["saturation"];
    value = result["personalColorInfo"]["value"];

    setState(() {
      isLoading = false;
    });
  }

  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '분석중입니다...',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
              CircularProgressIndicator(),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '퍼스널컬러 결과',
          textAlign: TextAlign.start,
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
      body: Column(
        children: [
          Row(
            children: [
              SizedBox(width: 20),
              Text(
                name,
                style: TextStyle(
                    fontSize: 25,
                    color: Color.fromRGBO(255, 191, 25, 1),
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "님의 퍼스널컬러 진단 결과",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              )
            ],
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 170,
                height: 110,
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.4),
                        blurRadius: 4.0,
                        offset: const Offset(0, 7),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    Row(
                      children: [
                        SizedBox(width: 10),
                        Text(
                          '1',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              height: 1.0),
                        ),
                        Text(
                          '순위',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              height: 2.0),
                        ),
                      ],
                    ),
                    Container(
                        width: 150,
                        child: Text(
                            "${result["personalSelects"][0]["personalSelectType"]}",
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w600))),
                    SizedBox(height: 10),
                    Container(
                        width: 150,
                        child:
                            Text(firstRatio, style: TextStyle(fontSize: 10))),
                    Stack(
                      children: [
                        Container(
                          width: 150,
                          height: 10,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.black, width: 1),
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        Container(
                          width: firstWidth,
                          height: 10,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10)),
                            color: Colors.black,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(width: 20),
              Container(
                width: 170,
                height: 110,
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.4),
                        blurRadius: 4.0,
                        offset: const Offset(0, 7),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    Row(
                      children: [
                        SizedBox(width: 10),
                        Text(
                          '2',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              height: 1.0),
                        ),
                        Text(
                          '순위',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              height: 2.0),
                        )
                      ],
                    ),
                    Container(
                        width: 150,
                        child: Text(
                            "${result["personalSelects"][1]["personalSelectType"]}",
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w600))),
                    SizedBox(height: 10),
                    Container(
                        width: 150,
                        child:
                            Text(secondRatio, style: TextStyle(fontSize: 10))),
                    Stack(
                      children: [
                        Container(
                          width: 150,
                          height: 10,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.black, width: 1),
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        Container(
                          width: secondWidth,
                          height: 10,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10)),
                            color: Colors.black,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Container(
            width: double.infinity,
            child: Text(
              '   컬러 팔레트',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          Column(
            children: [
              SizedBox(height: 15),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                  height: 100,
                  width: 170,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(colorList[0].red,
                          colorList[0].green, colorList[0].blue, 1),
                      borderRadius: BorderRadius.circular(8)),
                ),
                SizedBox(width: 20),
                Container(
                  height: 100,
                  width: 170,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(colorList[1].red,
                          colorList[1].green, colorList[1].blue, 1),
                      borderRadius: BorderRadius.circular(8)),
                ),
              ]),
              SizedBox(height: 15),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                  height: 100,
                  width: 170,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(colorList[2].red,
                          colorList[2].green, colorList[2].blue, 1),
                      borderRadius: BorderRadius.circular(8)),
                ),
                SizedBox(width: 20),
                Container(
                  height: 100,
                  width: 170,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(colorList[3].red,
                          colorList[3].green, colorList[3].blue, 1),
                      borderRadius: BorderRadius.circular(8)),
                ),
              ]),
            ],
          ),
          SizedBox(height: 18),
          Container(
            width: double.infinity,
            child: Text(
              '   퍼스널 컬러 정보',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            height: 1,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Color.fromRGBO(189, 189, 189, 1),
                borderRadius: BorderRadius.circular(50)),
            margin: EdgeInsets.fromLTRB(15, 8, 15, 8),
          ),
          Container(
            width: double.infinity,
            child: Text(
              '       명도',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            margin: EdgeInsets.only(bottom: 10),
          ),
          Stack(
            children: [
              Container(
                width: 350,
                height: 15,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black, width: 0.5)),
              ),
              Container(
                  margin: EdgeInsets.only(top: 0.5),
                  width: 117,
                  height: 14,
                  decoration: BoxDecoration(
                      color: value == "low"
                          ? Color.fromRGBO(217, 217, 217, 1)
                          : Colors.transparent,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10)))),
              Container(
                  margin: EdgeInsets.only(left: 116, top: 0.5),
                  width: 117,
                  height: 14,
                  decoration: BoxDecoration(
                    color: value == "middle"
                        ? Color.fromRGBO(217, 217, 217, 1)
                        : Colors.transparent,
                  )),
              Container(
                margin: EdgeInsets.only(left: 232, top: 0.5),
                width: 117,
                height: 14,
                decoration: BoxDecoration(
                    color: value == "top"
                        ? Color.fromRGBO(217, 217, 217, 1)
                        : Colors.transparent,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10))),
              ),
            ],
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(
              margin: EdgeInsets.only(left: 32, top: 3),
              child: Text(
                '낮음',
                style: TextStyle(fontSize: 8),
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 32, top: 3),
              child: Text(
                '높음',
                style: TextStyle(fontSize: 8),
              ),
            ),
          ]),
          SizedBox(height: 8),
          Container(
            width: double.infinity,
            child: Text(
              '       채도',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            margin: EdgeInsets.only(bottom: 10),
          ),
          Stack(
            children: [
              Container(
                width: 350,
                height: 15,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black, width: 0.5)),
              ),
              Container(
                  margin: EdgeInsets.only(top: 0.5),
                  width: 117,
                  height: 14,
                  decoration: BoxDecoration(
                      color: saturation.toString() == "low"
                          ? Color.fromRGBO(217, 217, 217, 1)
                          : Colors.transparent,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10)))),
              Container(
                  margin: EdgeInsets.only(left: 116, top: 0.5),
                  width: 117,
                  height: 14,
                  decoration: BoxDecoration(
                    color: saturation.toString() == "middle"
                        ? Color.fromRGBO(217, 217, 217, 1)
                        : Colors.transparent,
                  )),
              Container(
                margin: EdgeInsets.only(left: 232, top: 0.5),
                width: 117,
                height: 14,
                decoration: BoxDecoration(
                    color: saturation == "top"
                        ? Color.fromRGBO(217, 217, 217, 1)
                        : Colors.transparent,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10))),
              ),
            ],
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(
              margin: EdgeInsets.only(left: 32, top: 3),
              child: Text(
                '낮음',
                style: TextStyle(fontSize: 8),
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 32, top: 3),
              child: Text(
                '높음',
                style: TextStyle(fontSize: 8),
              ),
            ),
          ]),
          SizedBox(height: 8),
          Container(
            width: double.infinity,
            child: Text(
              '       색감',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            margin: EdgeInsets.only(bottom: 10),
          ),
          Stack(
            children: [
              Container(
                width: 350,
                height: 15,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black, width: 0.5)),
              ),
              Container(
                margin: EdgeInsets.only(top: 0.5, left: 1),
                width: 175,
                height: 14,
                decoration: BoxDecoration(
                    color: hue == "warm"
                        ? Color.fromRGBO(217, 217, 217, 1)
                        : Colors.transparent,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10))),
              ),
              Container(
                margin: EdgeInsets.only(left: 175, top: 0.5),
                width: 175,
                height: 14,
                decoration: BoxDecoration(
                    color: hue == "cool"
                        ? Color.fromRGBO(217, 217, 217, 1)
                        : Colors.transparent,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10))),
              )
            ],
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(
              margin: EdgeInsets.only(left: 32, top: 3),
              child: Text(
                '웜',
                style: TextStyle(fontSize: 8),
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 32, top: 3),
              child: Text(
                '쿨',
                style: TextStyle(fontSize: 8),
              ),
            ),
          ]),
          Container(
            margin: EdgeInsets.only(left: 20, right: 20, top: 12),
            child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(backgroundColor: Colors.black),
                child: Row(
                  children: [
                    Image.asset('assets/arrow-right.png',
                        height: 20, width: 20),
                    SizedBox(width: 10),
                    Text(
                      '내 진단 결과에 따른 코디 보러가기',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                )),
          )
        ],
      ),
    );
  }
}
