import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:perst/src/screen/camera/cameraGuide.dart';

class CameraIntro extends StatelessWidget {
  const CameraIntro({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView(padding: EdgeInsets.all(5), children: <Widget>[
              Image.asset('assets/banner.png'),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text("사진 첨부 가이드",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 20),
                child: Text("❌ 안 좋은 예시",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 35, top: 5),
                child: Text(" ・ 인물이 잘 안보이는 사진은 피해주세요!",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 20.0, bottom: 10.0, right: 20, top: 10),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset('assets/cameraIntro_1.png')),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 10),
                child: Text("✅ 좋은 예시",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 35, top: 5),
                child: Text(" ・ 사람이 꽉 찬 사진을 첨부하면 더 좋은 결과를 얻을 수 있어요!",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 20.0, bottom: 30.0, right: 020, top: 10),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset('assets/cameraIntro_2.png')),
              ),
              Padding(
                padding: EdgeInsets.only(),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text("패션 분석 결과",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w800,
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 10),
                child: Text("1️⃣ 색 조합 출력",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 35, top: 5),
                child: Text(" ・ 내 코디의 색상을 추출해줍니다.",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 20.0, bottom: 30.0, right: 020, top: 10),
                child: Container(
                  width: double.infinity,
                  height: 290,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(238, 238, 238, 1),
                      borderRadius: BorderRadius.circular(10)),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        'assets/cameraIntro_4.png',
                        width: 100,
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 10),
                child: Text("2️⃣ 스타일 키워드 분석",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 35, top: 5),
                child: Text(" ・ 내 스타일을 분석하여 키워드로 정리해줍니다.",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 20.0, bottom: 30.0, right: 020, top: 10),
                child: Container(
                  width: double.infinity,
                  height: 290,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(238, 238, 238, 1),
                      borderRadius: BorderRadius.circular(10)),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        'assets/cameraIntro_3.png',
                        width: 100,
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 10),
                child: Text("3️⃣ 패션 키워드 별 코디 제공",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 35, top: 5),
                child: Text(
                    " ・ 내 스타일에 맞는 코디를 추천해줍니다.\n     아래의 버튼을 눌러 더 많은 코디를 볼 수 있습니다.",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 20.0, bottom: 30.0, right: 020, top: 10),
                child: Container(
                  width: double.infinity,
                  height: 290,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(238, 238, 238, 1),
                      borderRadius: BorderRadius.circular(10)),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        'assets/cameraIntro_5.png',
                        width: 100,
                      )),
                ),
              ),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 20.0, top: 10, bottom: 15, right: 20),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CameraGuide()));
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  minimumSize: Size(500, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12))),
              child: const Text(
                '스타일 분석하기',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
