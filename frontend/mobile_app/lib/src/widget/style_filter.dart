import 'package:flutter/material.dart';

class StyleFilter extends StatefulWidget {
  final String seletedGender;
  final String currentStyle;
  final List<Color> colorList;
  final String personalColor;

  StyleFilter({
    required this.colorList,
    required this.currentStyle,
    required this.seletedGender,
    Key? key,
    required this.personalColor,
  }) : super(key: key);

  @override
  State<StyleFilter> createState() => _StyleFilterState();
}

class _StyleFilterState extends State<StyleFilter> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
          decoration: BoxDecoration(
            border:
                Border.all(width: 1, color: Color.fromRGBO(133, 133, 133, 1)),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            widget.seletedGender == 'man' ? '남성' : '여성',
            style: TextStyle(
              fontSize: 15,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(width: 5),
        Container(
          padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
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
              fontSize: 15,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(width: 5),
        widget.personalColor == ''
            ? Container()
            : Container(
                padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
                decoration: BoxDecoration(
                  border: Border.all(
                      width: 1, color: Color.fromRGBO(133, 133, 133, 1)),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  widget.personalColor,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
        SizedBox(width: 5),
        Wrap(
          spacing: 5,
          children: List.generate(
            widget.colorList.length,
            (index) => Container(
              decoration: BoxDecoration(
                  border: Border.all(
                      width: 1, color: Color.fromRGBO(133, 133, 133, 1)),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.transparent),
              padding: EdgeInsets.fromLTRB(8, 4, 3, 4),
              child: Container(
                width: 20,
                height: 20,
                margin: EdgeInsets.only(right: 5),
                decoration: BoxDecoration(
                  color: widget.colorList[index],
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(width: 0.3, color: Colors.black),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
