import 'dart:io';

import 'package:get/get.dart';
import 'package:perst/src/connect/fashion_analyze_connect.dart';
import 'package:perst/src/connect/fashion_search_connect.dart';

class FashionSearchController extends GetxController {
  final fashionSearchConnection = Get.put(FashionSearchConnect());

  FashionAnalyzeConnect _connect = Get.put(FashionAnalyzeConnect());

  Future<Map<String, dynamic>> sendStyleAnalyze(File imageFile) async {
    try {
      Map<String, dynamic> success = await _connect.uploadImage(imageFile);
      return success;
    } catch (e) {
      print('Error uploading image: $e');
      throw Exception('서버 통신오류');
    }
  }
}
