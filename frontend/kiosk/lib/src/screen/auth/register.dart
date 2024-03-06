import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiosk/src/controller/user_controller.dart';
import 'package:kiosk/src/screen/auth/login.dart';
import 'package:kiosk/src/screen/intro.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final userController = Get.put(UserController());
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _memberNameController = TextEditingController();
  final TextEditingController _memberPhoneController = TextEditingController();
  final TextEditingController _memberPasswordController =
      TextEditingController();
  final TextEditingController _memberBirthController = TextEditingController();
  final TextEditingController _memberGenderController = TextEditingController();
  final TextEditingController _memberHeightController = TextEditingController();
  final TextEditingController _memberWeightController = TextEditingController();

  String? _selectedGender;

  // 회원가입 완료 버튼을 누를 때 동작할 함수
  _submitForm() async {
    final String memberName = _memberNameController.text;
    final String memberPhone = _memberPhoneController.text;
    final String memberPassword = _memberPasswordController.text;
    final String memberBirth = _memberBirthController.text;
    final String memberHeight = _memberHeightController.text;
    final String memberWeight = _memberWeightController.text;

    int memberHeightInt = int.parse(memberHeight);
    int memberWightInt = int.parse(memberWeight);

    // 회원가입 통신 로직
    print(
        "------------------------------------------------------------------------------------------------------------" +
            memberName +
            memberPhone +
            memberPassword +
            memberBirth);
    print(memberHeightInt + memberWightInt);
    // 데이터 한개씩 넣어서 요청해보고 요청이 성공적으로 된다면 고것이 문제겠지.
    bool result = await userController.register(
        "이다현", "01034886692", "1234", "2002-07-31", "woman", 168, 20);

    // 회원가입 성공시 다음 화면으로 이동처리
    if (result) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Intro(),
        ),
      );
    }
  }

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
                      TextFormField(
                        controller: _memberPhoneController,
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
                        controller: _memberPasswordController,
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
                      // 성별 선택
                      Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              SizedBox(width: 25),
                              Radio<String>(
                                value: 'man',
                                groupValue: _selectedGender,
                                onChanged: (String? value) {
                                  setState(() {
                                    _selectedGender = value;
                                    _memberGenderController.text = value ?? '';
                                  });
                                },
                              ),
                              const Text('남성'),
                              Radio<String>(
                                value: 'woman',
                                groupValue: _selectedGender,
                                onChanged: (String? value) {
                                  setState(() {
                                    _selectedGender = value;
                                    _memberGenderController.text = value ?? '';
                                  });
                                },
                              ),
                              const Text('여성'),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      // 이름 입력폼
                      TextFormField(
                        controller: _memberNameController,
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
                        controller: _memberBirthController,
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
                        controller: _memberHeightController,
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
                        controller: _memberWeightController,
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
                          onPressed: _submitForm,
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
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Login()));
                        },
                        child: Text(
                          "이미 가입한 계정이 있으신가요?",
                          style: TextStyle(
                            color: Color.fromARGB(255, 20, 5, 151),
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
