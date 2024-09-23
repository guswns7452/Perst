import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:perst/src/connect/mypage_connect.dart';
import 'package:perst/src/model/mypage_model.dart';
import 'package:perst/src/screen/personalColor/personalColor.dart';
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
  String feedback = '';
  String feedback2 = '';

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future _fetchData() async {
    setState(() {
      isLoading = true;
    });

    MystyleModel fashionData = widget.fashion;
    styleNumber = fashionData.styleNumber!;

    result = await mypageConnection.styleHistoryDetail(styleNumber);
    String styleNameData = result['styleName'];

    setState(() {
      isLoading = false;

      if (styleNameData == "casual") kRStyleName = "캐주얼";
      if (styleNameData == "street") kRStyleName = "스트릿";
      if (styleNameData == "dandy") kRStyleName = "댄디";
      if (styleNameData == "amekaji") kRStyleName = "아메카지";
      if (styleNameData == "gofcore") kRStyleName = "고프코어";
      if (styleNameData == "chic") kRStyleName = "시크";
      if (styleNameData == "businessCasual") kRStyleName = "비즈니스캐주얼";
      if (styleNameData == "sporty") kRStyleName = "스포티";
      if (styleNameData == "minimal") kRStyleName = "미니멀";
      if (styleNameData == "romantic") kRStyleName = "로맨틱";
      if (styleNameData == "girlish") kRStyleName = "걸리시";
      if (styleNameData == "retro") kRStyleName = "레트로";
      if (styleNameData == "golf") kRStyleName = "골프";

      if (result['personalColorTip']['myPersonalColor'] ==
          result['personalColorTip']['analyzedPersonalColor']) {
        feedback =
            ' 당신의 퍼스널 컬러는 ${result['personalColorTip']['myPersonalColor']}입니다. 퍼스널 컬러에 맞는 의상을 잘 입었어요! 앞으로도 비슷한 계열의 색상을 입어보세요.';
      } else if (result['personalColorTip']['myPersonalColor'] !=
          result['personalColorTip']['analyzedPersonalColor']) {
        if (result['personalColorTip']['myPersonalColor'] == '') {
          feedback =
              '아직 퍼스널 컬러를 진단하지 않으셨네요! 퍼스널 컬러를 진단하면 나에게 맞는 의류를 찾을 수 있어요. 지금 퍼스널 컬러를 진단하고 나에게 맞는 의류를 찾아보세요! \n그래도 지금 입은 의상은 겨울 딥에 어울리므로, 겨울 딥에 관련한 내용을 제공할게요!';
        } else {
          feedback =
              '당신의 퍼스널 컬러는 ${result['personalColorTip']['myPersonalColor']}입니다. 하지만 현재 \n입은 색상은 ${result['personalColorTip']['analyzedPersonalColor']}에 가까워요. ${result['personalColorTip']['myPersonalColor']}에 맞는 의상을 입는다면 더욱 얼굴 톤이 좋아질 거에요! \n아래 ${result['personalColorTip']['myPersonalColor']}에 관련한 설명을 읽어보세요!';
        }
      }

      if (result['personalColorTip']['myPersonalColor'] ==
          result['personalColorTip']['analyzedPersonalColor']) {
        feedback2 = '👍 퍼스널 컬러에 맞게 잘 입었어요!';
      } else if (result['personalColorTip']['myPersonalColor'] !=
          result['personalColorTip']['analyzedPersonalColor']) {
        if (result['personalColorTip']['myPersonalColor'] == '') {
          feedback2 = '🥺 퍼스널 컬러를 진단하면 더 좋은 결과를 얻을 수 있어요!';
        } else {
          feedback2 = '😢 퍼스널 컬러에 맞지 않는 의류에요!';
        }
      }
    });
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
                                kRStyleName: kRStyleName,
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
                    SizedBox(height: 15),
                    Container(
                      color: Color.fromARGB(255, 229, 229, 229),
                      height: 7,
                      width: double.infinity,
                      margin: EdgeInsets.only(bottom: 30, top: 30),
                    ),
                    Text(
                      '   🌈 퍼스널 컬러 피드백',
                      style: GoogleFonts.poorStory(
                        textStyle: TextStyle(
                            fontSize: 23, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(children: [
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        feedback2,
                        style: GoogleFonts.poorStory(
                          textStyle: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ]),
                    SizedBox(height: 5),
                    Row(children: [
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        width: 375,
                        child: Text(
                          feedback,
                          style: GoogleFonts.poorStory(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 18),
                          ),
                        ),
                      ),
                    ]),
                    Container(
                      margin: EdgeInsets.only(top: 30, bottom: 30),
                      height: 410,
                      width: 410,
                      child: google_drive_image(
                          id: result['personalColorTip']['fileID']),
                    ),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            result['personalColorTip']['myPersonalColor'] ==
                                    null
                                ? MaterialPageRoute(
                                    builder: (context) => PersonalColor(),
                                  )
                                : MaterialPageRoute(
                                    builder: (context) => KeywordFashion(
                                        styleKeyword: styleName,
                                        kRStyleName: kRStyleName,
                                        personalColor:
                                            result['personalColorTip']
                                                ['myPersonalColor']),
                                  ),
                          );
                        },
                        child: result['personalColorTip']['myPersonalColor'] ==
                                null
                            ? Text(
                                '퍼스널 컬러 진단하러 가기',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromARGB(255, 255, 255, 255)),
                              )
                            : Text(
                                '➤' +
                                    result['personalColorTip']
                                        ['myPersonalColor'] +
                                    '에 어울리는 스타일 둘러보기',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromARGB(255, 255, 255, 255)),
                              ),
                        style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7),
                            ),
                            backgroundColor: Colors.black),
                      ),
                    ),
                    SizedBox(height: 30)
                  ],
                ),
              ],
            ),
          );
  }
}
