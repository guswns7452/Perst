import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:perst/src/controller/fashion_search_controller.dart';
import 'package:perst/src/screen/camera/cameraGuide.dart';
import 'package:perst/src/screen/style/pictureAnalysis.dart';

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
  bool isLoading = false;

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

  void _submitForm() async {
    if (_image != null && !isLoading) {
      setState(() {
        isLoading = true;
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
          isLoading = false;
        });
      }
    } else {
      throw Exception('이미지가 없거나 이미 로딩 중입니다.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Stack(children: [
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
                      : CameraGuide()),
            ),
            Container(
              height: 50,
              width: double.infinity,
              color: Colors.black,
            ),
          ],
        ),
        Positioned(
          bottom: 15.0,
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
                          onPressed: isLoading ? null : _submitForm,
                          child: Text(
                            '스타일 분석하러가기',
                            style: TextStyle(
                              fontSize: 20,
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
                      : Row(children: [
                          OutlinedButton(
                            onPressed: () {
                              _getImage(ImageSource.camera);
                            },
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.all(20),
                              backgroundColor: Colors.white,
                            ),
                            child: Image.asset(
                              'assets/camera.png',
                              width: 30,
                              height: 30,
                            ),
                          ),
                          SizedBox(width: 50),
                          OutlinedButton(
                            onPressed: () {
                              _getImage(ImageSource.gallery);
                            },
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.all(20),
                              backgroundColor: Colors.white,
                            ),
                            child: Image.asset(
                              'assets/gallery.png',
                              width: 30,
                              height: 30,
                            ),
                          ),
                        ])
                ],
              ),
            ],
          ),
        ),
        if (isLoading)
          Container(
            color: Colors.black.withOpacity(0.5),
            child: Center(
              child: Container(
                  width: 280,
                  height: 140,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        ' 사진을 분석중입니다.\n20초정도 소요됩니다.',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 15),
                      CircularProgressIndicator(),
                    ],
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20))),
            ),
          ),
      ]),
    );
  }
}
