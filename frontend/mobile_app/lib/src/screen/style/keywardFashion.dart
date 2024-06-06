import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:perst/src/connect/fashion_search_connect.dart';
import 'package:perst/src/model/fashion_search_model.dart';
import 'package:perst/src/screen/style/fashionDetail.dart';
import 'package:perst/src/widget/google_drive_image.dart';

final GetStorage _storage = GetStorage();

class KeywordFashion extends StatefulWidget {
  final String styleKeyword;

  const KeywordFashion({required this.styleKeyword, Key? key})
      : super(key: key);

  @override
  State<KeywordFashion> createState() => _KeywordFashionState();
}

class _KeywordFashionState extends State<KeywordFashion> {
  final fashionSearchConnect = Get.put(FashionSearchConnect());
  late List<FashionSearchModel> fashions;

  @override
  void initState() async {
    super.initState();
    getData();
  }

  getData() async {
    String gender = _storage.read("gender");
    print(gender);
    if (gender == "woman") {
      var response = await fashionSearchConnect.searchWoman(
          widget.styleKeyword, false, [], "all");
      List<dynamic> results = response['data'];
      setState(() {
        fashions = results
            .map((result) => FashionSearchModel.fromJson(result))
            .toList();
      });
      print(widget.styleKeyword);
    } else if (gender == "man") {
      var response = await fashionSearchConnect.searchMan(
          widget.styleKeyword, false, [], "all");
      List<dynamic> results = response['data'];
      setState(() {
        fashions = results
            .map((result) => FashionSearchModel.fromJson(result))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 50),
          Text(
            '* 해당 제품을 클릭하면 자세한 정보를 확인할 수 있습니다.*',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 30),
          Expanded(
            child: fashions.isEmpty
                ? Center(child: CircularProgressIndicator())
                : GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, mainAxisSpacing: 2),
                    itemCount: fashions.length,
                    itemBuilder: (context, index) {
                      var fashion = fashions[index];
                      return Stack(children: [
                        Row(
                          children: [
                            SizedBox(width: 35),
                            Container(
                              height: 230,
                              width: 145,
                              child: google_drive_image(
                                id: fashion.musinsaFileid!,
                              ),
                            ),
                          ],
                        ),
                        Positioned.fill(
                            child: Material(
                                color: Colors.transparent,
                                child: InkWell(onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FashionDetail(
                                        fashion: fashion,
                                      ),
                                    ),
                                  );
                                })))
                      ]);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
