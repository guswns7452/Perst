import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:perst/src/connect/fashion_search_connect.dart';
import 'package:perst/src/model/fashion_search_model.dart';
import 'package:perst/src/screen/style/fashionDetail.dart';
import 'package:perst/src/widget/google_drive_image.dart';
import 'package:perst/src/widget/radio_item.dart';

final GetStorage _storage = GetStorage();

class PersonalColorFashion extends StatefulWidget {
  final String personalColor;

  const PersonalColorFashion({super.key, required this.personalColor});

  @override
  State<PersonalColorFashion> createState() => _PersonalColorFashionState();
}

String _searchCurrentStyle = '';
int _currentStyleInt = 1;

class _PersonalColorFashionState extends State<PersonalColorFashion> {
  final fashionSearchConnect = Get.put(FashionSearchConnect());
  late List<FashionSearchModel> fashions = [];
  final String _selectedGender = _storage.read("gender");

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    if (_selectedGender == "woman") {
      var response = await fashionSearchConnect.searchWoman(
          _searchCurrentStyle, false, [], "all");
      List<dynamic> results = response['data'];
      setState(() {
        fashions = results
            .map((result) => FashionSearchModel.fromJson(result))
            .toList();
      });
    } else if (_selectedGender == "man") {
      var response = await fashionSearchConnect.searchMan(
          _searchCurrentStyle, false, [], "all");
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
    final List<StyleRadioModel> _manstyleKeyward = [
      StyleRadioModel(true, '스포티', 'sporty'),
      StyleRadioModel(false, '로맨틱', 'romantic'),
      StyleRadioModel(false, '미니멀', 'minimal'),
      StyleRadioModel(false, '캐주얼', 'casual'),
      StyleRadioModel(false, '스트릿', 'street'),
      StyleRadioModel(false, '고프코어', 'gofcore'),
      StyleRadioModel(false, '아메카지', 'Amekaji'),
      StyleRadioModel(false, '비즈니스캐주얼', 'businessCasual'),
      StyleRadioModel(false, '댄디', 'dandy'),
      StyleRadioModel(false, '골프', 'golf'),
      StyleRadioModel(false, '시크', 'chic'),
    ];

    final List<StyleRadioModel> _womanstyleKeyward = [
      StyleRadioModel(true, '스포티', 'sporty'),
      StyleRadioModel(false, '로맨틱', 'romantic'),
      StyleRadioModel(false, '레트로', 'retro'),
      StyleRadioModel(false, '캐주얼', 'casual'),
      StyleRadioModel(false, '스트릿', 'street'),
      StyleRadioModel(false, '고프코어', 'gofcore'),
      StyleRadioModel(false, '아메카지', 'Amekaji'),
      StyleRadioModel(false, '비즈니스캐주얼', 'businessCasual'),
      StyleRadioModel(false, '시크', 'chic'),
      StyleRadioModel(false, '골프', 'golf'),
      StyleRadioModel(false, '걸리시', 'girlish'),
    ];

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 40),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                SizedBox(width: 20),
                for (var i = 0; i < 11; i++)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (_selectedGender == 'man') {
                          _searchCurrentStyle = _manstyleKeyward[i].keyward;
                          _currentStyleInt = i;
                          getData();
                        } else if (_selectedGender == 'woman')
                          _searchCurrentStyle = _womanstyleKeyward[i].keyward;
                        _currentStyleInt = i;
                        getData();
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 10),
                      padding: EdgeInsets.fromLTRB(8, 5, 8, 5),
                      height: 40.0,
                      decoration: BoxDecoration(
                        color: _currentStyleInt == i
                            ? Colors.black
                            : Colors.transparent,
                        border: Border.all(
                          width: 1.0,
                          color: _currentStyleInt == i
                              ? Colors.black
                              : Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          _selectedGender == "woman"
                              ? _womanstyleKeyward[i].buttonText
                              : _manstyleKeyward[i].buttonText,
                          style: TextStyle(
                            color: _currentStyleInt == i
                                ? Colors.white
                                : Colors.black,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ),
                  )
              ],
            ),
          ),
          SizedBox(height: 27),
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
                                        personalColorChecked: true,
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
