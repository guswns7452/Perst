import 'package:get/get_connect/connect.dart';
import 'package:get_storage/get_storage.dart';
import 'package:perst/shared/global.dart';

final GetStorage _storage = GetStorage();

class MypageConnect extends GetConnect {
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

  // 마이페이지 스타일 분석 이력 조회
  Future styleHistory() async {
    try {
      Response response = await get('/clothes/analyze/my',
          headers: {'Authorization': await getToken});
      Map<String, dynamic> body = response.body;

      if (body['code'] != 200) {
        throw Exception(body['message']);
      }
      return body['data'];
    } catch (e) {
      print('Error : $e');
    }
  }

  // 마이페이지 스타일 분석 상세 이력 조회
  Future styleHistoryDetail(int styleNumber) async {
    try {
      Response response = await get('/clothes/analyze?number=$styleNumber',
          headers: {'Authorization': await getToken});
      Map<String, dynamic> body = response.body;

      if (body['code'] != 200) {
        throw Exception(body['message']);
      }
      return body['data'];
    } catch (e) {
      print('Error : $e');
    }
  }
}
