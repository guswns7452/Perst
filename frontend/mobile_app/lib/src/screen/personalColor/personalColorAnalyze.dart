import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:perst/src/model/color_radio_model.dart';
import 'package:perst/src/screen/personalColor/personalColorResult.dart';
import 'package:perst/src/widget/personal_color_analyze_widget.dart';

class PersonalColorAnalyze extends StatefulWidget {
  final File? image;
  const PersonalColorAnalyze({required this.image, Key? key}) : super(key: key);

  @override
  State<PersonalColorAnalyze> createState() => _PersonalColorAnalyzeState();
}

class _PersonalColorAnalyzeState extends State<PersonalColorAnalyze> {
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
  bool spr = false;
  bool spb = false;
  bool sur = false;
  bool sub = false;
  bool sum = false;
  bool fm = false;
  bool fd = false;
  bool fs = false;
  bool wd = false;
  bool wb = false;
  int personalCnt = 0;
  String season = '';

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
      if (warm > cool) {
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
              child: ClipRRect(
                borderRadius: BorderRadius.circular(200),
                child: widget.image != null
                    ? Image.file(
                        File(widget.image!.path),
                        fit: BoxFit.cover,
                        width: 200,
                        height: 300,
                      )
                    : Placeholder(),
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
                          border: Border.all(color: Colors.black),
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
                          : ((summerCnt > winterCnt || fallCnt > springCnt)
                              ? Row(
                                  children: [
                                    Radio(
                                      value: firstColorIndex,
                                      groupValue: index,
                                      onChanged: (value) {
                                        setState(() {
                                          index = value as int;
                                          if (personalCnt == 9) {
                                            if (winterCnt + summerCnt >
                                                springCnt + fallCnt) {
                                              backgroundColor = Color.fromRGBO(
                                                  summer[0].Red,
                                                  summer[0].Green,
                                                  summer[0].Blue,
                                                  summer[0].O);
                                            } else {
                                              backgroundColor = Color.fromRGBO(
                                                  fall[0].Red,
                                                  fall[0].Green,
                                                  fall[0].Blue,
                                                  fall[0].O);
                                            }
                                          }
                                        });
                                      },
                                    ),
                                    smallBackground(
                                        firstBackgroundColor: personalCnt == 9
                                            ? (winterCnt + summerCnt >
                                                    fallCnt + springCnt
                                                ? Color.fromRGBO(
                                                    summer[0].Red,
                                                    summer[0].Green,
                                                    summer[0].Blue,
                                                    summer[0].O)
                                                : Color.fromRGBO(
                                                    fall[0].Red,
                                                    fall[0].Green,
                                                    fall[0].Blue,
                                                    fall[0].O))
                                            : firstBackgroundColor),
                                    Radio(
                                      value: secondColorIndex,
                                      groupValue: index,
                                      onChanged: (value) {
                                        setState(() {
                                          index = value as int;
                                          if (personalCnt == 9) {
                                            if (winterCnt + summerCnt >
                                                springCnt + fallCnt) {
                                              backgroundColor = Color.fromRGBO(
                                                  summer[1].Red,
                                                  summer[1].Green,
                                                  summer[1].Blue,
                                                  summer[1].O);
                                            } else {
                                              backgroundColor = Color.fromRGBO(
                                                  fall[1].Red,
                                                  fall[1].Green,
                                                  fall[1].Blue,
                                                  fall[1].O);
                                            }
                                          }
                                        });
                                      },
                                    ),
                                    smallBackground(
                                        firstBackgroundColor: personalCnt == 9
                                            ? (winterCnt + summerCnt >
                                                    fallCnt + springCnt
                                                ? Color.fromRGBO(
                                                    summer[1].Red,
                                                    summer[1].Green,
                                                    summer[1].Blue,
                                                    summer[1].O)
                                                : Color.fromRGBO(
                                                    fall[1].Red,
                                                    fall[1].Green,
                                                    fall[1].Blue,
                                                    fall[1].O))
                                            : firstBackgroundColor),
                                    Radio(
                                      value: thirdColorIndex,
                                      groupValue: index,
                                      onChanged: (value) {
                                        setState(() {
                                          index = value as int;
                                          if (personalCnt == 9) {
                                            if (winterCnt + summerCnt >
                                                springCnt + fallCnt) {
                                              backgroundColor = Color.fromRGBO(
                                                  summer[2].Red,
                                                  summer[2].Green,
                                                  summer[2].Blue,
                                                  summer[2].O);
                                            } else {
                                              backgroundColor = Color.fromRGBO(
                                                  fall[2].Red,
                                                  fall[2].Green,
                                                  fall[2].Blue,
                                                  fall[2].O);
                                            }
                                          }
                                        });
                                      },
                                    ),
                                    smallBackground(
                                        firstBackgroundColor: personalCnt == 9
                                            ? (winterCnt + summerCnt >
                                                    fallCnt + springCnt
                                                ? Color.fromRGBO(
                                                    summer[2].Red,
                                                    summer[2].Green,
                                                    summer[2].Blue,
                                                    summer[2].O)
                                                : Color.fromRGBO(
                                                    fall[2].Red,
                                                    fall[2].Green,
                                                    fall[2].Blue,
                                                    fall[2].O))
                                            : firstBackgroundColor),
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
                                          if (personalCnt == 9) {
                                            if (winterCnt + summerCnt >
                                                springCnt + fallCnt) {
                                              backgroundColor = Color.fromRGBO(
                                                  winter[0].Red,
                                                  winter[0].Green,
                                                  winter[0].Blue,
                                                  winter[0].O);
                                            } else {
                                              backgroundColor = Color.fromRGBO(
                                                  spring[0].Red,
                                                  spring[0].Green,
                                                  spring[0].Blue,
                                                  spring[0].O);
                                            }
                                          }
                                        });
                                      },
                                    ),
                                    bigBackground(
                                        firstBackgroundColor: personalCnt == 9
                                            ? (winterCnt + summerCnt >
                                                    springCnt + fallCnt
                                                ? Color.fromRGBO(
                                                    winter[0].Red,
                                                    winter[0].Green,
                                                    winter[0].Blue,
                                                    winter[0].O)
                                                : Color.fromRGBO(
                                                    spring[0].Red,
                                                    spring[0].Green,
                                                    spring[0].Blue,
                                                    spring[0].O))
                                            : firstBackgroundColor),
                                    Radio(
                                      value: secondColorIndex,
                                      groupValue: index,
                                      onChanged: (value) {
                                        setState(() {
                                          index = value as int;
                                          if (personalCnt == 9) {
                                            if (winterCnt + summerCnt >
                                                springCnt + fallCnt) {
                                              backgroundColor = Color.fromRGBO(
                                                  winter[1].Red,
                                                  winter[1].Green,
                                                  winter[1].Blue,
                                                  winter[1].O);
                                            } else {
                                              backgroundColor = Color.fromRGBO(
                                                  spring[1].Red,
                                                  spring[1].Green,
                                                  spring[1].Blue,
                                                  spring[1].O);
                                            }
                                          }
                                        });
                                      },
                                    ),
                                    bigBackground(
                                        firstBackgroundColor: personalCnt == 9
                                            ? (winterCnt + summerCnt >
                                                    springCnt + fallCnt
                                                ? Color.fromRGBO(
                                                    winter[1].Red,
                                                    winter[1].Green,
                                                    winter[1].Blue,
                                                    winter[1].O)
                                                : Color.fromRGBO(
                                                    spring[1].Red,
                                                    spring[1].Green,
                                                    spring[1].Blue,
                                                    spring[1].O))
                                            : secondBackgroundColor),
                                  ],
                                ))),
                  SizedBox(width: 10),
                  Container(
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
                            PCM = personalColorCnt(
                                warmCool[index].PersonalColor, PCM);
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
                            if (warm > cool) {
                              firstColorIndex = firstColorIndex + 2;
                              secondColorIndex = secondColorIndex + 2;

                              if (index % 2 == 1) {
                                springCnt = springCnt + 1;
                                print(springCnt.toString() +
                                    "   " +
                                    fallCnt.toString());
                              } else if (index % 2 == 0) {
                                fallCnt = fallCnt + 1;
                                print(springCnt.toString() +
                                    "   " +
                                    fallCnt.toString());
                              }
                              personalCnt = personalCnt + 1;
                              PCM = personalColorCnt(
                                  fallspring[index].PersonalColor, PCM);
                            } else if (warm < cool) {
                              firstColorIndex = firstColorIndex + 2;
                              secondColorIndex = secondColorIndex + 2;
                              if (index % 2 == 1) {
                                winterCnt = winterCnt + 1;
                                print(winterCnt);
                              } else if (index % 2 == 0) {
                                summerCnt = summerCnt + 1;
                              }
                              personalCnt = personalCnt + 1;
                              PCM = personalColorCnt(
                                  fallspring[index].PersonalColor, PCM);
                            }
                          }
                          if (personalCnt == 9) {
                            // Navigator.of(context).push(MaterialPageRoute(
                            //   builder: (context) =>
                            //       const PersonalColorResult(PCM: ),
                            // ));
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
                              color: const Color.fromARGB(255, 46, 46, 46),
                              width: 1)),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40),
            ],
          ),
        ],
      ),
    );
  }
}

PersonalColorModel PCM = PersonalColorModel(0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

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
