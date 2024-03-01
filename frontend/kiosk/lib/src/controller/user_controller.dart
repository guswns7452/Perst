import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kiosk/src/model/user_model.dart';
import '../connect/user_connect.dart';

final GetStorage _storage = GetStorage();

// 회원 동작과 관련된 모든 상태를 공통으로 관리하는 controller
class UserController extends GetxController {
  // UserConnect 객체를 생성 (의존성 주입)
  final userConnection = Get.put(UserConnect());

  UserModel? user;

  // 로그인이 되어있는지 판단
  // Future<bool> isLogin() async {
  //   // access_token이 있습니까?
  //   return _storage.hasData('access_token');
  // }

  // 회원가입을 시도하는 합수, connect호출
//   {
//     "memberName": "전현준",
//     "memberPhone": "01058559687",
//     "memberPassword": "1234",
//     "memberBirth": "2024-02-26",
// 	  "memberGender": "man/woman",
// 	  "memberHeight": 180.4,
// 	  "memberWeight": 62.8
// }
  Future<bool> register(String memberName, String memberEmail,
      String memberPhone, String memberPassword) async {
    try {
      String token = await userConnection.sendRegister(
          memberName, memberEmail, memberPhone, memberPassword);
      await _storage.write('access_token', token);
      return true;
    } catch (e) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
        content: Text("$e"),
      ));
      return false;
    }
  }

  // 로그인을 시도하는 함수, connect호출
  Future login(String memberPhone, String memberPassword) async {
    try {
      String token =
          await userConnection.sendLogin(memberPhone, memberPassword);
      await _storage.write('access_token', token);
      print(_storage.read('access_token'));
      return true;
    } catch (e) {
      print('Error : $e');
      return false;
    }
  }
}
