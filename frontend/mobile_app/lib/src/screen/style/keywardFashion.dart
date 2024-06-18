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
  final String kRStyleName;
  final String personalColor;

  const KeywordFashion(
      {required this.styleKeyword,
      Key? key,
      required this.kRStyleName,
      required this.personalColor})
      : super(key: key);

  @override
  State<KeywordFashion> createState() => _KeywordFashionState();
}

class _KeywordFashionState extends State<KeywordFashion> {
  final fashionSearchConnect = Get.put(FashionSearchConnect());
  late List<FashionSearchModel> fashions = [];
  late bool personalColorChecked;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    String gender = _storage.read("gender");
    print(gender);
    if (gender == "woman") {
      if (widget.personalColor == '') {
        personalColorChecked = false;
        var response = await fashionSearchConnect.searchWoman(
            widget.styleKeyword, false, [], "all");
        List<dynamic> results = response['data'];
        setState(() {
          fashions = results
              .map((result) => FashionSearchModel.fromJson(result))
              .toList();
        });
      } else {
        personalColorChecked = true;
        var response = await fashionSearchConnect.searchWoman(
            widget.styleKeyword, true, [], "all");
        List<dynamic> results = response['data'];
        setState(() {
          fashions = results
              .map((result) => FashionSearchModel.fromJson(result))
              .toList();
        });
      }
    } else if (gender == "man") {
      if (widget.personalColor == '') {
        personalColorChecked = false;
        var response = await fashionSearchConnect.searchMan(
            widget.styleKeyword, false, [], "all");
        List<dynamic> results = response['data'];
        setState(() {
          fashions = results
              .map((result) => FashionSearchModel.fromJson(result))
              .toList();
        });
      } else {
        personalColorChecked = true;
        var response = await fashionSearchConnect.searchMan(
            widget.styleKeyword, true, [], "all");
        List<dynamic> results = response['data'];
        setState(() {
          fashions = results
              .map((result) => FashionSearchModel.fromJson(result))
              .toList();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 27),
          Row(
            children: [
              SizedBox(width: 18),
              Text(
                '<',
                style: TextStyle(fontSize: 25, color: Colors.grey),
              ),
              Container(
                margin: EdgeInsets.only(left: 10),
                padding: EdgeInsets.fromLTRB(7, 0, 7, 0),
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 236, 236, 236),
                    borderRadius: BorderRadius.circular(5)),
                height: 35,
                width: 355,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.personalColor == ''
                          ? widget.kRStyleName + ' 코디법'
                          : widget.personalColor + ' 코디법',
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      child: Icon(Icons.clear, size: 17),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Color.fromARGB(255, 209, 209, 209)),
                      padding: EdgeInsets.fromLTRB(3, 3, 3, 3),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Color.fromARGB(255, 228, 238, 244)),
              padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
              margin: EdgeInsets.only(left: 18, bottom: 20, top: 15),
              child: Text(
                widget.kRStyleName,
                style: TextStyle(
                    color: Color.fromARGB(255, 79, 106, 133),
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
            ),
            widget.personalColor == ''
                ? Container()
                : Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color.fromARGB(255, 228, 238, 244)),
                    padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
                    margin: EdgeInsets.only(left: 5, bottom: 20, top: 15),
                    child: Text(
                      widget.personalColor,
                      style: TextStyle(
                          color: Color.fromARGB(255, 79, 106, 133),
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Color.fromARGB(255, 228, 238, 244)),
              padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
              margin: EdgeInsets.only(left: 5, bottom: 20, top: 15),
              child: Text(
                '코디법',
                style: TextStyle(
                    color: Color.fromARGB(255, 79, 106, 133),
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ]),
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
                                        personalColorChecked:
                                            personalColorChecked,
                                        keywardChecked: true,
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
