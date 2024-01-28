import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final RegExp emailRegex =
      RegExp(r'^[a-zA-Z0-9+-\_.]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('로그인')),
      body: Form(
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
                    // controller: ,
                    obscureText: true,
                    // 아이디로 로그인하면 필요 X
                    // keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      icon: Icon(
                        Icons.email,
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
                      labelText: '이메일',
                      labelStyle: TextStyle(
                        color: Color.fromRGBO(255, 81, 185, 1),
                      ),
                      focusColor: Colors.white,
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '이메일을 입력하세요.';
                      }
                      if (!emailRegex.hasMatch(value)) {
                        return '이메일 형식이 올바르지 않습니다.';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    // controller: ,
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
                        return '이메일을 입력하세요.';
                      }
                      if (!emailRegex.hasMatch(value)) {
                        return '이메일 형식이 올바르지 않습니다.';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
