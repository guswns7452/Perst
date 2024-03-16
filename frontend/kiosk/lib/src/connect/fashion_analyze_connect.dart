import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kiosk/shared/global.dart';

final GetStorage _storage = GetStorage();

class FashionAnalyzeConnect {
  // 토큰 받아오기
  get getToken async {
    return _storage.read("access_token");
  }

  final Dio _dio = Dio();
  Dio dio = Dio(BaseOptions(
    baseUrl: Global.apiRoot, // 여기에 서버 주소를 설정하세요.
  ));

  Future<Map<String, dynamic>> uploadImage(File imageFile) async {
    try {
      FormData formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(imageFile.path),
      });

      Response response = await dio.post(
        '/clothes/analyze',
        data: formData,
        options: Options(
          headers: {
            'Authorization':
                'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiI5IiwiaWF0IjoxNzEwNjAzODYzLCJleHAiOjEwMDAwMTcxMDYwMzg2M30.G0lNha3FQvdTGX6Kby5zSkXxgyU6Ne29i9c028kS6wE',
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      Map<String, dynamic> extractDataFromResponse(Response response) {
        try {
          Map<String, dynamic> responseData = json.decode(response.toString());
          if (responseData.containsKey('data')) {
            return responseData['data'];
          }
        } catch (e) {
          print('서버 통신오류: $e');
        }
        throw Exception('서버 통신오류');
      }

      if (response.statusCode == 200) {
        print(extractDataFromResponse(response));
        return extractDataFromResponse(response);
      } else {
        throw Exception('서버 통신오류');
      }
    } catch (e) {
      throw Exception('서버 통신오류: $e');
    }
  }
}
