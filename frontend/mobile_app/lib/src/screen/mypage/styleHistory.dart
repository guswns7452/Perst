import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:perst/src/model/mypage_model.dart';
import 'package:perst/src/widget/fl_chart.dart';

import '../../controller/mypage_controller.dart';
import '../../widget/google_drive_image.dart';

final GetStorage _storage = GetStorage();

class StyleHistory extends StatefulWidget {
  const StyleHistory({super.key});

  @override
  State<StyleHistory> createState() => _StyleHistoryState();
}

class _StyleHistoryState extends State<StyleHistory> {
  final mypageController = Get.put(MypageController());
  late List<MystyleModel> fashion = [];
  late Map<String, dynamic> results = {};
  late Map<String, dynamic> styleResult = {};
  late int myStyleLength;
  bool isLoading = true;
  String name = _storage.read("name");
  String gender = _storage.read("gender");

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
    myStyleLength = results['myStyleLength'];

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
            body: Container(
              color: Colors.white,
              child: ListView(
                children: [
                  Container(
                    height: 230,
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
                        style: TextStyle(
                            fontSize: 23, fontWeight: FontWeight.bold),
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
                  SizedBox(height: 15),
                  Container(
                      width: double.infinity,
                      height: 510,
                      child: CustomDrawer(
                          fashion: fashion,
                          styleResult: styleResult,
                          myStyleLength: myStyleLength)),
                ],
              ),
            ),
          );
  }
}

class CustomDrawer extends StatefulWidget {
  final int myStyleLength;
  final Map<String, dynamic> styleResult;
  final List<MystyleModel> fashion;

  const CustomDrawer(
      {super.key,
      required this.fashion,
      required this.styleResult,
      required this.myStyleLength});

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  bool personalColorChecked = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Drawer(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(width: 0.5, color: Colors.grey))),
          child: Column(
            children: [
              TabBar(
                controller: _tabController,
                indicatorColor: Colors.black,
                labelColor: Colors.black,
                tabs: [
                  Tab(
                    icon: Image.asset(
                      'assets/gallery.png',
                      width: 25,
                      height: 25,
                    ),
                  ),
                  Tab(
                    icon: Image.asset(
                      'assets/presentation.png',
                      width: 25,
                      height: 25,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildStyleTab(widget.fashion, widget.styleResult,
                        widget.myStyleLength),
                    _buildGraphTab(widget.styleResult, widget.myStyleLength)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildStyleTab(List<MystyleModel> fashion,
    Map<String, dynamic> styleResult, int myStyleLength) {
  return Scaffold(
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
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
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "$value",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            key,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 10,
                                color:
                                    const Color.fromARGB(255, 195, 195, 195)),
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
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 30),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      var fashion = snapshot.data![index];
                      return Column(children: [
                        google_drive_image(
                          id: fashion.styleFileID!,
                        ),
                        SizedBox(height: 3),
                        Container(
                          width: 130,
                          child: Text(
                            "Style - " + fashion.styleName.toString(),
                            style: TextStyle(
                                fontSize: 9, fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          width: 130,
                          child: Text(
                            "Date - " +
                                fashion.styleDate.toString().split('T')[0],
                            style: TextStyle(
                                fontSize: 9, fontWeight: FontWeight.w500),
                          ),
                        )
                      ]);
                    });
              }
            },
          ),
        ),
      ],
    ),
  );
}

Widget _buildGraphTab(Map<String, dynamic> styleResult, int myStyleLength) {
  return Scaffold(
    body: Column(
      children: [
        Expanded(
          child: Center(
            child:
                FlChart(styleResult: styleResult, myStyleLength: myStyleLength),
          ),
        ),
      ],
    ),
  );
}
