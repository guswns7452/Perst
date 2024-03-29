import 'package:flutter/material.dart';

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
                  '코디',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return CustomDrawer();
                      },
                    );
                  },
                  child: Text('Open Custom Drawer'),
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
    return Column(
      children: [
        SizedBox(height: 30),
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
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 20),
            for (var i = 6; i < 12; i++)
              InkWell(
                onTap: () {
                  setState(() {
                    _colorList.forEach((element) => element.isSelected = false);
                    _colorList[i].isSelected = true;
                  });
                },
                child: ColorRadioItem(_colorList[i]),
              ),
          ],
        ),
      ],
    );
  }
}

class StyleRadioItem extends StatelessWidget {
  final StyleRadioModel _item;
  StyleRadioItem(this._item);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(8, 5, 8, 5),
            height: 40.0,
            child: Center(
              child: Text(_item.buttonText,
                  style: TextStyle(
                      color: _item.isSelected ? Colors.white : Colors.black,
                      fontSize: 18.0)),
            ),
            decoration: BoxDecoration(
                color: _item.isSelected
                    ? const Color.fromARGB(255, 0, 0, 0)
                    : Colors.transparent,
                border: Border.all(
                    width: 1.0,
                    color: _item.isSelected
                        ? Color.fromARGB(255, 0, 0, 0)
                        : Colors.grey),
                borderRadius: BorderRadius.circular(10)),
          ),
        ],
      ),
    );
  }
}

class ColorRadioItem extends StatelessWidget {
  final ColorRadioModel _item;
  ColorRadioItem(this._item);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      child: Row(
        children: <Widget>[
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                color: Color.fromRGBO(_item.Red, _item.Green, _item.Blue, 1),
                borderRadius: BorderRadius.circular(50),
                border: Border.all(width: 0.3, color: Colors.black)),
          ),
        ],
      ),
    );
  }
}

class StyleRadioModel {
  bool isSelected;
  final String buttonText;
  final String keyward;

  StyleRadioModel(this.isSelected, this.buttonText, this.keyward);
}

class ColorRadioModel {
  bool isSelected;
  final int Red;
  final int Green;
  final int Blue;

  ColorRadioModel(this.isSelected, this.Red, this.Green, this.Blue);
}
