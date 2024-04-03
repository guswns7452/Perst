import 'dart:io';
import 'package:flutter/material.dart';
import 'package:perst/src/screen/auth/intro.dart';

class PersonalColorAnalyze extends StatefulWidget {
  final File? image;
  const PersonalColorAnalyze({required this.image, Key? key}) : super(key: key);

  @override
  State<PersonalColorAnalyze> createState() => _PersonalColorAnalyzeState();
}

class _PersonalColorAnalyzeState extends State<PersonalColorAnalyze> {
  final List<ColorRadioModel> colorList = [
    ColorRadioModel(223, 167, 177, 1),
    ColorRadioModel(177, 167, 223, 1),
    ColorRadioModel(116, 204, 71, 1),
    ColorRadioModel(26, 64, 57, 1),
    ColorRadioModel(104, 128, 57, 1),
    ColorRadioModel(82, 204, 204, 1),
    ColorRadioModel(128, 96, 101, 1),
    ColorRadioModel(58, 45, 128, 1),
    ColorRadioModel(77, 31, 34, 1),
    ColorRadioModel(204, 122, 129, 1),
    ColorRadioModel(128, 77, 102, 1),
    ColorRadioModel(204, 61, 133, 1),
    ColorRadioModel(128, 98, 38, 1),
    ColorRadioModel(204, 184, 143, 1),
    ColorRadioModel(89, 128, 102, 1),
    ColorRadioModel(143, 204, 163, 1),
    ColorRadioModel(217, 163, 172, 1),
    ColorRadioModel(204, 71, 94, 1),
  ];

  int firstColorIndex = 0;
  int secondColorIndex = 1;
  int index = 0;
  int warm = 0;
  int cool = 0;
  int spring = 0;
  int summer = 0;
  int fall = 0;
  int winter = 0;
  bool bright = false;
  bool mute = false;
  bool right = false;
  bool deep = false;
  bool strong = false;

  @override
  Widget build(BuildContext context) {
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
            color: Color.fromRGBO(
              colorList[index].Red,
              colorList[index].Green,
              colorList[index].Blue,
              colorList[index].O,
            ),
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
                    child: Row(
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
                              color: Color.fromRGBO(
                                  colorList[firstColorIndex].Red,
                                  colorList[firstColorIndex].Green,
                                  colorList[firstColorIndex].Blue,
                                  colorList[firstColorIndex].O),
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
                              color: Color.fromRGBO(
                                  colorList[secondColorIndex].Red,
                                  colorList[secondColorIndex].Green,
                                  colorList[secondColorIndex].Blue,
                                  colorList[secondColorIndex].O),
                              borderRadius: BorderRadius.circular(8)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if (secondColorIndex < 6) {
                            firstColorIndex = firstColorIndex + 2;
                            secondColorIndex = secondColorIndex + 2;
                            if (index % 2 == 1) {
                              cool = cool + 1;
                              print("cool");
                              print(cool);
                            } else if (index % 2 == 0) {
                              warm = warm + 1;
                              print("warm");
                              print(warm);
                            }
                          } else if (secondColorIndex > 6 &&
                              secondColorIndex < 14) {
                            firstColorIndex = firstColorIndex + 2;
                            secondColorIndex = secondColorIndex + 2;
                          } else if (secondColorIndex > 14 &&
                              secondColorIndex < 16) {
                            firstColorIndex = firstColorIndex + 2;
                            secondColorIndex = secondColorIndex + 2;
                          } else {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const Intro(),
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

class ColorRadioModel {
  final int Red;
  final int Green;
  final int Blue;
  final double O;

  ColorRadioModel(this.Red, this.Green, this.Blue, this.O);
}
