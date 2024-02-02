import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class CameraExample extends StatefulWidget {
  const CameraExample({Key? key}) : super(key: key);

  @override
  _CameraExampleState createState() => _CameraExampleState();
}

class _CameraExampleState extends State<CameraExample> {
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
                          fit: BoxFit.cover, // 화면에 가득 채우도록 설정합니다.
                        )
                      : Text(
                          '사진을 찍거나 갤러리에서 이미지를 선택해주세요.',
                          style: TextStyle(
                            fontSize: 20,
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
            top: 150.0,
            left: 0,
            right: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '양 발끝을 선에 맞춰서 서주세요.',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                Container(
                  width: 500,
                  height: 635,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                      width: 4,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Image.asset('assets/man.png'),
                  alignment: Alignment.bottomCenter,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        getImage(ImageSource.camera);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        primary: Colors.white,
                        padding: EdgeInsets.all(30), // 버튼의 패딩 설정
                      ),
                      child: Image.asset(
                        'assets/camera.png',
                        width: 80,
                        height: 80,
                      ),
                    ),
                    SizedBox(width: 40),
                    ElevatedButton(
                      onPressed: () {
                        getImage(ImageSource.gallery);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        primary: Colors.white,
                        padding: EdgeInsets.all(30), // 버튼의 패딩 설정
                      ),
                      child: Image.asset(
                        'assets/gallery.png',
                        width: 80,
                        height: 80,
                      ),
                    ),
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
