import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:perst/src/connect/mypage_connect.dart';

final GetStorage _storage = GetStorage();

class ModifyInformation extends StatefulWidget {
  const ModifyInformation({super.key});

  @override
  State<ModifyInformation> createState() => _ModifyInformationState();
}

class _ModifyInformationState extends State<ModifyInformation> {
  final mypageConnect = Get.put(MypageConnect());

  @override
  void initState() {
    super.initState();
    Future results = mypageConnect.showInformation();
    print(results);
  }

  _patchInformation() async {
    Future results = mypageConnect.patchInformation("이다현", "01077777777", "1234", "2002-07-31", "woman", 190, 10);
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
