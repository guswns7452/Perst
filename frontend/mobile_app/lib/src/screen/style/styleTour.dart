import 'package:flutter/material.dart';
import 'package:perst/src/widget/radio_item.dart';

class StyleTour extends StatefulWidget {
  const StyleTour({Key? key});

  @override
  State<StyleTour> createState() => _StyleTourState();
}

class _StyleTourState extends State<StyleTour> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
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
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
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
                            return CustomDrawer();
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
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 4, 10, 4),
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 1,
                              color: Color.fromRGBO(133, 133, 133, 1)),
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        '남성',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(width: 5),
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 4, 10, 4),
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 1,
                              color: Color.fromRGBO(133, 133, 133, 1)),
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        '로맨틱',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(width: 5),
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 4, 10, 4),
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 1,
                              color: Color.fromRGBO(133, 133, 133, 1)),
                          borderRadius: BorderRadius.circular(10)),
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(236, 20, 20, 1),
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(width: 0.3, color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<StyleRadioModel> _manstyleKeyward = [
    StyleRadioModel(true, '로맨틱', 'romantic'),
    StyleRadioModel(false, '스포티', 'sporty'),
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
    StyleRadioModel(true, '로맨틱', 'romantic'),
    StyleRadioModel(false, '스포티', 'sporty'),
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
    ColorRadioModel(true, 236, 20, 20),
    ColorRadioModel(false, 236, 20, 20),
    ColorRadioModel(false, 244, 170, 36),
    ColorRadioModel(false, 241, 242, 35),
    ColorRadioModel(false, 55, 180, 0),
    ColorRadioModel(false, 152, 208, 233),
    ColorRadioModel(false, 29, 44, 133),
    ColorRadioModel(false, 255, 255, 255),
    ColorRadioModel(false, 198, 198, 198),
    ColorRadioModel(false, 0, 0, 0),
    ColorRadioModel(false, 113, 132, 47),
    ColorRadioModel(false, 131, 22, 192),
  ];

  late String _currentStyle = '로맨틱';
  late String _searchCurrentStyle = 'romantic';
  late String _seletedGender = "man";

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
                  Tab(
                    text: '성별',
                  ),
                  Tab(text: '스타일'),
                  Tab(text: '색감'),
                ],
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildGenderTab(),
                    _buildStyleTab(),
                    _buildColorTab(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGenderTab() {
    return Container(
      margin: EdgeInsets.only(top: 30, bottom: 300),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(width: 40),
          Radio<String>(
            value: 'man',
            groupValue: _seletedGender,
            onChanged: (String? value) {
              setState(() {
                _seletedGender = value!;
              });
            },
          ),
          const Text(
            style: TextStyle(fontSize: 18),
            'MAN',
          ),
          SizedBox(width: 100),
          Radio<String>(
            value: 'woman',
            groupValue: _seletedGender,
            onChanged: (String? value) {
              setState(() {
                _seletedGender = value!;
              });
            },
          ),
          const Text(
            'WOMEN',
            style: TextStyle(fontSize: 18),
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
                    } else {
                      _womanstyleKeyward
                          .forEach((element) => element.isSelected = false);
                      _womanstyleKeyward[i].isSelected = true;
                      _searchCurrentStyle = _womanstyleKeyward[i].keyward;
                      _currentStyle = _womanstyleKeyward[i].buttonText;
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
                    } else {
                      _womanstyleKeyward
                          .forEach((element) => element.isSelected = false);
                      _womanstyleKeyward[i].isSelected = true;
                      _searchCurrentStyle = _womanstyleKeyward[i].keyward;
                      _currentStyle = _womanstyleKeyward[i].buttonText;
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
                    } else {
                      _womanstyleKeyward
                          .forEach((element) => element.isSelected = false);
                      _womanstyleKeyward[i].isSelected = true;
                      _searchCurrentStyle = _womanstyleKeyward[i].keyward;
                      _currentStyle = _womanstyleKeyward[i].buttonText;
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
    return Container(
      margin: EdgeInsets.fromLTRB(10, 30, 10, 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      SizedBox(width: 20),
                      for (var i = 0; i < 6; i++)
                        InkWell(
                          onTap: () {
                            setState(() {
                              _colorList.forEach(
                                  (element) => element.isSelected = false);
                              _colorList[i].isSelected = true;
                            });
                          },
                          child: ColorRadioItem(_colorList[i]),
                        ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 20),
                  for (var i = 6; i < 12; i++)
                    InkWell(
                      onTap: () {
                        setState(() {
                          _colorList
                              .forEach((element) => element.isSelected = false);
                          _colorList[i].isSelected = true;
                        });
                      },
                      child: ColorRadioItem(_colorList[i]),
                    ),
                ],
              ),
            ],
          ),
          Container(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // search man, woman해서 스타일 불러오기
                Navigator.pop(context); // drawer 닫기
                // TODO: gender, style, red, green, blue를 반환하든 뭐든 해서 선택된 성별, 스타일, 색상을 띄워야함.
              },
              child: Text(
                '선택 완료',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
          )
        ],
      ),
    );
  }
}
