import 'package:flutter/material.dart';
import 'package:perst/src/model/color_radio_model.dart';

class PersonalColorResult extends StatefulWidget {
  final PersonalColorModel PCM;
  final String season;
  final int personalCnt;

  const PersonalColorResult(
      {required this.PCM,
      required this.season,
      required this.personalCnt,
      Key? key})
      : super(key: key);

  @override
  State<PersonalColorResult> createState() => _PersonalColorResultState();
}

class _PersonalColorResultState extends State<PersonalColorResult> {
  @override
  void initState() {
    super.initState();
    List<int> values = [
      widget.PCM.SpringRight,
      widget.PCM.SpringBright,
      widget.PCM.SummerBright,
      widget.PCM.SummerMute,
      widget.PCM.SummerRight,
      widget.PCM.FallMute,
      widget.PCM.FallDeep,
      widget.PCM.FallStrong,
      widget.PCM.WinterDeep,
      widget.PCM.WinterBright,
    ];

    values.sort((a, b) => b.compareTo(a));

    for (int i = 0; i < 3 && i < values.length; i++) {
      print(values[i]);
    }
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
                "이다현",
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
                height: 130,
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
                        child: Text('여름 뮤트',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w600))),
                    SizedBox(height: 30),
                    Container(
                        width: 150,
                        child: Text('41.6%', style: TextStyle(fontSize: 10))),
                  ],
                ),
              ),
              SizedBox(width: 20),
              Container(
                width: 170,
                height: 130,
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
                        child: Text('여름 라이트',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w600)))
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
