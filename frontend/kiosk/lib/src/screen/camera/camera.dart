import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kiosk/src/controller/fashion_search_controller.dart';
import 'package:kiosk/src/screen/styleTour/pictureAnalysis.dart';
import 'package:kiosk/src/widget/bottom_bar.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  FashionSearchController _fashionSearchController =
      Get.put(FashionSearchController());
  final picker = ImagePicker();
  late File? _image;
  late Future<Map<String, dynamic>> _analysisFuture;

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

  bool isLoading = false;

  void _submitForm() async {
    if (_image != null) {
      setState(() {
        isLoading = true; // 로딩 상태 시작
      });

      try {
        Map<String, dynamic> result =
            await _fashionSearchController.sendStyleAnalyze(_image!);

        if (result.isNotEmpty) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => PictureAnalysis(result)));
        }
      } catch (e) {
        // 오류 처리
      } finally {
        setState(() {
          isLoading = false; // 로딩 상태 종료
        });
      }
    } else {
      throw Exception('이미지가 없습니다.');
    }
  }

  @override
  Widget build(BuildContext context) {
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
              BottomBar(),
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
                            onPressed: () {
                              _submitForm();
                            },
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
                              _getImage(ImageSource.camera);
                            },
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.white,
                              shape: CircleBorder(),
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
