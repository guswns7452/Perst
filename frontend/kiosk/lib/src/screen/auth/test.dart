import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiosk/src/controller/fashion_search_controller.dart';

class Test extends StatefulWidget {
  final String styleKeyword;

  const Test({required this.styleKeyword, Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  final fashionSearchController = Get.put(FashionSearchController());
  late Future<dynamic>? fashions;
  int fashionCount = 0;

  @override
  void initState() {
    super.initState();
    fashions = fashionSearchController.searchWoman('${widget.styleKeyword}');
    // _fetchFashionData(); // 비동기 작업 호출
  }

  // 비동기 작업을 수행하고 결과를 출력하는 함수
  // void _fetchFashionData() async {
  //   // 비동기 작업 수행
  //   fashions = fashionSearchController.SearchMan(widget.styleKeyword);
  //   // Future 객체의 결과를 기다림
  //   final result = await fashions;
  //   // 결과 출력
  //   print(result);
  //   // 결과를 UI에 반영하기 위해 상태 업데이트
  //   setState(() {
  //     // 상태 업데이트를 위한 작업 수행
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text(
            widget.styleKeyword,
            style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
          ),
          // Future의 결과를 출력하는 부분 추가
          FutureBuilder(
            future: fashions,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator(); // 로딩 중일 때
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}'); // 오류 발생 시
              } else {
                return Text('Fashions: $snapshot.data'); // 결과 출력
              }
            },
          ),
        ],
      ),
    );
  }
}
