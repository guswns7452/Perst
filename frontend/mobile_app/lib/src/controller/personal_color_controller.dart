import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:perst/src/connect/personal_color_connect.dart';

final GetStorage _storage = GetStorage();

class PersonalColorController extends GetxController {
  final personalColorConnection = Get.put(PersonalColorConnect());

  Future sendPersonalColor(
      String personalColorType,
      int personalColorAllTimes,
      String personalSelectTypeOne,
      String personalSelectTypeTwo,
      String personalSelectTypeThree,
      int personalSelectTimesOne,
      int personalSelectTimesTwo,
      int personalSelectTimesThree) async {
    try {
      Map<String, dynamic> results =
          await personalColorConnection.personalAnalyze(
              personalColorType,
              personalColorAllTimes,
              personalSelectTypeOne,
              personalSelectTypeTwo,
              personalSelectTypeThree,
              personalSelectTimesOne,
              personalSelectTimesTwo,
              personalSelectTimesThree);
      print(results);
    } catch (e) {
      print('Error: $e');
    }
  }
}
