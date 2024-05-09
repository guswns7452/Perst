import 'dart:io';

import 'package:get/get_connect/connect.dart';
import 'package:get_storage/get_storage.dart';
import 'package:perst/shared/global.dart';

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
    return _storage.read("access_token");
  }

  // 여자 패션 이미지 받아오기
  Future searchWoman(String womanFashionKeyword, bool isPersonal) async {
    try {
      if (womanFashionKeyword == 'Subculture') {
        womanFashionKeyword = 'street';
      }
      Response response = await post(
          '/clothes/search/woman?style=$womanFashionKeyword',
          {"color": [], "isPersonal": isPersonal},
          headers: {'Authorization': await getToken});
      Map<String, dynamic> body = response.body;

      print(body);

      if (body['code'] != 200) {
        throw Exception(body['message']);
      }
      return body;
    } catch (e) {
      print('Error: $e');
    }
  }

  // 남자 패션 이미지 받아오기
  Future searchMan(String manFashionKeyword, isPersonal) async {
    try {
      if (manFashionKeyword == 'Hip-hop') {
        manFashionKeyword = 'street';
      }
      Response response =
          await post('/clothes/search/man?style=$manFashionKeyword', {
        "color": ["red"],
        "isPersonal": isPersonal
      }, headers: {
        'Authorization': await getToken
      });
      Map<String, dynamic> body = response.body;

      print(body);

      if (body['code'] != 200) {
        throw Exception(body['message']);
      }
      return body['data'];
    } catch (e) {
      print('Error: $e');
    }
  }

  // 스타일 분석 후 데이터 받아오기
  Future<bool> styleAnalyze(File? image) async {
    try {
      String imagePath = image!.path;
      Response response = await post('/clothes/analyze', {
        'image': imagePath,
      }, headers: {
        'Authorization': await getToken
      });

      Map<String, dynamic> body = response.body;

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
