import 'dart:io';
import 'package:flutter/material.dart';
import 'package:perst/src/model/color_radio_model.dart';

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

  Color? firstBackgroundColor,
      secondBackgroundColor,
      backgroundColor,
      thirdBackgroundColor;

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
    if (warm + cool == 4 &&
        !spb &&
        !spr &&
        !sub &&
        !sum &&
        !sur &&
        !fd &&
        !fs &&
        !fm &&
        !wd &&
        !wb) {
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
    if (fallCnt + springCnt == 4 || summerCnt + winterCnt == 4) {
      if (fallCnt + springCnt == 4) {
        if (fallCnt > springCnt) {
          if (firstColorIndex > 2) {
            firstColorIndex = 0;
          } else if (secondColorIndex > 3) {
            secondColorIndex = 1;
          }
          firstBackgroundColor = Color.fromRGBO(
              fall[firstColorIndex].Red,
              fall[firstColorIndex].Green,
              fall[firstColorIndex].Blue,
              fall[firstColorIndex].O);
          secondBackgroundColor = Color.fromRGBO(
              fall[secondColorIndex].Red,
              fall[secondColorIndex].Green,
              fall[secondColorIndex].Blue,
              fall[secondColorIndex].O);
          thirdBackgroundColor = Color.fromRGBO(
              fall[thirdColorIndex].Red,
              fall[thirdColorIndex].Green,
              fall[thirdColorIndex].Blue,
              fall[thirdColorIndex].O);
          season = "fall";
          backgroundColor = Color.fromRGBO(fall[index].Red, fall[index].Green,
              fall[index].Blue, fall[index].O);
        } else if (fallCnt < springCnt) {
          if (firstColorIndex > 2) {
            firstColorIndex = 0;
          } else if (secondColorIndex > 3) {
            secondColorIndex = 1;
          }
          firstBackgroundColor = Color.fromRGBO(
              spring[firstColorIndex].Red,
              spring[firstColorIndex].Green,
              spring[firstColorIndex].Blue,
              spring[firstColorIndex].O);
          secondBackgroundColor = Color.fromRGBO(
              spring[secondColorIndex].Red,
              spring[secondColorIndex].Green,
              spring[secondColorIndex].Blue,
              spring[secondColorIndex].O);
          backgroundColor = Color.fromRGBO(spring[index].Red,
              spring[index].Green, spring[index].Blue, spring[index].O);
          season = "spring";
        }
      } else if (summerCnt + winterCnt == 4) {
        if (summerCnt > winterCnt) {
          if (firstColorIndex > 2) {
            firstColorIndex = 0;
          } else if (secondColorIndex > 3) {
            secondColorIndex = 1;
          }
          firstBackgroundColor = Color.fromRGBO(
              summer[firstColorIndex].Red,
              summer[firstColorIndex].Green,
              summer[firstColorIndex].Blue,
              summer[firstColorIndex].O);
          secondBackgroundColor = Color.fromRGBO(
              summer[secondColorIndex].Red,
              summer[secondColorIndex].Green,
              summer[secondColorIndex].Blue,
              summer[secondColorIndex].O);
          thirdBackgroundColor = Color.fromRGBO(
              summer[thirdColorIndex].Red,
              summer[thirdColorIndex].Green,
              summer[thirdColorIndex].Blue,
              summer[thirdColorIndex].O);
          backgroundColor = Color.fromRGBO(summer[index].Red,
              summer[index].Green, summer[index].Blue, summer[index].O);
          season = "summer";
        } else if (summerCnt < winterCnt) {
          if (firstColorIndex > 2) {
            firstColorIndex = 0;
          } else if (secondColorIndex > 3) {
            secondColorIndex = 1;
          }
          firstBackgroundColor = Color.fromRGBO(
              winter[firstColorIndex].Red,
              winter[firstColorIndex].Green,
              winter[firstColorIndex].Blue,
              winter[firstColorIndex].O);
          secondBackgroundColor = Color.fromRGBO(
              winter[secondColorIndex].Red,
              winter[secondColorIndex].Green,
              winter[secondColorIndex].Blue,
              winter[secondColorIndex].O);
          backgroundColor = Color.fromRGBO(winter[index].Red,
              winter[index].Green, winter[index].Blue, winter[index].O);
          season = "winter";
        }
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
          Container(
            margin: EdgeInsets.all(15),
            color: backgroundColor,
          ),
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
                      child: fallCnt + springCnt < 5 &&
                              winterCnt + summerCnt < 5
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
                          : (season == 'fall' || season == 'summer'
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
                                          borderRadius:
                                              BorderRadius.circular(8)),
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
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                    ),
                                    Radio(
                                      value: thirdColorIndex,
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
                                          color: thirdBackgroundColor,
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                    ),
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
                                        });
                                      },
                                    ),
                                    Container(
                                      width: 70,
                                      height: 20,
                                      decoration: BoxDecoration(
                                          color: firstBackgroundColor,
                                          borderRadius:
                                              BorderRadius.circular(8)),
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
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                    ),
                                  ],
                                ))),
                  SizedBox(width: 10),
                  Container(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if (firstColorIndex < 7 && secondColorIndex < 8) {
                            if (warm + cool < 4) {
                              firstColorIndex = firstColorIndex + 2;
                              secondColorIndex = secondColorIndex + 2;
                              if (index % 2 == 1) {
                                cool = cool + 1;
                                print(cool);
                              } else if (index % 2 == 0) {
                                warm = warm + 1;
                                print(warm);
                              }
                              personalCnt = personalCnt + 1;
                              personalColorCnt(
                                  warmCool[index].PersonalColor, PCM);
                            }

                            if (fallCnt + springCnt < 4 &&
                                winterCnt + summerCnt < 4 &&
                                warm + cool == 4) {
                              if (fallCnt + springCnt == 0 &&
                                  winterCnt + summerCnt == 0) {
                                firstColorIndex = -2;
                                secondColorIndex = -1;
                                if (index % 2 == 1) {
                                  springCnt = -1;
                                  winterCnt = -1;
                                } else if (index % 2 == 0) {
                                  fallCnt = -1;
                                  summerCnt = -1;
                                }
                              }
                              if (warm > cool) {
                                firstColorIndex = firstColorIndex + 2;
                                secondColorIndex = secondColorIndex + 2;
                                if (index % 2 == 1) {
                                  springCnt = springCnt + 1;
                                } else if (index % 2 == 0) {
                                  fallCnt = fallCnt + 1;
                                }
                                personalCnt = personalCnt + 1;
                                personalColorCnt(
                                    fallspring[index].PersonalColor, PCM);
                              } else if (warm < cool) {
                                firstColorIndex = firstColorIndex + 2;
                                secondColorIndex = secondColorIndex + 2;
                                if (index % 2 == 1) {
                                  winterCnt = winterCnt + 1;
                                  print(winterCnt);
                                } else if (index % 2 == 0) {
                                  summerCnt = summerCnt + 1;
                                  print(summerCnt);
                                }
                                personalCnt = personalCnt + 1;
                                personalColorCnt(
                                    fallspring[index].PersonalColor, PCM);
                              }
                            }
                            if (fallCnt + springCnt == 4 ||
                                winterCnt + summerCnt == 4) {
                              if (fallCnt + springCnt == 4) {
                                if (fallCnt > springCnt) {
                                  if (index == 0) {
                                    fm = true;
                                  } else if (index == 1) {
                                    fs = true;
                                  } else if (index == 2) {
                                    fd = true;
                                  }
                                } else if (fallCnt < springCnt) {
                                  if (index == 0) {
                                    spr = true;
                                  } else if (index == 1) {
                                    spb = true;
                                  }
                                }
                              } else if (winterCnt + summerCnt == 4) {
                                if (winterCnt > summerCnt) {
                                  if (index == 0) {
                                    wb = true;
                                  } else if (index == 1) {
                                    wd = true;
                                  }
                                } else if (winterCnt < summerCnt) {
                                  if (index == 0) {
                                    sur = true;
                                  } else if (index == 1) {
                                    sub = true;
                                  } else if (index == 2) {
                                    sum = true;
                                  }
                                }
                              }
                            }
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

final PersonalColorModel PCM = PersonalColorModel(0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

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
