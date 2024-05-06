import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:perst/src/connect/mypage_connect.dart';

final GetStorage _storage = GetStorage();

class PersonalColorHistory extends StatefulWidget {
  const PersonalColorHistory({super.key});

  @override
  State<PersonalColorHistory> createState() => _PersonalColorHistoryState();
}

class _PersonalColorHistoryState extends State<PersonalColorHistory> {
  final mypageConnect = Get.put(MypageConnect());

  @override
  void initState() {
    super.initState();
    Future results = mypageConnect.personalColorHistory();
    print(results);
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
