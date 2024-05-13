import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:perst/src/connect/user_connect.dart';
import 'package:perst/src/model/user_model.dart';

final GetStorage _storage = GetStorage();

// 회원 동작과 관련된 모든 상태를 공통으로 관리하는 controller
class UserController extends GetxController {
  // UserConnect 객체를 생성
  final userConnection = Get.put(UserConnect());

  UserModel? user;

  // 회원가입을 시도하는 함수, connect 호출
  Future<bool> register(
      String memberName,
      String memberPhone,
      String memberPassword,
      String memberBirth,
      String memberGender,
      int memberHeight,
      int memberWeight) async {
    try {
      String token = await userConnection.sendRegister(
        memberName,
        memberPhone,
        memberPassword,
        memberBirth,
        memberGender,
        memberHeight,
        memberWeight,
      );
      await _storage.write('access_token', token);
      return true;
    } catch (e) {
      print('Error : $e');
      return false;
    }
  }

  // 로그인을 시도하는 함수, connect호출
  Future login(String memberPhone, String memberPassword) async {
    try {
      String token =
          await userConnection.sendLogin(memberPhone, memberPassword);
      await _storage.write('access_token', token);
      return true;
    } catch (e) {
      print('Error : $e');
      return false;
    }
  }
}
