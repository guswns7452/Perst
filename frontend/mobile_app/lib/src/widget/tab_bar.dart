import 'package:flutter/material.dart';
import 'package:perst/src/screen/style/myStyle.dart';
import 'package:perst/src/screen/style/personalColor.dart';
import 'package:perst/src/screen/style/styleAnalysis.dart';
import 'package:perst/src/screen/style/styleTour.dart';

class Tabbar extends StatefulWidget {
  const Tabbar({Key? key}) : super(key: key);

  @override
  State<Tabbar> createState() => _TabbarState();
}

class _TabbarState extends State<Tabbar> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    StyleTour(),
    StyleAnalysis(),
    MyStyle(),
    PersonalColor(),
  ]; // 선택된 tabbar마다 띄울 페이지 배열

  final List<List<String>> _tabIcons = <List<String>>[
    ['assets/lookOutlined.png', 'assets/lookColor.png'],
    ['assets/analysisOutlined.png', 'assets/analysisColor.png'],
    ['assets/mystyleOutlined.png', 'assets/mystyleColor.png'],
    ['assets/personalOutlined.png', 'assets/personalColor.png'],
  ];

  final List<String> _tabLabels = <String>[
    'StyleTour',
    'StyleAnalysis',
    'MyStyle',
    'PersonalColor'
  ];

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: Container(
          decoration:
              BoxDecoration(border: Border(bottom: BorderSide(width: 1.0))),
          child: IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              _scaffoldKey.currentState
                  ?.openDrawer(); // Scaffold key를 사용하여 Drawer 열기
            },
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(
                '이다현',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              accountEmail: Text(
                '여름라이트',
                style: TextStyle(color: Colors.lime[900]),
              ), // 퍼스널컬러 정의한거 띄우기 없으면 "퍼스널 컬러 정의 없음" 띄울까..
              decoration: BoxDecoration(
                color: Colors.pink[100],
              ),
            ),
            ListTile(
              title: Text("스타일 조회 이력"),
              onTap: () => {print("style")},
            ),
            ListTile(
              title: Text("퍼스널 컬러 진단결과"),
              onTap: () => {print("personal")},
            ),
            ListTile(
              title: Text("내 정보 수정"),
              onTap: () => {print("information")},
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
        items: <BottomNavigationBarItem>[
          for (var i = 0; i < _widgetOptions.length; i++)
            BottomNavigationBarItem(
              icon: Image.asset(
                _selectedIndex == i ? _tabIcons[i][1] : _tabIcons[i][0],
                width: 35,
                height: 35,
              ),
              label: _tabLabels[i],
            ),
        ],
        selectedItemColor: Colors.black,
      ),
      body: SafeArea(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
    );
  }
}
