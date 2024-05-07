import 'package:get/get.dart';
import 'package:perst/src/connect/mypage_connect.dart';
import 'package:perst/src/model/mypage_model.dart';

class MypageController extends GetxController {
  final mypageConnection = Get.put(MypageConnect());

  // 마이페이지 스타일 이력 조회 불러오기
  Future<Map<String, dynamic>> sendStyleHistory() async {
    try {
      Map<String, dynamic> results = await mypageConnection.styleHistory();
      List<dynamic> fashions = results['myAnalyzeList'];
      List<MystyleModel> fashion = [];
      for (var result in fashions) {
        fashion.add(MystyleModel.fromJson(result));
      }

      results = {
        "myAnalyzeList": fashion,
        "myStyle": results["myStyle"],
        "myStyleLength": results['myStyleLength']
      };
      return results;
    } catch (e) {
      print('Error in sendStyleHistory: $e');
      throw Exception('통신오류입니다.');
    }
  }
}
