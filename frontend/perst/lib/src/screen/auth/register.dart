import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final RegExp emailRegex =
      RegExp(r'^[a-zA-Z0-9+-\_.]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('회원가입')),
      body: Form(
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.fromLTRB(20, 100, 0, 0),
                  child: Text(
                    '반갑습니다! 회원가입 정보를 입력해주세요!',
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
                      // 이메일 또는 아이디
                      TextFormField(
                        // controller: ,
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
                          hintText: 'ex) perst@perst.perst',
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
                      // 비밀번호
                      TextFormField(
                        // controller: ,
                        obscureText: true,
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
                      ),
                      // 비밀번호 안내문구
                      SizedBox(height: 5),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(left: 38),
                        child: Text(
                          '* 가능한 특수기호 !@#%^&*()?/',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 10,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      // 이름
                      TextFormField(
                        // controller: ,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          icon: Icon(
                            Icons.person,
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
                          labelText: '이름',
                          labelStyle: TextStyle(
                            color: Color.fromRGBO(255, 81, 185, 1),
                          ),
                          focusColor: Colors.white,
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'ex) 홍길동',
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      // 닉네임
                      TextFormField(
                        // controller: ,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          icon: Icon(
                            Icons.badge,
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
                          labelText: '닉네임',
                          labelStyle: TextStyle(
                            color: Color.fromRGBO(255, 81, 185, 1),
                          ),
                          focusColor: Colors.white,
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'ex) perst1234',
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      // 전화번호
                      // 필요없으면 제거 예정
                      TextFormField(
                        // controller: ,
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
                          hintText: 'ex) 01000000000',
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      // 생년월일
                      TextFormField(
                        // controller: ,
                        obscureText: true,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          icon: Icon(
                            Icons.celebration,
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
                          labelText: '생년월일',
                          labelStyle: TextStyle(
                            color: Color.fromRGBO(255, 81, 185, 1),
                          ),
                          hintText: 'ex) 000000',
                          focusColor: Colors.white,
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
