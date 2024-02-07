import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class Camera extends StatefulWidget {
  const Camera({Key? key}) : super(key: key);

  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  File? _image;
  final picker = ImagePicker();

  Future getImage(ImageSource imageSource) async {
    final image = await picker.pickImage(source: imageSource);

    setState(() {
      _image = File(image!.path); // 가져온 이미지를 _image에 저장
    });
  }

  @override
  Widget build(BuildContext context) {
    // 화면 세로 고정
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Center(
                  child: _image != null
                      ? Image.file(
                          File(_image!.path),
                          fit: BoxFit.cover, // 화면에 가득 채우도록 설정
                        )
                      : Text(
                          '카메라 버튼을 눌러 사진을 찍어보세요.',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                ),
              ),
              Container(
                height: 93,
                width: double.infinity,
                color: Colors.black,
              ),
              Container(
                child: Center(
                  child: Text(
                    'Perst : 당신만을 위한 의류 스타일 추천 서비스',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                color: Color.fromRGBO(217, 217, 217, 1),
                width: double.infinity,
                height: 60,
              ),
            ],
          ),
          Positioned(
            bottom: 85.0,
            left: 0,
            right: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _image != null
                        ? TextButton(
                            onPressed: () {},
                            child: Text(
                              '스타일 분석하러가기',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                            ),
                          )
                        : OutlinedButton(
                            onPressed: () {
                              getImage(ImageSource.camera);
                            },
                            style: OutlinedButton.styleFrom(
                              shape: CircleBorder(),
                              primary: Colors.white,
                              padding: EdgeInsets.all(30),
                              backgroundColor: Colors.white,
                            ),
                            child: Image.asset(
                              'assets/camera.png',
                              width: 80,
                              height: 80,
                            ),
                          )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
