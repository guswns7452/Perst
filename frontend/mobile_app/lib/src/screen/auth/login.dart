import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get_storage/get_storage.dart';
import 'package:perst/src/controller/user_controller.dart';
import 'package:perst/src/widget/tab_bar.dart';

final GetStorage _storage = GetStorage();

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
      String token = _storage.read("access_token");
      Future.delayed(Duration(milliseconds: 1000), () async {
        // 로그인 통신 로직
        bool result =
            await userController.login(memberPhoneNumber, memberPassword);
        return result;
      }).then((value) {
        if (value) {
          // 로그인 성공 시 Tabbar 페이지로 이동
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Tabbar(),
            ),
          );
        } else {}
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('로그인')),
      body: Form(
        key: _formkey,
        child: ListView(
          children: [
            SizedBox(
              height: 70,
            ),
            Container(
              width: double.infinity,
              child: Text('Perst',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.archivoBlack(
                      textStyle: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                    color: Color.fromRGBO(255, 191, 25, 1),
                  ))),
            ),
            SizedBox(
              height: 70,
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(left: 30),
              child: Text('환영해요! 로그인 해주세요!',
                  textAlign: TextAlign.left,
                  style: GoogleFonts.nanumGothic(
                      textStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ))),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
              decoration: BoxDecoration(
                // color: Color.fromRGBO(234, 234, 234, 1),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  TextFormField(
                    controller: _phoneNumberController,
                    keyboardType: TextInputType.number,
                    // obscureText: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(0, 0, 0, 1),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(0, 0, 0, 1),
                        ),
                      ),
                      labelText: '전화번호',
                      labelStyle: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1),
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
                    obscureText: true,
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(0, 0, 0, 1),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(0, 0, 0, 1),
                        ),
                      ),
                      labelText: '비밀번호',
                      labelStyle: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1),
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
                    margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    width: 500,
                    child: ElevatedButton(
                      onPressed: _submitForm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
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
