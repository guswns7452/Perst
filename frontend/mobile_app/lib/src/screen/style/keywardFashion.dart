import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:perst/src/controller/fashion_search_controller.dart';
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
  final fashionSearchController = Get.put(FashionSearchController());
  late Future<List<FashionSearchModel>>? fashions;

  @override
  void initState() {
    super.initState();
    String gender = _storage.read("gender");
    print(gender);
    if (gender == "woman") {
      print("여자");
      fashions = fashionSearchController.searchWoman(widget.styleKeyword, true);
      print(widget.styleKeyword);
    } else if (gender == "man") {
      print("남자");
      fashions = fashionSearchController.searchMan(widget.styleKeyword, true);
    }
    // 여기도 API에 따라서 변경해야함.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 30),
          Text(
            '* 해당 제품을 클릭하면 자세한 정보를 확인할 수 있습니다.*',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 30),
          Expanded(
            child: FutureBuilder<List<FashionSearchModel>>(
              future: fashions,
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
                          mainAxisSpacing: 10),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        var fashion = snapshot.data![index];
                        return Stack(children: [
                          google_drive_image(
                            id: fashion.musinsaFileid!,
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
                      });
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
