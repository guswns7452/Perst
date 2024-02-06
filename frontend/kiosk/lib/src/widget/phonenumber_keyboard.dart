import 'package:flutter/material.dart';

class phonenumber_keyboard extends StatefulWidget {
  const phonenumber_keyboard({super.key});

  @override
  State<phonenumber_keyboard> createState() => _phonenumber_keyboardState();
}

class _phonenumber_keyboardState extends State<phonenumber_keyboard> {
  TextEditingController _textEditingController = TextEditingController();

  void _addNumber(String number) {
    setState(() {
      _textEditingController.text += number;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(40, 15, 40, 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // Container(
          //   margin: EdgeInsets.fromLTRB(40, 15, 40, 10),
          //   child: TextFormField(
          //     // controller: ,
          //     decoration: const InputDecoration(
          //       border: OutlineInputBorder(),
          //       icon: Icon(
          //         Icons.phone,
          //         color: Colors.black,
          //       ),
          //       focusedBorder: OutlineInputBorder(
          //         borderSide: BorderSide(
          //           color: Colors.black,
          //         ),
          //       ),
          //       enabledBorder: OutlineInputBorder(
          //         borderSide: BorderSide(
          //           color: Colors.black,
          //         ),
          //       ),
          //       labelText: '전화번호',
          //       labelStyle: TextStyle(
          //         color: Colors.black,
          //       ),
          //       focusColor: Colors.white,
          //       filled: true,
          //       fillColor: Colors.white,
          //       hintText: 'ex) 01000000000',
          //     ),
          //   ),
          // ),
          TextFormField(
            controller: _textEditingController,
            decoration: InputDecoration(
              labelText: '전화번호',
              labelStyle: TextStyle(fontSize: 22),
              icon: Icon(
                Icons.phone,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(height: 40.0),
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
                    padding: EdgeInsets.fromLTRB(35, 35, 35, 35),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      String currentValue = _textEditingController.text;
                      if (currentValue.isNotEmpty) {
                        _textEditingController.text =
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

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }
}
