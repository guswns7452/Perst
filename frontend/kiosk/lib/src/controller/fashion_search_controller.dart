import 'package:get/get.dart';
import 'package:kiosk/src/connect/fashion_search_connect.dart';
import 'package:kiosk/src/model/fashion_search_model.dart';

class FashionSearchController extends GetxController {
  final fashionSearchConnection = Get.put(FashionSearchConnect());

  Future<List<FashionSearchModel>> searchWoman(
      String womanFashionKeyword) async {
    try {
      List<dynamic> results =
          await fashionSearchConnection.searchWoman(womanFashionKeyword);
      List<FashionSearchModel> fashions = [];
      for (var result in results) {
        fashions.add(FashionSearchModel.fromJson(result));
      }
      print(fashions.toString());
      return fashions;
    } catch (e) {
      print('Error in searchWoman: $e');
      throw Exception('Failed to search woman fashion');
    }
  }

  Future SearchMan(manFachionKeyword) async {
    try {
      List<dynamic> results =
          await fashionSearchConnection.searchMan(manFachionKeyword);
      Iterator<dynamic> iterator = results.iterator;
      List<FashionSearchModel> fashions = [];
      while (iterator.moveNext()) {
        fashions.add(FashionSearchModel.fromJson(iterator.current));
      }
      print(fashions.toString());
      return fashions;
    } catch (e) {
      return false;
    }
  }
}
