// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:perst/src/screen/camera/cameraIntro.dart';

import '../../controller/mypage_controller.dart';
import '../../model/mypage_model.dart';
import '../../widget/google_drive_image.dart';
import '../mypage/styleHistoryDetail.dart';

class MyStyle extends StatefulWidget {
  const MyStyle({super.key});

  @override
  State<MyStyle> createState() => _MyStyleState();
}

class _MyStyleState extends State<MyStyle> {
  final mypageController = Get.put(MypageController());
  late List<MystyleModel> fashion = [];
  late Map<String, dynamic> results = {};
  late Map<String, dynamic> styleResult = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
    });

    results = await mypageController.sendStyleHistory();
    fashion = results['myAnalyzeList'];
    styleResult = results['myStyle'];
    styleResult = Map<String, dynamic>.fromEntries(styleResult.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value)));

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '로딩중입니다...',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 20),
                  CircularProgressIndicator(),
                ],
              ),
            ),
          )
        : Scaffold(
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.only(left: 25),
                  child: Text(
                    'Perst',
                    style: TextStyle(
                        color: Color.fromRGBO(255, 191, 25, 1),
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 25),
                  child: Text(
                    '스타일분석 이력',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                // 분석한 이력들이 없을 때
                // Container(
                //   width: double.infinity,
                //   height: 500,
                //   child: Column(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     crossAxisAlignment: CrossAxisAlignment.center,
                //     children: [
                //       Image.asset('assets/Closets.png', height: 80, width: 80),
                //       SizedBox(
                //         height: 8,
                //       ),
                //       Text(
                //         '등록한 스타일이 없어요.',
                //         style: TextStyle(
                //             fontSize: 15, color: Color.fromRGBO(153, 153, 153, 1)),
                //       )
                //     ],
                //   ),
                // ),
                Stack(
                  children: [
                    Container(
                      height: 70,
                      width: double.infinity,
                      margin: EdgeInsets.fromLTRB(25, 20, 25, 0),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 240, 240, 240),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    Positioned(
                      top: 35,
                      left: 35,
                      right: 35,
                      bottom: 0,
                      child: Container(
                        color: Colors.transparent,
                        child: ListView.builder(
                          itemCount: styleResult.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            final key = styleResult.keys.toList()[index];
                            final value = styleResult[key];
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "$value",
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    key,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 10,
                                        color: const Color.fromARGB(
                                            255, 195, 195, 195)),
                                  ),
                                  SizedBox(height: 6),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Expanded(
                  child: FutureBuilder<List<MystyleModel>>(
                    future: Future.value(fashion),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                            ),
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              var fashion = snapshot
                                  .data![snapshot.data!.length - 1 - index];
                              return Column(children: [
                                Container(
                                  width: 130,
                                  child: Text(
                                    "#" + fashion.styleName.toString(),
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Stack(children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 5),
                                    height: 183,
                                    width: 128,
                                    child: google_drive_image(
                                      id: fashion.styleFileID!,
                                    ),
                                  ),
                                  Positioned.fill(
                                      child: Material(
                                          color: Colors.transparent,
                                          child: InkWell(onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    StyleHistoryDetail(
                                                        number: fashion
                                                            .styleNumber!),
                                              ),
                                            );
                                          }))),
                                ]),
                                SizedBox(height: 3),
                              ]);
                            });
                      }
                    },
                  ),
                ),
              ],
            ),
            floatingActionButton:
                Column(mainAxisAlignment: MainAxisAlignment.end, children: [
              FloatingActionButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CameraIntro(),
                  ));
                },
                child: Image.asset('assets/add.png', height: 30, width: 30),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100)),
                backgroundColor: Colors.black,
              ),
              SizedBox(height: 15)
            ]),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
          );
  }
}
