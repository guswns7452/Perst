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
      print(body['data']);

      if (body['code'] != 200) {
        throw Exception(body['message']);
      }
      return body['data'];
    } catch (e) {
      print('Error : $e');
    }
  }

  // 퍼스널 컬러 이력 조회
  Future personalColorHistory() async {
    Response response = await get('/personal/color',
        headers: {'Authorization': await getToken});

    Map<String, dynamic> body = response.body;
    print(body['data']);

    if (body['code'] != 200) {
      throw Exception(body['message']);
    }
    return body['data'];
  }

  // 내 정보 변경 - 내 정보 불러오기
  Future<Map<String, dynamic>> showInformation() async {
    Response response =
        await get('/member/mypage', headers: {'Authorization': await getToken});

    Map<String, dynamic> body = response.body;
    print(body['data']);

    if (body['code'] != 200) {
      throw Exception(body['message']);
    }
    return body['data'];
  }

  // 내 정보 변경 - 내 정보 변경하기
  Future patchInformation(
      String memberName,
      String memberPhone,
      String memberPassword,
      String memberBirth,
      String memberGender,
      int memberHeight,
      int memberWeight) async {
    Response response = await patch('/member/mypage', {
      {
        "memberName": memberName,
        "memberPhone": memberPhone,
        "memberPassword": memberPassword,
        "memberBirth": memberBirth,
        "memberGender": memberGender,
        "memberHeight": memberHeight,
        "memberWeight": memberWeight
      }
    }, headers: {
      'Authorization': await getToken
    });

    Map<String, dynamic> body = response.body;
    print(body);

    if (body['code'] != 200) {
      throw Exception(body['message']);
    }
    return body['data'];
  }
}
