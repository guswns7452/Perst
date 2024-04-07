import 'package:flutter/material.dart';

class StyleFilter extends StatefulWidget {
  final String seletedGender;
  final String currentStyle;
  final Color currentColor;

  StyleFilter(
      {required this.currentColor,
      required this.currentStyle,
      required this.seletedGender,
      Key? key})
      : super(key: key);

  @override
  State<StyleFilter> createState() => _StyleFilterState();
}

class _StyleFilterState extends State<StyleFilter> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(10, 4, 10, 4),
          decoration: BoxDecoration(
              border:
                  Border.all(width: 1, color: Color.fromRGBO(133, 133, 133, 1)),
              borderRadius: BorderRadius.circular(10)),
          child: Text(
            widget.seletedGender == 'man' ? '남성' : '여성',
            style: TextStyle(
                fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(width: 5),
        Container(
          padding: EdgeInsets.fromLTRB(10, 4, 10, 4),
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Color.fromRGBO(133, 133, 133, 1),
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            widget.currentStyle,
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(width: 5),
        Container(
          padding: EdgeInsets.fromLTRB(10, 4, 10, 4),
          decoration: BoxDecoration(
              border:
                  Border.all(width: 1, color: Color.fromRGBO(133, 133, 133, 1)),
              borderRadius: BorderRadius.circular(10)),
          child: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: widget.currentColor,
              borderRadius: BorderRadius.circular(50),
              border: Border.all(width: 0.3, color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }
}
