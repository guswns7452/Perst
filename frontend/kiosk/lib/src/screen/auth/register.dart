import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
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
                  margin: EdgeInsets.fromLTRB(20, 200, 0, 0),
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
                    color: Color.fromRGBO(234, 234, 234, 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      // 전화번호 입력폼
                      /*{
    "memberName": "전현준",
    "memberPhone": "01058559687",
    "memberPassword": "1234",
    "memberBirth": "2024-02-26",
	  "memberGender": "man/woman",
	  "memberHeight": 180.4,
	  "memberWeight": 62.8
}*/
                      TextFormField(
                        // controller: ,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          icon: Icon(
                            Icons.phone,
                            color: Color.fromRGBO(0, 0, 0, 1),
                          ),
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
                          hintText: 'ex) 01012345678',
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
                      // 비밀번호 입력폼
                      TextFormField(
                        // controller: ,
                        obscureText: true,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          icon: Icon(
                            Icons.lock,
                            color: Color.fromRGBO(0, 0, 0, 1),
                          ),
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
                          // TODO: 올바르지 않은 특수문자 입력시
                          // return 사용할 수 없는 특수기호 입니다.
                          return null;
                        },
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
                            fontSize: 13,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      // 이름 입력폼
                      TextFormField(
                        // controller: ,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          icon: Icon(
                            Icons.person,
                            color: Color.fromRGBO(0, 0, 0, 1),
                          ),
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
                          labelText: '이름',
                          labelStyle: TextStyle(
                            color: Color.fromRGBO(0, 0, 0, 1),
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
                      // 생년월일 입력폼
                      TextFormField(
                        // controller: ,
                        obscureText: true,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          icon: Icon(
                            Icons.celebration,
                            color: Color.fromRGBO(0, 0, 0, 1),
                          ),
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
                          labelText: '생년월일',
                          labelStyle: TextStyle(
                            color: Color.fromRGBO(0, 0, 0, 1),
                          ),
                          hintText: 'ex) 2000-00-00',
                          focusColor: Colors.white,
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      // 키 입력폼
                      TextFormField(
                        // controller: ,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          icon: Icon(
                            Icons.accessibility,
                            color: Color.fromRGBO(0, 0, 0, 1),
                          ),
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
                          labelText: '키',
                          labelStyle: TextStyle(
                            color: Color.fromRGBO(0, 0, 0, 1),
                          ),
                          focusColor: Colors.white,
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'ex) 100',
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      // 체중 입력폼
                      TextFormField(
                        // controller: ,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          icon: Icon(
                            Icons.monitor_weight,
                            color: Color.fromRGBO(0, 0, 0, 1),
                          ),
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
                          labelText: '체중',
                          labelStyle: TextStyle(
                            color: Color.fromRGBO(0, 0, 0, 1),
                          ),
                          focusColor: Colors.white,
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'ex) 10',
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: ElevatedButton(
                          onPressed: () {},
                          // onPressed: _submitForm,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 0, 0, 0),
                          ),
                          child: const Text(
                            '회원가입',
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
          ],
        ),
      ),
    );
  }
}
