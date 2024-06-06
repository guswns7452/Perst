import 'dart:io';

import 'package:get/get.dart';
import 'package:perst/src/connect/fashion_analyze_connect.dart';
import 'package:perst/src/connect/fashion_search_connect.dart';
import 'package:perst/src/model/fashion_search_model.dart';

class FashionSearchController extends GetxController {
  final fashionSearchConnection = Get.put(FashionSearchConnect());

  // 여자 키워드별 패션 스타일 불러오기
  Future searchWoman(String womanFashionKeyword, bool isPersonal,
      List<String> colorList, String season) async {
    try {
      Map<String, dynamic> response = await fashionSearchConnection.searchWoman(
          womanFashionKeyword, isPersonal, colorList, season);
      print(response);
      return response;
    } catch (e) {
      print('Error in searchWoman: $e');
      throw Exception('통신오류입니다.');
    }
  }

  // 남자 키워드별 패션 스타일 불러오기
  Future searchMan(String manFashionKeyword, bool isPersonal,
      List<String> colorList, String season) async {
    try {
      Map<String, dynamic> response = await fashionSearchConnection.searchMan(
          manFashionKeyword, isPersonal, colorList, season);
      print(response);
      return response;
    } catch (e) {
      print('Error: $e');
      throw Exception('통신오류입니다.');
    }
  }

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
