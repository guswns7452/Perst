import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:perst/src/screen/auth/login.dart';
import 'package:perst/src/screen/auth/register.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Intro extends StatefulWidget {
  const Intro({super.key});

  @override
  State<Intro> createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  int currentPage = 0;
  PageController _PageController = PageController(
    initialPage: 0,
  );

  List itemList = ["1", "2", "3", "4", "5", "6", "7"];

  @override
  void initState() {
    super.initState();
    itemList.shuffle();

    Timer.periodic(Duration(seconds: 4), (Timer timer) {
      if (currentPage < itemList.length - 1) {
        currentPage++;
      } else {
        currentPage = 0;
      }

      _PageController.animateToPage(
        currentPage,
        duration: Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Perst',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.archivoBlack(
                            textStyle: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w800,
                          color: Color.fromRGBO(255, 191, 25, 1),
                        ))),
                    Text(
                      '당신만을 위한 의류 스타일 추천',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(146, 146, 146, 1),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: 400,
                height: 350,
                child: PageView.builder(
                  pageSnapping: true,
                  controller: _PageController,
                  itemCount: itemList.length,
                  onPageChanged: (value) {},
                  itemBuilder: (context, index) {
                    return Container(
                      child: Image.asset(
                          'assets/style_' + itemList[index] + '.png',
                          width: 300,
                          height: 300,
                          fit: BoxFit.cover),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: SmoothPageIndicator(
                    controller: _PageController,
                    count: 7,
                    effect: const ScrollingDotsEffect(
                      activeDotColor: Colors.indigoAccent,
                      activeStrokeWidth: 10,
                      activeDotScale: 2,
                      maxVisibleDots: 7,
                      radius: 8,
                      spacing: 10,
                      dotHeight: 5,
                      dotWidth: 5,
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                  width: double.infinity,
                  child: Text("지금 시작하고, 당신의 스타일을 찾아보세요!",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.notoSansKr(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.w900, fontSize: 17),
                      ))),
              SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                height: 70,
                child: ElevatedButton(
                  onPressed: () {
                    // 로그인을 클릭하면 로그인 창으로 이동
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Login(),
                    ));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(255, 81, 185, 0.78),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    '로그인',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              Container(
                width: double.infinity,
                height: 70,
                child: ElevatedButton(
                  onPressed: () {
                    // 회원가입을 클릭하면 회원가입 창으로 이동
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const Register(),
                    ));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    '회원가입',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 158, 157, 157),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      '아이디를 까먹으셨나요?',
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        '아이디 찾기',
                        style: TextStyle(
                          color: Color.fromRGBO(236, 72, 153, 1),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
