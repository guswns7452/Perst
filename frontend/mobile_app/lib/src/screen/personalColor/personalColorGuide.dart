import 'dart:io';

import 'package:flutter/material.dart';
import 'package:perst/src/screen/personalColor/personalColorAnalyze.dart';
import 'package:image_picker/image_picker.dart';

class PersonalColorGuide extends StatefulWidget {
  const PersonalColorGuide({super.key});

  @override
  State<PersonalColorGuide> createState() => _PersonalColorGuideState();
}

class _PersonalColorGuideState extends State<PersonalColorGuide> {
  late File? _image;
  final picker = ImagePicker();
  @override
  void initState() {
    super.initState();
    _image = null;
  }

  Future<void> _getImage(ImageSource imageSource) async {
    final image = await picker.pickImage(source: imageSource);

    setState(() {
      _image = File(image!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _image != null ? '퍼스널 컬러 사진' : '퍼스널 컬러 사진 가이드',
          textAlign: TextAlign.start,
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.black),
        margin: EdgeInsets.all(10),
        width: double.infinity,
        child: _image != null
            ? Stack(
                children: [
                  Container(
                    width: double.infinity,
                    color: Colors.black,
                  ),
                  Center(
                    child: Container(
                      width: 250,
                      height: 300,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(200),
                        child: Image.file(File(_image!.path),
                            fit: BoxFit.cover, width: 200, height: 300),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 20, left: 15),
                        alignment: Alignment.bottomCenter,
                        child: ElevatedButton(
                          onPressed: () {
                            _getImage(ImageSource.camera);
                          },
                          child: Text(
                            '재촬영하기',
                            style: TextStyle(
                                color: const Color.fromARGB(255, 0, 0, 0),
                                fontSize: 19,
                                fontWeight: FontWeight.bold),
                          ),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15))),
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.only(bottom: 20, left: 15, right: 15),
                        alignment: Alignment.bottomCenter,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  PersonalColorAnalyze(image: _image),
                            ));
                          },
                          child: Text(
                            '분석 시작하기',
                            style: TextStyle(
                                color: const Color.fromARGB(255, 0, 0, 0),
                                fontSize: 19,
                                fontWeight: FontWeight.bold),
                          ),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15))),
                        ),
                      )
                    ],
                  ),
                ],
              )
            : Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 10),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(left: 13),
                        child: Text(
                          '사진 가이드',
                          style: TextStyle(
                              fontSize: 34,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 13),
                        width: double.infinity,
                        child: Text(
                          '얼굴을 위치에 맞춰서 촬영해주세요.',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      )
                    ],
                  ),
                  Center(
                    child: Container(
                      height: 290,
                      width: 210,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(200),
                          color: Colors.white),
                      child: Image.asset('assets/faceDetection.png'),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 20, left: 15, right: 15),
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton(
                      onPressed: () {
                        _getImage(ImageSource.camera);
                      },
                      child: Text(
                        '사진 찍으러가기',
                        style: TextStyle(
                            color: const Color.fromARGB(255, 0, 0, 0),
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15))),
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
