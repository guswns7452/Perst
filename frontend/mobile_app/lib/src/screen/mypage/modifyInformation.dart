import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:perst/src/connect/mypage_connect.dart';

final GetStorage _storage = GetStorage();

class ModifyInformation extends StatefulWidget {
  const ModifyInformation({super.key});

  @override
  State<ModifyInformation> createState() => _ModifyInformationState();
}

class _ModifyInformationState extends State<ModifyInformation> {
  final mypageConnect = Get.put(MypageConnect());
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _birthController = TextEditingController();
  TextEditingController _weightController = TextEditingController();
  TextEditingController _heightController = TextEditingController();
  String gender = "";

  @override
  void initState() {
    super.initState();
    _patchData();
  }

  Future<void> _patchData() async {
    Map<String, dynamic> results = await mypageConnect.showInformation();

    print(results);

    setState(() {
      _phoneNumberController =
          TextEditingController(text: results['memberPhone']);
      _passwordController =
          TextEditingController(text: results['memberPassword']);
      _nameController = TextEditingController(text: results['memberName']);
      String birth = results['memberBirth'].split('T')[0];
      _birthController = TextEditingController(text: birth);
      _heightController =
          TextEditingController(text: results['memberHeight'].toString());
      _weightController =
          TextEditingController(text: results['memberWeight'].toString());
      gender = results['memberGender'];
    });
  }

  void _submitForm() async {
    final String memberPhoneNumber = _phoneNumberController.text;
    final String memberPassword = _passwordController.text;
    final String memberName = _nameController.text;
    final String memberBirth = _birthController.text;
    final int memberHeight = int.parse(_heightController.text);
    final int memberWeight = int.parse(_weightController.text);

    Future patchResults = mypageConnect.patchInformation(
        memberName,
        memberPhoneNumber,
        memberPassword,
        memberBirth,
        gender,
        memberHeight,
        memberWeight);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          width: double.infinity,
          margin: EdgeInsets.only(right: 60),
          child: const Text(
            '프로필',
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body: ListView(children: [
        Form(
          key: _formkey,
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Container(
                width: double.infinity,
                child: Text('Perst',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                      color: Color.fromRGBO(255, 191, 25, 1),
                    )),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                decoration: BoxDecoration(
                  // color: Color.fromRGBO(234, 234, 234, 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(children: [
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(bottom: 5),
                        child: Row(children: [
                          Text('이름',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 13,
                                color: const Color.fromARGB(255, 194, 194, 194),
                              )),
                          Text('*',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w800,
                                color: Color.fromARGB(255, 255, 168, 168),
                              )),
                        ]),
                      ),
                      TextFormField(
                        controller: _nameController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 0, 0, 0),
                              width: 0.8,
                            ),
                            borderRadius: BorderRadius.circular(1),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromRGBO(66, 66, 66, 1),
                              width: 0.6,
                            ),
                            borderRadius: BorderRadius.circular(1),
                          ),
                          focusColor: Colors.white,
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '이름을 입력하세요.';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(bottom: 5),
                        child: Row(children: [
                          Text('비밀번호',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 13,
                                color: const Color.fromARGB(255, 194, 194, 194),
                              )),
                          Text('*',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w800,
                                color: Color.fromARGB(255, 255, 168, 168),
                              )),
                        ]),
                      ),
                      TextFormField(
                        obscureText: true,
                        controller: _passwordController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 0, 0, 0),
                              width: 0.8,
                            ),
                            borderRadius: BorderRadius.circular(1),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromRGBO(66, 66, 66, 1),
                              width: 0.6,
                            ),
                            borderRadius: BorderRadius.circular(1),
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
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(bottom: 5),
                        child: Row(children: [
                          Text('전화번호',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 13,
                                color: const Color.fromARGB(255, 194, 194, 194),
                              )),
                          Text('*',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w800,
                                color: Color.fromARGB(255, 255, 168, 168),
                              )),
                        ]),
                      ),
                      TextFormField(
                        controller: _phoneNumberController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 0, 0, 0),
                              width: 0.8,
                            ),
                            borderRadius: BorderRadius.circular(1),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromRGBO(66, 66, 66, 1),
                              width: 0.6,
                            ),
                            borderRadius: BorderRadius.circular(1),
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
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(bottom: 5),
                        child: Row(children: [
                          Text('생년월일',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 13,
                                color: const Color.fromARGB(255, 194, 194, 194),
                              )),
                          Text('*',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w800,
                                color: Color.fromARGB(255, 255, 168, 168),
                              )),
                        ]),
                      ),
                      TextFormField(
                        controller: _birthController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 0, 0, 0),
                              width: 0.8,
                            ),
                            borderRadius: BorderRadius.circular(1),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromRGBO(66, 66, 66, 1),
                              width: 0.6,
                            ),
                            borderRadius: BorderRadius.circular(1),
                          ),
                          focusColor: Colors.white,
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '생년월일을 입력하세요.';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(bottom: 5),
                        child: Row(children: [
                          Text('키',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 13,
                                color: const Color.fromARGB(255, 194, 194, 194),
                              )),
                          Text('*',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w800,
                                color: Color.fromARGB(255, 255, 168, 168),
                              )),
                        ]),
                      ),
                      TextFormField(
                        controller: _heightController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 0, 0, 0),
                              width: 0.8,
                            ),
                            borderRadius: BorderRadius.circular(1),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromRGBO(66, 66, 66, 1),
                              width: 0.6,
                            ),
                            borderRadius: BorderRadius.circular(1),
                          ),
                          focusColor: Colors.white,
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '키를 입력하세요.';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(bottom: 5),
                        child: Row(children: [
                          Text('체중',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 13,
                                color: const Color.fromARGB(255, 194, 194, 194),
                              )),
                          Text('*',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w800,
                                color: Color.fromARGB(255, 255, 168, 168),
                              )),
                        ]),
                      ),
                      TextFormField(
                        controller: _weightController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 0, 0, 0),
                              width: 0.8,
                            ),
                            borderRadius: BorderRadius.circular(1),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromRGBO(66, 66, 66, 1),
                              width: 0.6,
                            ),
                            borderRadius: BorderRadius.circular(1),
                          ),
                          focusColor: Colors.white,
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '체중을 입력하세요.';
                          }
                          return null;
                        },
                      )
                    ]),
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
      ]),
    );
  }
}
