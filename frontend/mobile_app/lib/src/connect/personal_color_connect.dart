import 'package:get/get_connect/connect.dart';
import 'package:get_storage/get_storage.dart';
import 'package:perst/shared/global.dart';
import 'dart:convert';

import 'package:perst/src/model/personal_color_model.dart';

final GetStorage _storage = GetStorage();

class PersonalColorConnect extends GetConnect {
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

  // 퍼스널 컬러 진단 결과
  Future personalAnalyze(
      String personalColorType,
      int personalColorAllTimes,
      DateTime personalColorDate,
      List<PersonalAnalyzeModel> personalSelects) async {
    // personalColorDate를 문자열로 변환합니다.
    String formattedDate = personalColorDate.toString();

    // personalSelects 리스트 map으로 변환
    List selectsJsonList =
        personalSelects.map((select) => select.toJson()).toList();

    Response response = await post('/clothes/analyze', {
      'personalColorType': personalColorType,
      'personalColorAllTimes': personalColorAllTimes,
      'personalColorDate': personalColorDate,
      'personalSelets': selectsJsonList,
    }, headers: {
      'Authorization': await getToken
    });

    Map<String, dynamic> body = response.body;

    if (body['code'] != 201) {
      throw Exception(body['message']);
    }
    return body['data'];
  }
}
