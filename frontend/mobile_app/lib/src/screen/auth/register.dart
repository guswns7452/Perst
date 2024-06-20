import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:perst/src/controller/user_controller.dart';
import 'package:perst/src/screen/auth/intro.dart';
import 'package:perst/src/screen/auth/login.dart';

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

  late String _selectedGender = "man";

  // 회원가입 완료 버튼을 누를 때 동작할 함수
  _submitForm() async {
    final String memberName = _memberNameController.text;
    final String memberPhone = _memberPhoneController.text;
    final String memberPassword = _memberPasswordController.text;
    final String memberBirth = _memberBirthController.text;
    final String memberHeight = _memberHeightController.text;
    final String memberWeight = _memberWeightController.text;

    int memberHeightInt = int.parse(memberHeight);
    int memberWeightInt = int.parse(memberWeight);

    // 회원가입 통신 로직
    bool result = await userController.register(
        memberName,
        memberPhone,
        memberPassword,
        memberBirth,
        _selectedGender,
        memberHeightInt,
        memberWeightInt);

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
                SizedBox(height: 10),
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
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(left: 40, top: 20),
                  child: Text('반갑습니다! 회원가입 정보를 입력해주세요!',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.nanumGothic(
                          textStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ))),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _memberPhoneController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
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
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromRGBO(0, 0, 0, 1),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF000000),
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
                        child: Text(
                          '* 가능한 특수기호 !@#%^&*()?/',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        ),
                      ),
                      // 성별 선택
                      Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Radio<String>(
                                value: 'man',
                                groupValue: _selectedGender,
                                onChanged: (String? value) {
                                  setState(() {
                                    _selectedGender = value!;
                                    _memberGenderController.text = value;
                                  });
                                },
                              ),
                              const Text('남성'),
                              Radio<String>(
                                value: 'woman',
                                groupValue: _selectedGender,
                                onChanged: (String? value) {
                                  setState(() {
                                    _selectedGender = value!;
                                    _memberGenderController.text = value;
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
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      // 생년월일 입력폼
                      TextFormField(
                        controller: _memberBirthController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
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
                        keyboardType: TextInputType.number,
                        controller: _memberHeightController,
                        decoration: const InputDecoration(
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
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      // 체중 입력폼
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: _memberWeightController,
                        decoration: const InputDecoration(
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
                        ),
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
