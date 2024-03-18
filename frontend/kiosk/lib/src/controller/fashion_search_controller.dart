import 'dart:io';

import 'package:get/get.dart';
import 'package:kiosk/src/connect/fashion_analyze_connect.dart';
import 'package:kiosk/src/connect/fashion_search_connect.dart';
import 'package:kiosk/src/model/fashion_search_model.dart';

class FashionSearchController extends GetxController {
  final fashionSearchConnection = Get.put(FashionSearchConnect());

  // 여자 키워드별 패션 스타일 불러오기
  Future<List<FashionSearchModel>> searchWoman(
      String womanFashionKeyword) async {
    try {
      List<dynamic> results =
          await fashionSearchConnection.searchWoman(womanFashionKeyword);
      List<FashionSearchModel> fashions = [];
      for (var result in results) {
        fashions.add(FashionSearchModel.fromJson(result));
      }
      print(fashions.toString());
      return fashions;
    } catch (e) {
      print('Error in searchWoman: $e');
      throw Exception('통신오류입니다.');
    }
  }

  // 남자 키워드별 패션 스타일 불러오기
  Future<List<FashionSearchModel>> searchMan(String manFashionKeyword) async {
    try {
      List<dynamic> results =
          await fashionSearchConnection.searchMan(manFashionKeyword);
      List<FashionSearchModel> fashions = [];
      for (var result in results) {
        fashions.add(FashionSearchModel.fromJson(result));
      }
      print(fashions.toString());
      return fashions;
    } catch (e) {
      print('Error: $e');
      throw Exception('통신오류입니다.');
    }
  }

  // 남자 키워드별 패션 스타일 불러오기
  // Future SearchMan(manFachionKeyword) async {
  //   try {
  //     List<dynamic> results =
  //         await fashionSearchConnection.searchMan(manFachionKeyword);
  //     Iterator<dynamic> iterator = results.iterator;
  //     List<FashionSearchModel> fashions = [];
  //     while (iterator.moveNext()) {
  //       fashions.add(FashionSearchModel.fromJson(iterator.current));
  //     }
  //     print(fashions.toString());
  //     return fashions;
  //   } catch (e) {
  //     return false;
  //   }
  // }

  FashionAnalyzeConnect _connect = Get.put(FashionAnalyzeConnect());

  Future<Map<String, dynamic>> sendStyleAnalyze(File imageFile) async {
    // 서비스 클래스를 이용하여 스타일 분석 요청을 보냅니다.
    // try {
    //   await fashionSearchConnection.styleAnalyze(image);
    //   return true;
    // } catch (e) {
    //   return false;
    // }
    try {
      Map<String, dynamic> success = await _connect.uploadImage(imageFile);
      return success;
    } catch (e) {
      print('Error uploading image: $e');
      throw Exception('서버 통신오류');
    }
  }
}
