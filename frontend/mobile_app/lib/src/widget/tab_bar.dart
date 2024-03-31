import 'package:flutter/material.dart';
import 'package:perst/src/screen/style/myStyle.dart';
import 'package:perst/src/screen/style/personalColor.dart';
import 'package:perst/src/screen/style/styleAnalysis.dart';
import 'package:perst/src/screen/style/styleTour.dart';

class Tabbar extends StatefulWidget {
  const Tabbar({super.key});

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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
