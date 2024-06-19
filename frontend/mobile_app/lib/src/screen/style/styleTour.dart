import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:perst/src/connect/fashion_search_connect.dart';
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

String _currentStyle = '스포티';
String _searchCurrentStyle = 'sporty';
String _seletedGender = "man";
bool _personalColorChecked = false;
List<String> colorNameList = [];
List<Color> colorList = [];
String _seletedSeason = "all";
Color _currentColor = Color.fromRGBO(236, 20, 20, 1);
List<FashionSearchModel> fashions = [];

int _seletedGenderInt = 0;
int _currentStyleInt = 0;
int _currentColorInt = 0;
String personalColor = '';
bool isLoading = true;

class _StyleTourState extends State<StyleTour> {
  final fashionSearchConnect = Get.put(FashionSearchConnect());

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    setState(() {
      isLoading = true;
    });

    if (_seletedGenderInt == 1) {
      var response = await fashionSearchConnect.searchWoman(_searchCurrentStyle,
          _personalColorChecked, colorNameList, _seletedSeason);

      List<dynamic> results = response['data'];
      setState(() {
        fashions = results
            .map((result) => FashionSearchModel.fromJson(result))
            .toList();
        isLoading = false;
      });
    } else if (_seletedGenderInt == 0) {
      var response = await fashionSearchConnect.searchMan(_searchCurrentStyle,
          _personalColorChecked, colorNameList, _seletedSeason);
      List<dynamic> results = response['data'];
      setState(() {
        fashions = results
            .map((result) => FashionSearchModel.fromJson(result))
            .toList();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(15, 10, 15, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Perst',
                    style: GoogleFonts.archivoBlack(
                      textStyle: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w800,
                        color: Color.fromRGBO(255, 191, 25, 1),
                      ),
                    ),
                  ),
                  Text(
                    '스타일 둘러보기',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
                  ),
                  Text(
                    '원하는 스타일을 선택하고 의류를 둘러보세요!',
                    style: TextStyle(fontSize: 15),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Container(
                        height: 32,
                        child: OutlinedButton(
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
                          ),
                          child: Image.asset('assets/filter.png',
                              width: 16, height: 16),
                        ),
                      ),
                      SizedBox(width: 5),
                      StyleFilter(
                        colorList: colorList,
                        currentStyle: _currentStyle,
                        seletedGender: _seletedGender,
                        personalColor: personalColor,
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 191, 25, 0.3),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    height: 3,
                    width: double.infinity,
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            Builder(
              builder: (context) {
                if (isLoading) {
                  return Center(child: CircularProgressIndicator()); // 로딩 중일 때
                } else if (fashions.isEmpty) {
                  return Center(child: Text('검색 결과가 없습니다.')); // 데이터가 없을 때
                } else {
                  return Container(
                    height: 540,
                    child: StyleTourWidget(
                      fashions: fashions,
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CustomDrawer extends StatefulWidget {
  final Function(String, String, List<Color>) onSelectionComplete;
  final List<FashionSearchModel> fashions;

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

  final fashionSearchConnect = Get.put(FashionSearchConnect());

  Future<void> _handleSelectionComplete() async {
    try {
      if (_seletedGenderInt == 1) {
        var response = await fashionSearchConnect.searchWoman(
            _searchCurrentStyle,
            _personalColorChecked,
            colorNameList,
            _seletedSeason);

        List<dynamic> results = response['data'];
        setState(() {
          fashions = results
              .map((result) => FashionSearchModel.fromJson(result))
              .toList();
          isLoading = false;
          if (_personalColorChecked) {
            personalColor = response['message'];
          } else {
            personalColor = "";
          }
        });
      } else if (_seletedGenderInt == 0) {
        var response = await fashionSearchConnect.searchMan(_searchCurrentStyle,
            _personalColorChecked, colorNameList, _seletedSeason);
        List<dynamic> results = response['data'];
        setState(() {
          fashions = results
              .map((result) => FashionSearchModel.fromJson(result))
              .toList();
          isLoading = false;
          if (_personalColorChecked) {
            personalColor = response['message'];
          } else {
            personalColor = "";
          }
        });
      }
      ;
    } catch (e) {
      personalColor = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20.0),
          topLeft: Radius.circular(20.0),
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
                    Future.delayed(Duration(milliseconds: 500), () async {
                      await _handleSelectionComplete();
                      widget.onSelectionComplete(
                          _currentStyle, _seletedGender, colorList);
                      await Future.delayed(Duration(milliseconds: 500));
                      Navigator.pop(context);
                      setState(() {
                        colorList = [];
                        colorNameList = [];
                      });
                    });
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
    List<List<ColorRadioModel>> colorGroups = [];
    for (int i = 0; i < _colorList.length; i += 7) {
      colorGroups.add(_colorList.sublist(
          i, i + 7 > _colorList.length ? _colorList.length : i + 7));
    }

    return Container(
      margin: EdgeInsets.fromLTRB(10, 30, 10, 30),
      child: Column(
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
          Row(
            children: [
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

  Widget _buildSeasonTab() {
    return Container(
      margin: EdgeInsets.only(top: 30),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
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
                '🌷 Spring',
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
                '🌊 Summer',
                style: TextStyle(
                  fontSize: 18,
                  color:
                      _seletedSeason == 'summer' ? Colors.black : Colors.grey,
                ),
              ),
              SizedBox(width: 20),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
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
                '🍂 Autumn',
                style: TextStyle(
                  fontSize: 18,
                  color:
                      _seletedSeason == 'autumn' ? Colors.black : Colors.grey,
                ),
              ),
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
                '☃️ Winter',
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
