import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiosk/src/controller/user_controller.dart';
import 'package:kiosk/src/screen/auth/test.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final userController = Get.put(UserController());
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

// 로그인 완료 버튼을 누를 때 동작할 함수
  _submitForm() async {
    if (_formkey.currentState!.validate()) {
      final String memberPhoneNumber = _phoneNumberController.text;
      final String memberPassword = _passwordController.text;
      print("login" + memberPhoneNumber + memberPassword);

      // 로그인 통신 로직
      bool result =
          await userController.login(memberPhoneNumber, memberPassword);

      // 로그인 성공시 다음 화면으로 이동처리
      // TODO: 다음 화면 어디로 갈지 생각
      if (result) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Test(styleKeyword: 'gofcore'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('로그인')),
      body: Form(
        key: _formkey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(left: 20),
              child: Text(
                '반갑습니다! 로그인 정보를 입력해주세요!',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
              decoration: BoxDecoration(
                color: Color.fromRGBO(255, 228, 244, 1),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  TextFormField(
                    controller: _phoneNumberController,
                    // obscureText: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      icon: Icon(
                        Icons.phone,
                        color: Color.fromRGBO(255, 81, 185, 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(255, 81, 185, 1),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(255, 81, 185, 1),
                        ),
                      ),
                      labelText: '전화번호',
                      labelStyle: TextStyle(
                        color: Color.fromRGBO(255, 81, 185, 1),
                      ),
                      focusColor: Colors.white,
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '전화번호를 입력하세요.';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      icon: Icon(
                        Icons.lock,
                        color: Color.fromRGBO(255, 81, 185, 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(255, 81, 185, 1),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(255, 81, 185, 1),
                        ),
                      ),
                      labelText: '비밀번호',
                      labelStyle: TextStyle(
                        color: Color.fromRGBO(255, 81, 185, 1),
                      ),
                      focusColor: Colors.white,
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '비밀번호를 입력하세요.';
                      }
                      return null;
                    },
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 40.0),
                    child: ElevatedButton(
                      onPressed: _submitForm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(255, 99, 99, 1),
                      ),
                      child: const Text(
                        '로그인',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
