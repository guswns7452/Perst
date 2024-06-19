import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:perst/src/connect/mypage_connect.dart';
import 'package:perst/src/model/mypage_model.dart';
import 'package:perst/src/screen/style/keywardFashion.dart';
import 'package:perst/src/widget/google_drive_image.dart';
import 'package:perst/src/widget/style_color_view.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class StyleHistoryDetail extends StatefulWidget {
  final MystyleModel fashion;

  StyleHistoryDetail({required this.fashion, Key? key}) : super(key: key);

  @override
  State<StyleHistoryDetail> createState() => _StyleHistoryDetailState();
}

class _StyleHistoryDetailState extends State<StyleHistoryDetail> {
  final mypageConnection = Get.put((MypageConnect()));
  late Map<String, dynamic> result = {};
  bool isLoading = true;
  final PageController _pageController = PageController();
  int _currentPage = 0;
  String kRStyleName = '';
  String? styleName = '';
  int styleNumber = 0;

  @override
  void initState() {
    super.initState();
    _dataLoading();
    _fetchData();
  }

  Future _fetchData() async {
    setState(() {
      isLoading = true;
    });

    result = await mypageConnection.styleHistoryDetail(styleNumber);

    setState(() {
      isLoading = false;
    });
  }

  _dataLoading() {
    MystyleModel fashionData = widget.fashion;

    styleName = fashionData.styleName;
    styleNumber = fashionData.styleNumber!;

    if (styleName == "casual") kRStyleName = "캐주얼";
    if (styleName == "street") kRStyleName = "스트릿";
    if (styleName == "dandy") kRStyleName = "댄디";
    if (styleName == "Amekaji") kRStyleName = "아메카지";
    if (styleName == "gofcore") kRStyleName = "고프코어";
    if (styleName == "chic") kRStyleName = "시크";
    if (styleName == "businessCasual") kRStyleName = "비즈니스캐주얼";
    if (styleName == "Sporty") kRStyleName = "스포티";
    if (styleName == "minimal") kRStyleName = "미니멀";
    if (styleName == "romantic") kRStyleName = "로맨틱";
    if (styleName == "girlish") kRStyleName = "걸리시";
    if (styleName == "retro") kRStyleName = "레트로";
  }

  @override
  Widget build(BuildContext context) {
    String styleName = result['styleName'] ?? '';
    String styleImageId = result['styleFileID'] ?? '';

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
            body: ListView(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ' Perst',
                            style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                  color: Color.fromRGBO(255, 191, 25, 1),
                                  fontSize: 45,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Center(
                            child: Container(
                                width: double.infinity,
                                height: 600,
                                child: google_drive_image(id: styleImageId)),
                          ),
                          SizedBox(height: 10),
                          Container(
                            margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '분석결과',
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w800),
                                ),
                                Text(
                                  ': 스타일 키워드',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 5),
                                  padding: EdgeInsets.fromLTRB(10, 3, 10, 3),
                                  child: Text(
                                    kRStyleName,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(62, 62, 62, 1),
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                ),
                                SizedBox(height: 15),
                                Text(
                                  ': 색 조합',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                                StyleColorView(result: result),
                                SizedBox(height: 20),
                              ],
                            ),
                          ),
                          SizedBox(height: 15)
                        ],
                      ),
                    ),
                    Container(
                      color: Color.fromARGB(255, 229, 229, 229),
                      height: 7,
                      width: double.infinity,
                      margin: EdgeInsets.only(bottom: 30),
                    ),
                    Text(
                      '   👚스타일 코디팁',
                      style: GoogleFonts.poorStory(
                        textStyle: TextStyle(
                            fontSize: 23, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                        '    지금 ' +
                            kRStyleName +
                            ' 스타일 코디법을 확인해보세요!\n    아래 사진을 넘겨 확인 할 수 있습니다',
                        style: GoogleFonts.poorStory(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 18),
                        )),
                    Center(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 30, bottom: 20),
                            height: 410,
                            width: 410,
                            child: PageView.builder(
                              controller: _pageController,
                              itemCount: result['styleCommentFileID'].length,
                              onPageChanged: (index) {
                                _currentPage = index;
                              },
                              itemBuilder: (context, index) {
                                return google_drive_image(
                                    id: result['styleCommentFileID'][index]);
                              },
                            ),
                          ),
                          Positioned(
                            left: 0,
                            child: IconButton(
                              icon: Text(
                                '<',
                                style: TextStyle(fontSize: 15),
                              ),
                              onPressed: () {
                                if (_currentPage > 0) {
                                  _pageController.previousPage(
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                }
                              },
                            ),
                          ),
                          Positioned(
                            right: 0,
                            child: IconButton(
                              icon: Text(
                                '>',
                                style: TextStyle(fontSize: 15),
                              ),
                              onPressed: () {
                                if (_currentPage <
                                    result['styleCommentFileID'].length - 1) {
                                  _pageController.nextPage(
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: SmoothPageIndicator(
                        controller: _pageController,
                        count: result['styleCommentFileID'].length,
                        effect: WormEffect(
                          dotWidth: 5,
                          dotHeight: 5,
                          activeDotColor: Color.fromARGB(255, 192, 192, 192),
                          dotColor: Color.fromARGB(255, 237, 237, 237),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => KeywordFashion(
                                styleKeyword: styleName,
                                kRStyleName: '캐주얼',
                                personalColor: '',
                              ),
                            ),
                          );
                        },
                        child: Text(
                          '> 내 스타일에 따른 추천 의류 보러가기',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.w600,
                              color: const Color.fromARGB(255, 0, 0, 0)),
                        ),
                        style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7),
                            ),
                            backgroundColor: Colors.transparent),
                      ),
                    ),
                    SizedBox(height: 15)
                  ],
                ),
              ],
            ),
          );
  }
}
