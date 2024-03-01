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

  // 여자 패션 이미지 받아오기
  Future searchWoman(String womanFashionKeyword) async {
    try {
      print('안녕?');
      Response response = await get(
          '/clothes/search/man?style=$womanFashionKeyword',
          headers: {'Authorization': getToken});
      print('안녕?' + getToken);
      Map<String, dynamic> body = response.body;
      print('bodobodobodobodobodobodobdo');
      print(body);

      if (body['code'] != 200) {
        throw Exception('서버 응답 코드가 200이 아닙니다: ${body['code']}');
      }
      print("----------------------------------------------------------------" +
          body['data']);
      return body['data'];
    } catch (e) {
      print('Error: $e');
    }
  }

  // 남자 패션 이미지 받아오기
  Future searchMan(String manFashionKeyword) async {
    try {
      print('안녕?');
      Response response =
          await get('/clothes/search/man?style=$manFashionKeyword');
      Map<String, dynamic> body = response.body;
      print('bodobodobodobodobodobodobdo');
      print(body);

      if (body['code'] != 200) {
        throw Exception(body['message']);
      }
      print("----------------------------------------------------------------" +
          body['data']);
      return body['data'];
    } catch (e) {
      print('Error: $e');
    }
  }

  // 추후에 토큰 추가시 사용 예정
  get getToken async {
    return _storage.read("access_token");
  }
}
