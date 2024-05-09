import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:perst/src/screen/camera/cameraIntro.dart';
import 'package:perst/src/screen/mypage/modifyInformation.dart';
import 'package:perst/src/screen/mypage/personalColorHistory.dart';
import 'package:perst/src/screen/mypage/styleHistory.dart';
import 'package:perst/src/screen/personalColor/personalColor.dart';
import 'package:perst/src/screen/style/myStyle.dart';
import 'package:perst/src/screen/style/styleTour.dart';

final GetStorage _storage = GetStorage();

class Tabbar extends StatefulWidget {
  const Tabbar({Key? key}) : super(key: key);

  @override
  State<Tabbar> createState() => _TabbarState();
}

class _TabbarState extends State<Tabbar> {
  int _selectedIndex = 0;
  bool isLoading = true;

  late String name = '';
  late String gender = '';

  @override
  void initState() {
    super.initState();

    if (name == null) {
      setState(() {
        isLoading = true;
      });
      name = _storage.read("name");
      gender = _storage.read("gender");
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  final List<Widget> _widgetOptions = <Widget>[
    StyleTour(),
    CameraIntro(),
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
    return isLoading
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
            key: _scaffoldKey,
            appBar: AppBar(
              leading: Container(
                decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(width: 1.0))),
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
                      name,
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    accountEmail: Text(
                      gender == "woman" ? "Woman" : "Man",
                      style:
                          TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                    ),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 124, 124, 124),
                    ),
                  ),
                  ListTile(
                      leading: Icon(
                        Icons.favorite,
                        color: const Color.fromARGB(255, 0, 0, 0),
                      ),
                      title: Text("스타일 조회 이력"),
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => StyleHistory(),
                          ))),
                  ListTile(
                      leading: Icon(
                        Icons.colorize,
                        color: const Color.fromARGB(255, 0, 0, 0),
                      ),
                      title: Text("퍼스널 컬러 진단결과"),
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => PersonalColorHistory(),
                          ))),
                  ListTile(
                      leading: Icon(
                        Icons.manage_accounts,
                        color: const Color.fromARGB(255, 0, 0, 0),
                      ),
                      title: Text("내 정보 수정"),
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ModifyInformation(),
                          ))),
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
