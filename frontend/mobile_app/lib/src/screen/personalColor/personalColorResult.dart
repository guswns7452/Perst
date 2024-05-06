import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:perst/src/controller/personal_color_controller.dart';
import 'package:perst/src/model/color_model.dart';
import 'package:perst/src/model/color_radio_model.dart';

final GetStorage _storage = GetStorage();

class PersonalColorResult extends StatefulWidget {
  final PersonalColorModel PCM;
  final String season;

  const PersonalColorResult({required this.PCM, required this.season, Key? key})
      : super(key: key);

  @override
  State<PersonalColorResult> createState() => _PersonalColorResultState();
}

class _PersonalColorResultState extends State<PersonalColorResult> {
  final personalColorController = Get.put(PersonalColorController());
  late Future<PersonalColor> personalColor;
  String name = _storage.read("name");

  @override
  Future<void> fetchData() async {
    List<personalResultModel> values = [
      personalResultModel(widget.PCM.SpringRight, widget.PCM.SSpringRight),
      personalResultModel(widget.PCM.SpringBright, widget.PCM.SSpringBright),
      personalResultModel(widget.PCM.SummerBright, widget.PCM.SSummerBright),
      personalResultModel(widget.PCM.SummerMute, widget.PCM.SSummerMute),
      personalResultModel(widget.PCM.SummerRight, widget.PCM.SSummerRight),
      personalResultModel(widget.PCM.FallMute, widget.PCM.SFallMute),
      personalResultModel(widget.PCM.FallDeep, widget.PCM.SFallDeep),
      personalResultModel(widget.PCM.FallStrong, widget.PCM.SFallStrong),
      personalResultModel(widget.PCM.WinterDeep, widget.PCM.SWinterDeep),
      personalResultModel(widget.PCM.WinterBright, widget.PCM.SWinterBright),
    ];

    values.sort((a, b) => b.count.compareTo(a.count));

    personalColor = await personalColorController.sendPersonalColor(
      widget.season,
      9,
      values[0].personalColor,
      values[1].personalColor,
      values[2].personalColor,
      values[0].count,
      values[1].count,
      values[2].count,
    );
    print(personalColor);
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Widget build(BuildContext context) {
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
                        child: Text("여름 라이트",
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w600))),
                    SizedBox(height: 10),
                    Container(
                        width: 150,
                        child: Text('41.6%', style: TextStyle(fontSize: 10))),
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
                          // TODO: 퍼센트에 따라서 퍼센트/100*150 계산해서 width에 넣기
                          width: 75,
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
                        child: Text("봄 라이트",
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w600))),
                    SizedBox(height: 10),
                    Container(
                        width: 150,
                        child: Text('41.6%', style: TextStyle(fontSize: 10))),
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
                          // TODO: 퍼센트에 따라서 퍼센트/100*150 계산해서 width에 넣기
                          width: 75,
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
                      color: Color.fromRGBO(167, 223, 195, 1),
                      borderRadius: BorderRadius.circular(8)),
                ),
                SizedBox(width: 20),
                Container(
                  height: 100,
                  width: 170,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(177, 167, 223, 1),
                      borderRadius: BorderRadius.circular(8)),
                ),
              ]),
              SizedBox(height: 15),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                  height: 100,
                  width: 170,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(167, 214, 223, 1),
                      borderRadius: BorderRadius.circular(8)),
                ),
                SizedBox(width: 20),
                Container(
                  height: 100,
                  width: 170,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(167, 186, 223, 1),
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
                color: Color.fromRGBO(189, 189, 189, 0.298 as int),
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
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Container(
                width: 233,
                height: 15,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 123, 123, 1),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10))),
              ),
              Container(
                width: 116,
                height: 15,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10)),
                    border: Border.all(color: Colors.black, width: 0.5)),
              ),
            ],
          ),
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
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Container(
                width: 233,
                height: 15,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 123, 123, 1),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10))),
              ),
              Container(
                width: 116,
                height: 15,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10)),
                    border: Border.all(color: Colors.black, width: 0.5)),
              ),
            ],
          ),
          SizedBox(height: 8),
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
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Container(
                width: 175,
                height: 15,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10)),
                    border: Border.all(color: Colors.black, width: 0.5)),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(left: 20, right: 20, top: 25),
            child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(backgroundColor: Colors.black),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
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
