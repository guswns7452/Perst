import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:kiosk/shared/global.dart';

class FashionAnalyzeConnect {
  String token =
      'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiI4IiwiaWF0IjoxNzA5NzQzMjMxLCJleHAiOjE3MDk4NDMyMzF9.zu_56mspD8SA-GJ0K6z-mJqGNQmIE5pTbXlW0deH9oY'; // 토큰 값이 어디서 와야하는지 알 수 없어서 일단 비워두었습니다.

  final Dio _dio = Dio();
  Dio dio = Dio(BaseOptions(
    baseUrl: Global.apiRoot, // 여기에 서버 주소를 설정하세요.
  ));

  Future<bool> uploadImage(File imageFile) async {
    try {
      FormData formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(imageFile.path),
      });

      Response response = await dio.post(
        '/clothes/analyze', // 여기에 API 엔드포인트를 추가하세요
        data: formData,
        options: Options(
          headers: {
            'Authorization': token,
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      Map<String, dynamic>? extractDataFromResponse(Response response) {
        try {
          Map<String, dynamic> responseData = json.decode(response.toString());
          if (responseData.containsKey('data')) {
            return responseData['data'];
          }
        } catch (e) {
          print('Error extracting data from response: $e');
        }
        return null;
      }

      if (response.statusCode == 200) {
        print(extractDataFromResponse(response));
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error uploading image: $e');
      return false;
    }
  }
}
