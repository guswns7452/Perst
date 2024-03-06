import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:kiosk/src/controller/fashion_search_controller.dart';
import 'package:kiosk/src/widget/3color_combination.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  FashionSearchController _fashionSearchController =
      Get.put(FashionSearchController());
  final picker = ImagePicker();
  late File _image;

  Future getImage(ImageSource imageSource) async {
    final image = await picker.pickImage(source: imageSource);

    setState(() {
      _image = File(image!.path);
    });
  }

  void _submitForm() async {
    if (_image != null) {
      bool result = await _fashionSearchController.sendStyleAnalyze(_image);

      if (result) {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => YourPage(result)),
        // );
      } else {
        // 분석 실패 시 처리
      }
    } else {
      // 이미지가 없을 때 처리
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Camera')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                getImage(ImageSource.camera);
              },
              child: Text('Take a picture'),
            ),
            ElevatedButton(
              onPressed: () {
                getImage(ImageSource.gallery);
              },
              child: Text('Choose from gallery'),
            ),
            ElevatedButton(
              onPressed: () {
                _submitForm();
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}

class PictureAnalysis extends StatelessWidget {
  const PictureAnalysis({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Picture Analysis')),
      body: Center(
        child: Text('Picture analysis result will be shown here.'),
      ),
    );
  }
}
