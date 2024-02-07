import 'package:flutter/material.dart';

class phonenumber_keyboard extends StatefulWidget {
  const phonenumber_keyboard({super.key});

  @override
  State<phonenumber_keyboard> createState() => _phonenumber_keyboardState();
}

class _phonenumber_keyboardState extends State<phonenumber_keyboard> {
  TextEditingController _phonenumbercontroller = TextEditingController();

// 각 버튼을 클릭했을때 번호가 추가되는 함수 정의
  void _addNumber(String number) {
    setState(() {
      _phonenumbercontroller.text += number;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(40, 15, 40, 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // phonenumber 입력 textformfield
          TextFormField(
            controller: _phonenumbercontroller,
            style: TextStyle(fontSize: 30),
            decoration: InputDecoration(
              labelText: '전화번호',
              labelStyle: TextStyle(fontSize: 25),
              icon: Icon(
                Icons.phone,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(height: 40.0),
          // 키패드 정렬
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildNumberButton('1'),
                SizedBox(width: 8),
                _buildNumberButton('2'),
                SizedBox(width: 8),
                _buildNumberButton('3'),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildNumberButton('4'),
                SizedBox(width: 8),
                _buildNumberButton('5'),
                SizedBox(width: 8),
                _buildNumberButton('6'),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildNumberButton('7'),
                SizedBox(width: 8),
                _buildNumberButton('8'),
                SizedBox(width: 8),
                _buildNumberButton('9'),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                OutlinedButton(
                  child: Image.asset(
                    'assets/delete.png',
                    width: 70,
                    height: 70,
                  ),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white,
                    minimumSize: Size.zero,
                    padding: EdgeInsets.fromLTRB(38, 36, 38, 36),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      String currentValue = _phonenumbercontroller.text;
                      if (currentValue.isNotEmpty) {
                        _phonenumbercontroller.text =
                            currentValue.substring(0, currentValue.length - 1);
                      }
                    });
                  },
                ),
                SizedBox(width: 8),
                _buildNumberButton('0'),
                SizedBox(width: 8),
                OutlinedButton(
                  onPressed: () {},
                  child: Text(
                    '입력',
                    style: TextStyle(
                      fontSize: 45,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white,
                    minimumSize: Size.zero,
                    padding: EdgeInsets.fromLTRB(35, 40, 35, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ])
        ],
      ),
    );
  }

// 각 번호의 위젯 스타일을 한번에 정의
  Widget _buildNumberButton(String number) {
    return OutlinedButton(
      onPressed: () {
        _addNumber(number);
      },
      child: Text(
        number,
        style: TextStyle(
          fontSize: 50,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.white,
        minimumSize: Size.zero,
        padding: EdgeInsets.fromLTRB(60, 35, 60, 35),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
    );
  }

// delete 버튼을 눌렀을때 입력된 번호가 지워지는 함수 정의
  @override
  void dispose() {
    _phonenumbercontroller.dispose();
    super.dispose();
  }
}
