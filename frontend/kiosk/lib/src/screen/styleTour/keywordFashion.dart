import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiosk/src/screen/intro.dart';
import 'package:kiosk/src/widget/keyword_fashion_widget.dart';

class KeywordFashion extends StatelessWidget {
  const KeywordFashion({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: Scaffold(
        body: ListView(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(50, 50, 50, 80),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    '* 해당 제품을 클릭하면 자세한 정보를 확인할 수 있습니다.',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 50),
                  SizedBox(
                    height: 1000,
                    child: GridView.builder(
                        shrinkWrap: true,
                        // TODO: itemCount에 해당 키워드에 해당하는 사진 개수 넣기.
                        itemCount: 100,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1 / 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            child: KeywordFashionWidget(),
                            // TODO: 이거를 fileId를 어떻게 넘겨줄지 고민좀... 왜냐면 google_drive_widget는 stl이고, keywordFashionWidget는 stf라..
                          );
                        }),
                  )
                ],
              ),
            ),
          ],
        ),
        bottomSheet: SafeArea(
          child: Container(
            child: Center(
              child: Text(
                'Perst : 당신만을 위한 의류 스타일 추천 서비스',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            color: Color.fromRGBO(217, 217, 217, 1),
            width: double.infinity,
            height: 60,
          ),
        ),
        floatingActionButton: Container(
          margin: EdgeInsets.only(bottom: 70),
          child: FloatingActionButton.extended(
            // TODO: 여기 페이지 이동할때 이전 페이지 기록 없애는 방법 더 찾아보기
            onPressed: () {
              Get.offAll(() => const Intro());
            },
            backgroundColor: Colors.black,
            label: Text(
              '처음으로 돌아가기',
              style: TextStyle(color: Colors.white),
            ),
            icon: Icon(
              Icons.add_to_home_screen,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
