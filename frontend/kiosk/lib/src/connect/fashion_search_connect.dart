import 'dart:io';

import 'package:get/get_connect/connect.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kiosk/shared/global.dart';

final GetStorage _storage = GetStorage();

class FashionSearchConnect extends GetConnect {
  @override
  void onInit() {
    allowAutoSignedCert = true;
    httpClient.baseUrl = Global.apiRoot;
    httpClient.addRequestModifier<void>((request) {
      request.headers['Accept'] = 'application/json';
      return request;
    });
    super.onInit();
  }

  // 토큰 받아오기
  get getToken async {
    print("ddddddddddddddddddddddddddddddddddddddddddddddddddddd" +
        _storage.read("access_token"));
    return _storage.read("access_token");
  }

  // 여자 패션 이미지 받아오기
  Future searchWoman(String womanFashionKeyword) async {
    try {
      Response response = await get(
          '/clothes/search/woman?style=$womanFashionKeyword',
          headers: {'Authorization': await getToken});
      Map<String, dynamic> body = response.body;

      if (body['code'] != 200) {
        throw Exception(body['message']);
      }
      return body['data'];
    } catch (e) {
      print('Error: $e');
    }
  }

  // 남자 패션 이미지 받아오기
  Future searchMan(String manFashionKeyword) async {
    try {
      Response response = await get(
          '/clothes/search/man?style=$manFashionKeyword',
          headers: {'Authorization': await getToken});
      Map<String, dynamic> body = response.body;

      if (body['code'] != 200) {
        throw Exception(body['message']);
      }
      return body['data'];
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<bool> styleAnalyze(File? image) async {
    try {
      String imagePath = image!.path;
      Response response = await post('/clothes/analyze', {
        'image': imagePath,
      }, headers: {
        'Authorization':
            'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiI4IiwiaWF0IjoxNzA5NzQzMjMxLCJleHAiOjE3MDk4NDMyMzF9.zu_56mspD8SA-GJ0K6z-mJqGNQmIE5pTbXlW0deH9oY'
      });

      Map<String, dynamic> body = response.body;
      print(
          "--------------------------------------------------------------------------------" +
              getToken);

      if (body['code'] == 200) {
        return true;
      } else {
        throw Exception(body['message']);
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }
}
