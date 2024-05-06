import 'package:get/get_connect/connect.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:perst/shared/global.dart';
import 'dart:convert';

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
      String personalSelectTypeOne,
      String personalSelectTypeTwo,
      String personalSelectTypeThree,
      int personalSelectTimesOne,
      int personalSelectTimesTwo,
      int personalSelectTimesThree) async {
    DateTime nowDate = DateTime.now();
    String personalColorDate =
        DateFormat('yyyy-MM-ddTHH:mm:ss').format(nowDate);
    print(personalColorDate);
    Response response = await post('/personal/color', {
      'personalColorType': personalColorType,
      'personalColorAllTimes': personalColorAllTimes,
      'personalColorDate': personalColorDate,
      'personalSelects': [
        {
          'personalSelectType': personalSelectTypeOne,
          'personalSelectTimes': personalSelectTimesOne
        },
        {
          'personalSelectType': personalSelectTypeTwo,
          'personalSelectTimes': personalSelectTimesTwo
        },
        {
          'personalSelectType': personalSelectTypeThree,
          'personalSelectTimes': personalSelectTimesThree
        },
      ],
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
