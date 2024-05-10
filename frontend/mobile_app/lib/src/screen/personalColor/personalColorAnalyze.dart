import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:perst/src/model/color_radio_model.dart';
import 'package:perst/src/screen/personalColor/personalColorResult.dart';
import 'package:perst/src/widget/personal_color_analyze_widget.dart';

class PersonalColorAnalyze extends StatefulWidget {
  const PersonalColorAnalyze({super.key});

  @override
  State<PersonalColorAnalyze> createState() => _PersonalColorAnalyzeState();
}

class _PersonalColorAnalyzeState extends State<PersonalColorAnalyze> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    // 카메라 초기화
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    // 사용 가능한 카메라 목록 가져오기
    final cameras = await availableCameras();
    // 전면 카메라 사용
    _controller = CameraController(
        cameras.firstWhere(
            (camera) => camera.lensDirection == CameraLensDirection.front),
        ResolutionPreset.high);

    // 컨트롤러 초기화
    _initializeControllerFuture = _controller.initialize();
    setState(() {});
  }

  int firstColorIndex = 0;
  int secondColorIndex = 1;
  int thirdColorIndex = 2;
  int index = 0;
  int warm = 0;
  int cool = 0;
  int springCnt = 0;
  int summerCnt = 0;
  int fallCnt = 0;
  int winterCnt = 0;
  int personalCnt = 0;
  String season = '';
  bool isLoading = false;

  PersonalColorModel updatePCM = PersonalColorModel(
      0,
      "봄 라이트",
      0,
      "봄 브라이트",
      0,
      "여름 라이트",
      0,
      "여름 브라이트",
      0,
      "여름 뮤트",
      0,
      "가을 뮤트",
      0,
      "가을 스트롱",
      0,
      "가을 딥",
      0,
      "겨울 브라이트",
      0,
      "겨울 딥");

  late Color firstBackgroundColor,
      secondBackgroundColor,
      thirdBackgroundColor,
      backgroundColor;

  @override
  Widget build(BuildContext context) {
    if (warm + cool < 5 &&
        fallCnt + springCnt == 0 &&
        winterCnt + summerCnt == 0) {
      firstBackgroundColor = Color.fromRGBO(
          warmCool[firstColorIndex].Red,
          warmCool[firstColorIndex].Green,
          warmCool[firstColorIndex].Blue,
          warmCool[firstColorIndex].O);
      secondBackgroundColor = Color.fromRGBO(
          warmCool[secondColorIndex].Red,
          warmCool[secondColorIndex].Green,
          warmCool[secondColorIndex].Blue,
          warmCool[secondColorIndex].O);
      backgroundColor = Color.fromRGBO(warmCool[index].Red,
          warmCool[index].Green, warmCool[index].Blue, warmCool[index].O);
    }
    if (warm + cool == 4 && personalCnt >= 4 && personalCnt <= 8) {
      if (warm >= cool) {
        firstBackgroundColor = Color.fromRGBO(
            fallspring[firstColorIndex].Red,
            fallspring[firstColorIndex].Green,
            fallspring[firstColorIndex].Blue,
            fallspring[firstColorIndex].O);
        secondBackgroundColor = Color.fromRGBO(
            fallspring[secondColorIndex].Red,
            fallspring[secondColorIndex].Green,
            fallspring[secondColorIndex].Blue,
            fallspring[secondColorIndex].O);
        backgroundColor = Color.fromRGBO(
            fallspring[index].Red,
            fallspring[index].Green,
            fallspring[index].Blue,
            fallspring[index].O);
      } else if (warm < cool) {
        firstBackgroundColor = Color.fromRGBO(
            summerWinter[firstColorIndex].Red,
            summerWinter[firstColorIndex].Green,
            summerWinter[firstColorIndex].Blue,
            summerWinter[firstColorIndex].O);
        secondBackgroundColor = Color.fromRGBO(
            summerWinter[secondColorIndex].Red,
            summerWinter[secondColorIndex].Green,
            summerWinter[secondColorIndex].Blue,
            summerWinter[secondColorIndex].O);
        backgroundColor = Color.fromRGBO(
            summerWinter[index].Red,
            summerWinter[index].Green,
            summerWinter[index].Blue,
            summerWinter[index].O);
      }
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '퍼스널컬러 검사',
          textAlign: TextAlign.start,
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
      body: Stack(
        children: [
          backGround(backgroundColor: backgroundColor),
          Center(
            child: Container(
              width: 250,
              height: 300,
              child: FutureBuilder<void>(
                future: _initializeControllerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    // 카메라 미리보기가 준비되면 카메라 미리보기를 반환
                    return _buildCameraPreview();
                  } else {
                    // 그렇지 않으면 로딩 인디케이터를 반환
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.only(right: 15),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            color: personalCnt == 10
                                ? Colors.transparent
                                : Colors.black),
                        borderRadius: BorderRadius.circular(10)),
                    child: personalCnt > -1 && personalCnt <= 8
                        ? Row(
                            children: [
                              Radio(
                                value: firstColorIndex,
                                groupValue: index,
                                onChanged: (value) {
                                  setState(() {
                                    index = value as int;
                                  });
                                },
                              ),
                              Container(
                                width: 70,
                                height: 20,
                                decoration: BoxDecoration(
                                    color: firstBackgroundColor,
                                    borderRadius: BorderRadius.circular(8)),
                              ),
                              Radio(
                                value: secondColorIndex,
                                groupValue: index,
                                onChanged: (value) {
                                  setState(() {
                                    index = value as int;
                                  });
                                },
                              ),
                              Container(
                                width: 70,
                                height: 20,
                                decoration: BoxDecoration(
                                    color: secondBackgroundColor,
                                    borderRadius: BorderRadius.circular(8)),
                              ),
                            ],
                          )
                        : personalCnt == 9 &&
                                (winterCnt + summerCnt > fallCnt + springCnt)
                            ? winterCnt <= summerCnt
                                ? Row(
                                    children: [
                                      Radio(
                                        value: firstColorIndex,
                                        groupValue: index,
                                        onChanged: (value) {
                                          setState(() {
                                            index = value as int;
                                            backgroundColor = Color.fromRGBO(
                                                summer[0].Red,
                                                summer[0].Green,
                                                summer[0].Blue,
                                                summer[0].O);
                                            isLoading = true;
                                          });
                                        },
                                      ),
                                      smallBackground(
                                          firstBackgroundColor: Color.fromRGBO(
                                              summer[0].Red,
                                              summer[0].Green,
                                              summer[0].Blue,
                                              summer[0].O)),
                                      Radio(
                                        value: secondColorIndex,
                                        groupValue: index,
                                        onChanged: (value) {
                                          setState(() {
                                            index = value as int;
                                            backgroundColor = Color.fromRGBO(
                                                summer[1].Red,
                                                summer[1].Green,
                                                summer[1].Blue,
                                                summer[1].O);
                                            isLoading = true;
                                          });
                                        },
                                      ),
                                      smallBackground(
                                          firstBackgroundColor: Color.fromRGBO(
                                              summer[1].Red,
                                              summer[1].Green,
                                              summer[1].Blue,
                                              summer[1].O)),
                                      Radio(
                                        value: thirdColorIndex,
                                        groupValue: index,
                                        onChanged: (value) {
                                          setState(() {
                                            index = value as int;
                                            backgroundColor = Color.fromRGBO(
                                                summer[2].Red,
                                                summer[2].Green,
                                                summer[2].Blue,
                                                summer[2].O);
                                            isLoading = true;
                                          });
                                        },
                                      ),
                                      smallBackground(
                                          firstBackgroundColor: Color.fromRGBO(
                                              summer[2].Red,
                                              summer[2].Green,
                                              summer[2].Blue,
                                              summer[2].O)),
                                    ],
                                  )
                                : Row(
                                    children: [
                                      Radio(
                                        value: firstColorIndex,
                                        groupValue: index,
                                        onChanged: (value) {
                                          setState(() {
                                            index = value as int;
                                            backgroundColor = Color.fromRGBO(
                                                winter[0].Red,
                                                winter[0].Green,
                                                winter[0].Blue,
                                                winter[0].O);
                                            isLoading = true;
                                          });
                                        },
                                      ),
                                      bigBackground(
                                          firstBackgroundColor: Color.fromRGBO(
                                              winter[0].Red,
                                              winter[0].Green,
                                              winter[0].Blue,
                                              winter[0].O)),
                                      Radio(
                                        value: secondColorIndex,
                                        groupValue: index,
                                        onChanged: (value) {
                                          setState(() {
                                            index = value as int;
                                            backgroundColor = Color.fromRGBO(
                                                winter[1].Red,
                                                winter[1].Green,
                                                winter[1].Blue,
                                                winter[1].O);
                                            isLoading = true;
                                          });
                                        },
                                      ),
                                      bigBackground(
                                          firstBackgroundColor: Color.fromRGBO(
                                              winter[1].Red,
                                              winter[1].Green,
                                              winter[1].Blue,
                                              winter[1].O)),
                                    ],
                                  )
                            : fallCnt >= springCnt && personalCnt == 9
                                ? Row(
                                    children: [
                                      Radio(
                                        value: firstColorIndex,
                                        groupValue: index,
                                        onChanged: (value) {
                                          setState(() {
                                            index = value as int;
                                            backgroundColor = Color.fromRGBO(
                                                fall[0].Red,
                                                fall[0].Green,
                                                fall[0].Blue,
                                                fall[0].O);
                                            isLoading = true;
                                          });
                                        },
                                      ),
                                      smallBackground(
                                          firstBackgroundColor: Color.fromRGBO(
                                              fall[0].Red,
                                              fall[0].Green,
                                              fall[0].Blue,
                                              fall[0].O)),
                                      Radio(
                                        value: secondColorIndex,
                                        groupValue: index,
                                        onChanged: (value) {
                                          setState(() {
                                            index = value as int;
                                            backgroundColor = Color.fromRGBO(
                                                fall[1].Red,
                                                fall[1].Green,
                                                fall[1].Blue,
                                                fall[1].O);
                                            isLoading = true;
                                          });
                                        },
                                      ),
                                      smallBackground(
                                          firstBackgroundColor: Color.fromRGBO(
                                              fall[1].Red,
                                              fall[1].Green,
                                              fall[1].Blue,
                                              fall[1].O)),
                                      Radio(
                                        value: thirdColorIndex,
                                        groupValue: index,
                                        onChanged: (value) {
                                          setState(() {
                                            index = value as int;
                                            backgroundColor = Color.fromRGBO(
                                                fall[2].Red,
                                                fall[2].Green,
                                                fall[2].Blue,
                                                fall[2].O);
                                            isLoading = true;
                                          });
                                        },
                                      ),
                                      smallBackground(
                                          firstBackgroundColor: Color.fromRGBO(
                                              fall[2].Red,
                                              fall[2].Green,
                                              fall[2].Blue,
                                              fall[2].O)),
                                    ],
                                  )
                                : personalCnt == 9
                                    ? Row(
                                        children: [
                                          Radio(
                                            value: firstColorIndex,
                                            groupValue: index,
                                            onChanged: (value) {
                                              setState(() {
                                                index = value as int;
                                                backgroundColor =
                                                    Color.fromRGBO(
                                                        spring[0].Red,
                                                        spring[0].Green,
                                                        spring[0].Blue,
                                                        spring[0].O);
                                                isLoading = true;
                                              });
                                            },
                                          ),
                                          bigBackground(
                                              firstBackgroundColor:
                                                  Color.fromRGBO(
                                                      spring[0].Red,
                                                      spring[0].Green,
                                                      spring[0].Blue,
                                                      spring[0].O)),
                                          Radio(
                                            value: secondColorIndex,
                                            groupValue: index,
                                            onChanged: (value) {
                                              setState(() {
                                                index = value as int;
                                                backgroundColor =
                                                    Color.fromRGBO(
                                                        spring[1].Red,
                                                        spring[1].Green,
                                                        spring[1].Blue,
                                                        spring[1].O);
                                                isLoading = true;
                                              });
                                            },
                                          ),
                                          bigBackground(
                                              firstBackgroundColor:
                                                  Color.fromRGBO(
                                                      spring[1].Red,
                                                      spring[1].Green,
                                                      spring[1].Blue,
                                                      spring[1].O)),
                                        ],
                                      )
                                    : Container(
                                        color: Colors.white,
                                        width: 380,
                                        height: 780,
                                      ),
                  ),
                  SizedBox(width: 10),
                  personalCnt == 10
                      ? SizedBox()
                      : Container(
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                if (warm + cool < 4) {
                                  firstColorIndex = firstColorIndex + 2;
                                  secondColorIndex = secondColorIndex + 2;
                                  if (index % 2 == 1) {
                                    cool = cool + 1;
                                    print(personalCnt);
                                  } else if (index % 2 == 0) {
                                    warm = warm + 1;
                                    print(personalCnt);
                                  }
                                  personalCnt = personalCnt + 1;
                                  updatePCM = personalColorCnt(
                                      warmCool[index].PersonalColor, updatePCM);
                                }
                                if (warm + cool == 4 && personalCnt <= 8) {
                                  if (fallCnt + springCnt == 0 &&
                                      winterCnt + summerCnt == 0) {
                                    firstColorIndex = -2;
                                    secondColorIndex = -1;
                                    if (index % 2 == 1) {
                                      springCnt = springCnt - 1;
                                      winterCnt = winterCnt - 1;
                                    } else if (index % 2 == 0) {
                                      fallCnt = fallCnt - 1;
                                      summerCnt = summerCnt - 1;
                                    }
                                  }
                                  if (warm >= cool) {
                                    firstColorIndex = firstColorIndex + 2;
                                    secondColorIndex = secondColorIndex + 2;

                                    if (index % 2 == 1) {
                                      springCnt = springCnt + 1;
                                    } else if (index % 2 == 0) {
                                      fallCnt = fallCnt + 1;
                                    }
                                    personalCnt = personalCnt + 1;
                                    updatePCM = personalColorCnt(
                                        fallspring[index].PersonalColor,
                                        updatePCM);
                                  } else if (warm < cool) {
                                    firstColorIndex = firstColorIndex + 2;
                                    secondColorIndex = secondColorIndex + 2;
                                    if (index % 2 == 1) {
                                      winterCnt = winterCnt + 1;
                                    } else if (index % 2 == 0) {
                                      summerCnt = summerCnt + 1;
                                    }
                                    personalCnt = personalCnt + 1;
                                    updatePCM = personalColorCnt(
                                        summerWinter[index].PersonalColor,
                                        updatePCM);
                                  }
                                }

                                if (isLoading == true) {
                                  personalCnt = personalCnt + 1;
                                }

                                if (personalCnt == 10) {
                                  List<Map<String, dynamic>> personalSelects = [
                                    {
                                      "personalSelectType":
                                          updatePCM.SSpringBright,
                                      "personalSelectTimes":
                                          updatePCM.SpringBright
                                    },
                                    {
                                      "personalSelectType":
                                          updatePCM.SSpringRight,
                                      "personalSelectTimes":
                                          updatePCM.SpringRight
                                    },
                                    {
                                      "personalSelectType":
                                          updatePCM.SSummerBright,
                                      "personalSelectTimes":
                                          updatePCM.SummerBright
                                    },
                                    {
                                      "personalSelectType":
                                          updatePCM.SSummerMute,
                                      "personalSelectTimes":
                                          updatePCM.SummerMute
                                    },
                                    {
                                      "personalSelectType":
                                          updatePCM.SSummerRight,
                                      "personalSelectTimes":
                                          updatePCM.SummerRight
                                    },
                                    {
                                      "personalSelectType": updatePCM.SFallDeep,
                                      "personalSelectTimes": updatePCM.FallDeep
                                    },
                                    {
                                      "personalSelectType": updatePCM.SFallMute,
                                      "personalSelectTimes": updatePCM.FallMute
                                    },
                                    {
                                      "personalSelectType":
                                          updatePCM.SFallStrong,
                                      "personalSelectTimes":
                                          updatePCM.FallStrong
                                    },
                                    {
                                      "personalSelectType":
                                          updatePCM.SWinterBright,
                                      "personalSelectTimes":
                                          updatePCM.WinterBright
                                    },
                                    {
                                      "personalSelectType":
                                          updatePCM.SWinterDeep,
                                      "personalSelectTimes":
                                          updatePCM.WinterDeep
                                    },
                                  ];

                                  personalSelects.sort((a, b) =>
                                      b["personalSelectTimes"]
                                          .compareTo(a["personalSelectTimes"]));

                                  print(personalSelects);

                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => PersonalColorResult(
                                        personalSelects: personalSelects,
                                        season: personalSelects[0].keys.first),
                                  ));
                                }
                              });
                            },
                            child: Text(
                              '선택 완료',
                              style: TextStyle(color: Colors.black),
                            ),
                            style: OutlinedButton.styleFrom(
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                side: BorderSide(
                                    color:
                                        const Color.fromARGB(255, 46, 46, 46),
                                    width: 1)),
                          ),
                        ),
                ],
              ),
              personalCnt == 10 ? SizedBox(height: 1) : SizedBox(height: 40),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCameraPreview() {
    // 카메라 미리보기 위젯
    return Center(
      child: SizedBox(
        width: 250,
        height: 300,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(200),
          child: SizedBox(
            width: 300,
            height: 300,
            child: CameraPreview(_controller),
          ),
        ),
      ),
    );
  }
}

PersonalColorModel personalColorCnt(
    String personalColor, PersonalColorModel PCM) {
  if (personalColor == 'SpR') {
    PCM.SpringRight = PCM.SpringRight + 1;
  } else if (personalColor == 'SpB') {
    PCM.SpringBright = PCM.SpringBright + 1;
  } else if (personalColor == 'SuR') {
    PCM.SummerRight = PCM.SummerRight + 1;
  } else if (personalColor == 'SuB') {
    PCM.SummerBright = PCM.SummerBright + 1;
  } else if (personalColor == 'SuM') {
    PCM.SummerMute = PCM.SummerMute + 1;
  } else if (personalColor == 'FM') {
    PCM.FallMute = PCM.FallMute + 1;
  } else if (personalColor == 'FS') {
    PCM.FallStrong = PCM.FallStrong + 1;
  } else if (personalColor == 'FD') {
    PCM.FallDeep = PCM.FallDeep + 1;
  } else if (personalColor == 'WB') {
    PCM.WinterBright = PCM.WinterBright + 1;
  } else if (personalColor == 'WD') {
    PCM.WinterDeep = PCM.WinterDeep + 1;
  }

  return PCM;
}
