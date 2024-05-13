import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:perst/src/controller/fashion_search_controller.dart';
import 'package:perst/src/model/fashion_search_model.dart';
import 'package:perst/src/widget/radio_item.dart';
import 'package:perst/src/widget/style_filter.dart';

import '../../widget/style_tour_widget.dart';

final GetStorage _storage = GetStorage();

class StyleTour extends StatefulWidget {
  const StyleTour({Key? key});

  @override
  State<StyleTour> createState() => _StyleTourState();
}

late String _currentStyle = '스포티';
late String _searchCurrentStyle = 'sporty';
late String _seletedGender = "man";
bool _personalColorChecked = false;
List<String> colorNameList = [];
List<Color> colorList = [];
String _seletedSeason = "Spring";
late Color _currentColor = Color.fromRGBO(236, 20, 20, 1);
late Future<List<FashionSearchModel>> fashions;

int _seletedGenderInt = 0;
int _currentStyleInt = 0;
int _currentColorInt = 0;

class _StyleTourState extends State<StyleTour> {
  final fashionSearchController = Get.put(FashionSearchController());
  String gender = _storage.read("gender");

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    setState(() {
      isLoading = true;
      if (gender == "man") {
        _seletedGender = "남성";
        _seletedGenderInt = 0;
      } else {
        _seletedGender = "여성";
        _seletedGenderInt = 1;
      }
    });
    _seletedGender = gender;
    gender == "man" ? _seletedGenderInt = 0 : _seletedGenderInt = 1;

    if (_seletedGenderInt == 1) {
      fashions = fashionSearchController.searchWoman(_searchCurrentStyle,
          _personalColorChecked, colorNameList, _seletedSeason);
    } else if (_seletedGenderInt == 0) {
      fashions = fashionSearchController.searchMan(_searchCurrentStyle,
          _personalColorChecked, colorNameList, _seletedSeason);
    }

    setState(() {
      if (fashions != null) {
        isLoading = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return fashions == null
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(15, 10, 15, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Perst',
                      style: TextStyle(
                        fontSize: 45,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(255, 191, 25, 1),
                      ),
                    ),
                    Text(
                      '스타일 둘러보기',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
                    ),
                    Text(
                      '원하는 스타일을 선택하고 의류를 둘러보세요!',
                      style: TextStyle(fontSize: 15),
                    ),
                    SizedBox(height: 15),
                    Container(
                      width: double.infinity,
                      height: 1,
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(240, 240, 240, 1),
                          borderRadius: BorderRadius.circular(50)),
                    ),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        OutlinedButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return CustomDrawer(
                                  onSelectionComplete: (selectedStyle,
                                      selectedGender, selectedColor) {
                                    setState(() {
                                      _currentStyle = selectedStyle;
                                      _seletedGender = selectedGender;
                                      selectedGender = "";
                                    });
                                  },
                                  fashions: fashions,
                                );
                              },
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 10),
                          ),
                          child: Image.asset('assets/filter.png',
                              width: 20, height: 20),
                        ),
                        SizedBox(width: 5),
                        StyleFilter(
                            colorList: colorList,
                            currentStyle: _currentStyle,
                            seletedGender: _seletedGender)
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 191, 25, 0.3),
                    borderRadius: BorderRadius.circular(50)),
                height: 3,
                width: double.infinity,
                margin: EdgeInsets.only(left: 15, right: 15),
              ),
              SizedBox(height: 15),
              Container(
                height: 450,
                child: StyleTourWidget(
                  fashions: fashions,
                ),
              )
            ],
          ));
  }
}

class CustomDrawer extends StatefulWidget {
  final Function(String, String, List<Color>) onSelectionComplete;
  final Future<List<FashionSearchModel>> fashions;

  const CustomDrawer(
      {Key? key, required this.onSelectionComplete, required this.fashions})
      : super(key: key);

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<StyleRadioModel> _manstyleKeyward = [
    StyleRadioModel(false, '스포티', 'sporty'),
    StyleRadioModel(true, '로맨틱', 'romantic'),
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
    StyleRadioModel(false, '스포티', 'sporty'),
    StyleRadioModel(true, '로맨틱', 'romantic'),
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

  final List<ColorRadioModel> _colorList = [
    ColorRadioModel(false, 204, 41, 54, "red"),
    ColorRadioModel(false, 230, 109, 23, "orange"),
    ColorRadioModel(false, 230, 230, 23, "yellow"),
    ColorRadioModel(false, 186, 217, 33, "lime"),
    ColorRadioModel(false, 77, 191, 77, "green"),
    ColorRadioModel(false, 54, 217, 217, "sky"),
    ColorRadioModel(false, 230, 69, 203, "pink"),
    ColorRadioModel(false, 125, 71, 179, "purple"),
    ColorRadioModel(false, 61, 85, 204, "blue"),
    ColorRadioModel(false, 25, 42, 128, "navy"),
    ColorRadioModel(false, 255, 255, 255, "white"),
    ColorRadioModel(false, 147, 145, 153, "grey"),
    ColorRadioModel(false, 0, 0, 0, "black"),
    ColorRadioModel(false, 115, 75, 34, "brown"),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  final fashionSearchController = Get.put(FashionSearchController());

  void _handleSelectionComplete() {
    setState(() {
      if (_seletedGenderInt == 1) {
        fashions = fashionSearchController.searchWoman(_searchCurrentStyle,
            _personalColorChecked, colorNameList, _seletedSeason);
      } else if (_seletedGenderInt == 0) {
        fashions = fashionSearchController.searchMan(_searchCurrentStyle,
            _personalColorChecked, colorNameList, _seletedSeason);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
        ),
      ),
      child: Drawer(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0),
            ),
          ),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0, 15, 0, 5),
                child: Text(
                  '필터',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
              ),
              TabBar(
                controller: _tabController,
                indicatorColor: Colors.black,
                labelColor: Colors.black,
                tabs: [
                  Tab(text: '성별'),
                  Tab(text: '스타일'),
                  Tab(text: '색감'),
                  Tab(text: '계절'),
                ],
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildGenderTab(),
                    _buildStyleTab(),
                    _buildColorTab(),
                    _buildSeasonTab()
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (_seletedGenderInt == 0) {
                          _searchCurrentStyle =
                              _manstyleKeyward[_currentStyleInt].keyward;
                          _currentStyle =
                              _manstyleKeyward[_currentStyleInt].buttonText;
                          _seletedGender = 'man';
                        } else if (_seletedGenderInt == 1) {
                          _searchCurrentStyle =
                              _womanstyleKeyward[_currentStyleInt].keyward;
                          _currentStyle =
                              _womanstyleKeyward[_currentStyleInt].buttonText;
                          _seletedGender = 'woman';
                        }
                        _currentColor = Color.fromRGBO(
                          _colorList[_currentColorInt].Red,
                          _colorList[_currentColorInt].Green,
                          _colorList[_currentColorInt].Blue,
                          1,
                        );

                        widget.onSelectionComplete(
                            _currentStyle, _seletedGender, colorList);
                        _handleSelectionComplete();
                        Future.delayed(Duration(milliseconds: 1000), () async {
                          return Navigator.pop(context);
                        }).then((value) => setState(() {
                              colorList = [];
                              colorNameList = [];
                            }));
                      });
                    },
                    child: Text(
                      '선택 완료',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGenderTab() {
    return Container(
      margin: EdgeInsets.only(top: 30),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(width: 40),
              Radio<String>(
                value: 'man',
                groupValue: _seletedGender,
                onChanged: (String? value) {
                  setState(() {
                    _seletedGender = value!;
                    _seletedGenderInt = 0;
                  });
                },
              ),
              Text(
                'MAN',
                style: TextStyle(
                  fontSize: 18,
                  color: _seletedGender == 'man' ? Colors.black : Colors.grey,
                ),
              ),
              SizedBox(width: 100),
              Radio<String>(
                value: 'woman',
                groupValue: _seletedGender,
                onChanged: (String? value) {
                  setState(() {
                    _seletedGender = value!;
                    _seletedGenderInt = 1;
                  });
                },
              ),
              Text(
                'WOMEN',
                style: TextStyle(
                  fontSize: 18,
                  color: _seletedGender == 'woman' ? Colors.black : Colors.grey,
                ),
              ),
            ],
          ),
          Row(
            children: [
              SizedBox(width: 20),
              Checkbox(
                value: _personalColorChecked,
                onChanged: (value) {
                  setState(() {
                    _personalColorChecked = value!;
                  });
                },
              ),
              Text(
                "내 퍼스널 컬러 반영하여 의류 검색하기",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStyleTab() {
    return Column(
      children: [
        SizedBox(height: 15),
        Row(
          children: [
            SizedBox(width: 20),
            for (var i = 0; i < 5; i++)
              InkWell(
                splashColor: Colors.black,
                onTap: () {
                  setState(() {
                    if (_seletedGender == 'man') {
                      _manstyleKeyward
                          .forEach((element) => element.isSelected = false);
                      _manstyleKeyward[i].isSelected = true;
                      _searchCurrentStyle = _manstyleKeyward[i].keyward;
                      _currentStyle = _manstyleKeyward[i].buttonText;
                      _currentStyleInt = i;
                    } else {
                      _womanstyleKeyward
                          .forEach((element) => element.isSelected = false);
                      _womanstyleKeyward[i].isSelected = true;
                      _searchCurrentStyle = _womanstyleKeyward[i].keyward;
                      _currentStyle = _womanstyleKeyward[i].buttonText;
                      _currentStyleInt = i;
                    }
                  });
                },
                child: StyleRadioItem(_seletedGender == 'man'
                    ? _manstyleKeyward[i]
                    : _womanstyleKeyward[i]),
              )
          ],
        ),
        SizedBox(height: 15),
        Row(
          children: [
            SizedBox(width: 20),
            for (var i = 5; i < 9; i++)
              InkWell(
                splashColor: Colors.black,
                onTap: () {
                  setState(() {
                    if (_seletedGender == 'man') {
                      _manstyleKeyward
                          .forEach((element) => element.isSelected = false);
                      _manstyleKeyward[i].isSelected = true;
                      _searchCurrentStyle = _manstyleKeyward[i].keyward;
                      _currentStyle = _manstyleKeyward[i].buttonText;
                      _currentStyleInt = i;
                    } else {
                      _womanstyleKeyward
                          .forEach((element) => element.isSelected = false);
                      _womanstyleKeyward[i].isSelected = true;
                      _searchCurrentStyle = _womanstyleKeyward[i].keyward;
                      _currentStyle = _womanstyleKeyward[i].buttonText;
                      _currentStyleInt = i;
                    }
                  });
                },
                child: StyleRadioItem(_seletedGender == 'man'
                    ? _manstyleKeyward[i]
                    : _womanstyleKeyward[i]),
              )
          ],
        ),
        SizedBox(height: 15),
        Row(
          children: [
            SizedBox(width: 20),
            for (var i = 9; i < 11; i++)
              InkWell(
                splashColor: Colors.black,
                onTap: () {
                  setState(() {
                    if (_seletedGender == 'man') {
                      _manstyleKeyward
                          .forEach((element) => element.isSelected = false);
                      _manstyleKeyward[i].isSelected = true;
                      _searchCurrentStyle = _manstyleKeyward[i].keyward;
                      _currentStyle = _manstyleKeyward[i].buttonText;
                      _currentStyleInt = i;
                    } else {
                      _womanstyleKeyward
                          .forEach((element) => element.isSelected = false);
                      _womanstyleKeyward[i].isSelected = true;
                      _searchCurrentStyle = _womanstyleKeyward[i].keyward;
                      _currentStyle = _womanstyleKeyward[i].buttonText;
                      _currentStyleInt = i;
                    }
                  });
                },
                child: StyleRadioItem(_seletedGender == 'man'
                    ? _manstyleKeyward[i]
                    : _womanstyleKeyward[i]),
              )
          ],
        ),
      ],
    );
  }

  Widget _buildColorTab() {
    final fashionSearchController = Get.put(FashionSearchController());

    List<List<ColorRadioModel>> colorGroups = [];
    for (int i = 0; i < _colorList.length; i += 7) {
      colorGroups.add(_colorList.sublist(
          i, i + 7 > _colorList.length ? _colorList.length : i + 7));
    }

    return Container(
      margin: EdgeInsets.fromLTRB(10, 30, 10, 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              for (var group in colorGroups)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (var color in group)
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            color.isSelected = !color.isSelected;
                            if (color.isSelected) {
                              colorNameList.add(color.ColorName);
                              colorList.add(Color.fromRGBO(
                                  color.Red, color.Green, color.Blue, 1));
                            } else {
                              colorNameList.remove(color.ColorName);
                              colorList.remove(Color.fromRGBO(
                                  color.Red, color.Green, color.Blue, 1));
                            }
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: ColorRadioItem(color),
                        ),
                      ),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSeasonTab() {
    return Container(
      margin: EdgeInsets.only(top: 30),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(width: 10),
              Radio<String>(
                value: 'spring',
                groupValue: _seletedSeason,
                onChanged: (String? value) {
                  setState(() {
                    _seletedSeason = value!;
                    print(_seletedSeason);
                  });
                },
              ),
              Text(
                'Spring',
                style: TextStyle(
                  fontSize: 18,
                  color:
                      _seletedSeason == 'spring' ? Colors.black : Colors.grey,
                ),
              ),
              SizedBox(width: 20),
              Radio<String>(
                value: 'summer',
                groupValue: _seletedSeason,
                onChanged: (String? value) {
                  setState(() {
                    _seletedSeason = value!;
                    print(_seletedSeason);
                  });
                },
              ),
              Text(
                'Summer',
                style: TextStyle(
                  fontSize: 18,
                  color:
                      _seletedSeason == 'summer' ? Colors.black : Colors.grey,
                ),
              ),
              SizedBox(width: 20),
              Radio<String>(
                value: 'autumn',
                groupValue: _seletedSeason,
                onChanged: (String? value) {
                  setState(() {
                    _seletedSeason = value!;
                    print(_seletedSeason);
                  });
                },
              ),
              Text(
                'Autumn',
                style: TextStyle(
                  fontSize: 18,
                  color:
                      _seletedSeason == 'autumn' ? Colors.black : Colors.grey,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(width: 10),
              Radio<String>(
                value: 'winter',
                groupValue: _seletedSeason,
                onChanged: (String? value) {
                  setState(() {
                    _seletedSeason = value!;
                    print(_seletedSeason);
                  });
                },
              ),
              Text(
                'Winter',
                style: TextStyle(
                  fontSize: 18,
                  color:
                      _seletedSeason == 'winter' ? Colors.black : Colors.grey,
                ),
              ),
              SizedBox(width: 20),
              Radio<String>(
                value: 'all',
                groupValue: _seletedSeason,
                onChanged: (String? value) {
                  setState(() {
                    _seletedSeason = value!;
                    print(_seletedSeason);
                  });
                },
              ),
              Text(
                'All',
                style: TextStyle(
                  fontSize: 18,
                  color: _seletedSeason == 'all' ? Colors.black : Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
