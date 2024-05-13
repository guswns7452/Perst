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
  late Future<Map<String, dynamic>> _analysisFuture;
  bool isLoading = false; // 로딩 상태를 관리하는 변수

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

        if (result['styleName'] == "Ivy") {
          result['styleName'] = "businessCasual";
        } else if (result['styleName'] == "Mods") {
          result['styleName'] = "";
        } else if (result['styleName'] == "Bold") {
          result['styleName'] = "dandy";
        } else if (result['styleName'] == "Hippie") {
          result['styleName'] = "";
        } else if (result['styleName'] == "Hip-hop") {
          result['styleName'] = "street";
        } else if (result['styleName'] == "Metrosexual") {
          result['styleName'] = "chic";
        } else if (result['styleName'] == "Spotivecasual") {
          result['styleName'] = "gofcore";
        } else if (result['styleName'] == "Normcore") {
          result['styleName'] = "minimal";
        } else if (result['styleName'] == "Traditional") {
          result['styleName'] = "casual";
        } else if (result['styleName'] == "Manish") {
          result['styleName'] = "businessCasual";
        } else if (result['styleName'] == "Feminine") {
          result['styleName'] = "romantic";
        } else if (result['styleName'] == "Ethnic") {
          result['styleName'] = "retro";
        } else if (result['styleName'] == "Contemporary") {
          result['styleName'] = "casual";
        } else if (result['styleName'] == "Natural") {
          result['styleName'] = "girlish";
        } else if (result['styleName'] == "Gender-fluid") {
          result['styleName'] = "";
        } else if (result['styleName'] == "Subculture") {
          result['styleName'] = "street";
        }

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
                    : CameraGuide()
              ),
            ),
            Container(
              height: 80,
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
                      : OutlinedButton(
                          onPressed: () {
                            _getImage(ImageSource.gallery);
                          },
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.white,
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(30),
                            backgroundColor: Colors.white,
                          ),
                          child: Image.asset(
                            'assets/camera.png',
                            width: 30,
                            height: 30,
                          ),
                        )
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
                  width: 300,
                  height: 90,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        ' 사진을 분석중입니다.\n20초정도 소요됩니다.',
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(width: 20),
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
