import 'package:flutter/material.dart';
import 'package:perst/src/screen/style/personalColorGuide.dart';

class PersonalColor extends StatelessWidget {
  const PersonalColor({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '퍼스널 컬러 자가진단',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 15),
            Image.asset(
              'assets/colorCircle.png',
              width: 100,
              height: 100,
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.only(top: 20, bottom: 20),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(249, 249, 249, 1),
                  borderRadius: BorderRadius.circular(15)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 15),
                    width: double.infinity,
                    child: Text('주의사항',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center),
                  ),
                  Row(
                    children: [
                      Text('   휴대폰 설정에서 ', style: TextStyle(fontSize: 18)),
                      Text('블루라이트 필터',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)),
                      Text('를 꺼주세요.', style: TextStyle(fontSize: 18))
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text('   자연광',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)),
                      Text('이나 ', style: TextStyle(fontSize: 18)),
                      Text('푸르지 않은 흰색 조명',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)),
                      Text(
                        '이 좋습니다.',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text('   사진은 수집되지 않습니다.', style: TextStyle(fontSize: 18)),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(left: 20, right: 20),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const PersonalColorGuide(),
                  ));
                },
                child: Text(
                  '진단 시작하러가기',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
            )
          ],
        ),
      ),
    );
  }
}
