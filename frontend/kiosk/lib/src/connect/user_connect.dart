import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kiosk/shared/global.dart';

final GetStorage _storage = GetStorage();

// 회원 관련된 통신을 담당하는 클래스
class UserConnect extends GetConnect {
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

  // 회원가입 통신
  // Future sendRegister(String memberName, String memberEmail, String memberPhone,
  //     String memberPassword) async {
  //   print("user_connect" +
  //       memberName +
  //       memberEmail +
  //       memberPassword +
  //       memberPhone);
  //   Response response = await post(
  //     '/user/register',
  //     {
  //       'memberName': memberName,
  //       'memberEmail': memberEmail,
  //       'memberPhone': memberPhone,
  //       'memberPassword': memberPassword
  //     },
  //   );
  //   print(response.bodyString);
  //   Map<String, dynamic> body = response.body;

  //   _storage.write("memberName", body['data']['memberName']);
  //   _storage.write("memberPhone", body['data']['memberPhone']);

  //   if (body['code'] != 201) {
  //     throw Exception(body['message']);
  //   }
  //   return body['data']['token'];
  // }

  // 회원가입 통신
  Future sendRegister(
      String memberName,
      String memberPhone,
      String memberPassword,
      String memberBirth,
      String memberGender,
      int memberHeight,
      int memberWeight) async {
    print("이이이ㅣ" +
        memberName +
        memberPhone +
        memberPassword +
        memberBirth +
        memberGender);
    print(memberHeight + memberWeight);
    Response response = await post('/member/signup', {
      'memberName': memberName,
      'memberPhone': memberPhone,
      'memberPassword': memberPassword,
      'memberBirth': memberBirth,
      'memberGender': memberGender,
      'memberHeight': memberHeight,
      'memberWeight': memberWeight
    });
    Map<String, dynamic> body = response.body;

    if (body['code'] == 201) {
      return body['message']; // 토큰 반환
    } else if (body['code'] == 403) {}
  }

  Future sendLogin(String memberPhone, String memberPassword) async {
    Response response = await post('/member/login',
        {'memberPhone': memberPhone, 'memberPassword': memberPassword});
    Map<String, dynamic> body = response.body;
    print("-----------으아아ㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏ" + body['message']);

    if (body['code'] != 200) {
      throw Exception(body['code']);
    }
    return body['message'];
  }
}
