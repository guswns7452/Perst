import 'package:flutter/material.dart';
import 'package:perst/src/screen/auth/register.dart';
import 'package:perst/src/widget/tab_bar.dart';

class Intro extends StatelessWidget {
  const Intro({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Perst',
                      style: TextStyle(
                        fontSize: 45,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(255, 191, 25, 1),
                      ),
                    ),
                    Text(
                      ':당신만을 위한 의류 스타일 추천',
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
                height: 70,
              ),
              // 어플에서 사용할 이미지로 대체 예정
              SizedBox(
                child: Center(
                  child: Image.asset(
                    'assets/mypageOutlined.png',
                    width: double.infinity,
                    height: 400,
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: 70,
                child: ElevatedButton(
                  onPressed: () {
                    // 로그인을 클릭하면 로그인 창으로 이동
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const Tabbar(),
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
              const SizedBox(height: 20),
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
