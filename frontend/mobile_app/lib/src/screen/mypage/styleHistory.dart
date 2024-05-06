import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:perst/src/connect/mypage_connect.dart';

final GetStorage _storage = GetStorage();

class StyleHistory extends StatefulWidget {
  const StyleHistory({super.key});

  @override
  State<StyleHistory> createState() => _StyleHistoryState();
}

class _StyleHistoryState extends State<StyleHistory> {
  final mypageConnect = Get.put(MypageConnect());
  String name = _storage.read("name");
  String gender = _storage.read("gender");

  @override
  void initState() {
    super.initState();
    Future results = mypageConnect.styleHistory();
    print(results);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            height: 250,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15))),
          ),
          // TODO: 색 10개정도 list에 넣어서 랜덤으로 돌릴 예정
          SizedBox(height: 10),
          Row(
            children: [
              SizedBox(width: 10),
              Text(
                name,
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Row(
            children: [
              SizedBox(width: 10),
              Text(
                gender,
                style: TextStyle(
                    fontSize: 15,
                    color: gender == "woman"
                        ? Color.fromRGBO(255, 149, 149, 1)
                        : Color.fromRGBO(167, 214, 223, 1),
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Container(),
        ],
      ),
    );
  }
}
