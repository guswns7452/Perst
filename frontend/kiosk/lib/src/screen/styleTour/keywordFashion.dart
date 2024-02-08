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
          physics: AlwaysScrollableScrollPhysics(),
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(50, 50, 50, 80),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    '* 해당 제품을 클릭하면 매장 위치를 확인할 수 있어요!',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 50),
                  GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 30.0,
                    ),
                    // 자식위젯 100개는 여기서 조정해주면 됨.
                    itemCount: 30,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        child: KeywordFashionWidget(),
                      );
                    },
                  ),
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
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const Intro(),
              ));
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
