import 'package:flutter/material.dart';
import 'package:perst/src/widget/google_drive_image.dart';
import 'package:url_launcher/url_launcher.dart';

class FashionDetail extends StatefulWidget {
  final fashion;
  final bool keywardChecked;
  final bool personalColorChecked;

  const FashionDetail(
      {required this.fashion,
      Key? key,
      required this.personalColorChecked,
      required this.keywardChecked})
      : super(key: key);

  @override
  State<FashionDetail> createState() => _FashionDetailState();
}

class _FashionDetailState extends State<FashionDetail> {
  late Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 50),
          Row(
            children: [
              SizedBox(width: 30),
              Container(
                child: Text(
                  "#${widget.fashion.musinsaStyle}",
                  style: TextStyle(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      fontSize: 18,
                      decoration: TextDecoration.underline,
                      decorationColor:
                          const Color.fromARGB(255, 255, 255, 255)),
                ),
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(3)),
                padding: EdgeInsets.fromLTRB(5, 2, 5, 2),
                margin: EdgeInsets.only(right: 2),
              ),
              Text(
                "에 추천되는 코디",
                style: TextStyle(
                    fontSize: 23, color: const Color.fromARGB(255, 0, 0, 0)),
              )
            ],
          ),
          SizedBox(height: 10),
          Center(
            child: Container(
              height: 550,
              width: 350,
              child: google_drive_image(id: widget.fashion.musinsaFileid),
            ),
          ),
          SizedBox(height: 20),
          Stack(
            children: [
              Container(
                margin: EdgeInsets.only(left: 60),
                child: Text(''),
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(
                        widget.fashion.musinsaRed.toInt(),
                        widget.fashion.musinsaGreen.toInt(),
                        widget.fashion.musinsaBlue.toInt(),
                        1),
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: Colors.grey, width: 0.3)),
              ),
              Container(
                margin: EdgeInsets.only(left: 30),
                child: _imageBuild(widget.fashion.musinsaFileid),
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: Colors.grey, width: 0.3)),
              ),
              Container(
                margin: EdgeInsets.only(left: 130),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Model",
                      style:
                          TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${widget.fashion.musinsaGender} / ${widget.fashion.musinsaHeight}cm / ${widget.fashion.musinsaWeight}kg',
                      style: TextStyle(fontSize: 10, color: Colors.grey),
                    ),
                    Text(
                      'Hue / Saturation / Value',
                      style:
                          TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${widget.fashion.musinsaHue} / ${widget.fashion.musinsaSaturation} / ${widget.fashion.musinsaValue}',
                      style: TextStyle(fontSize: 10, color: Colors.grey),
                    ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              SizedBox(width: 30),
              widget.keywardChecked
                  ? Row(
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(7, 7, 7, 7),
                          child: Text(
                            '#${widget.fashion.musinsaStyle}',
                            style: TextStyle(
                                fontSize: 13,
                                color: widget.keywardChecked
                                    ? Color.fromARGB(255, 255, 255, 255)
                                    : Color.fromARGB(255, 127, 127, 127)),
                          ),
                          color: widget.keywardChecked
                              ? Color.fromARGB(255, 127, 127, 127)
                              : Color.fromRGBO(240, 240, 240, 1),
                        ),
                        SizedBox(width: 10),
                        Container(
                            padding: EdgeInsets.fromLTRB(7, 7, 7, 7),
                            child: Text(
                              '#${widget.fashion.musinsaPersonal}',
                              style: TextStyle(
                                  fontSize: 13,
                                  color: widget.personalColorChecked
                                      ? Colors.white
                                      : Color.fromARGB(255, 127, 127, 127)),
                            ),
                            color: widget.personalColorChecked
                                ? Color.fromARGB(255, 127, 127, 127)
                                : Color.fromRGBO(240, 240, 240, 1)),
                      ],
                    )
                  : Row(children: [
                      Container(
                          padding: EdgeInsets.fromLTRB(7, 7, 7, 7),
                          child: Text(
                            '#${widget.fashion.musinsaPersonal}',
                            style: TextStyle(
                                fontSize: 13,
                                color: widget.personalColorChecked
                                    ? Colors.white
                                    : Color.fromARGB(255, 127, 127, 127)),
                          ),
                          color: widget.personalColorChecked
                              ? Color.fromARGB(255, 127, 127, 127)
                              : Color.fromRGBO(240, 240, 240, 1)),
                      SizedBox(width: 10),
                      Container(
                        padding: EdgeInsets.fromLTRB(7, 7, 7, 7),
                        child: Text(
                          '#${widget.fashion.musinsaStyle}',
                          style: TextStyle(
                              fontSize: 13,
                              color: widget.keywardChecked
                                  ? Color.fromARGB(255, 255, 255, 255)
                                  : Color.fromARGB(255, 127, 127, 127)),
                        ),
                        color: widget.keywardChecked
                            ? Color.fromARGB(255, 127, 127, 127)
                            : Color.fromRGBO(240, 240, 240, 1),
                      ),
                    ]),
              SizedBox(width: 10),
              Container(
                  padding: EdgeInsets.fromLTRB(7, 7, 7, 7),
                  child: Text(
                    '#${widget.fashion.musinsaSeason}',
                    style: TextStyle(
                        fontSize: 13,
                        color: Color.fromARGB(255, 127, 127, 127)),
                  ),
                  color: Color.fromRGBO(240, 240, 240, 1)),
              SizedBox(width: 10),
              Container(
                  padding: EdgeInsets.fromLTRB(7, 7, 7, 7),
                  child: Text(
                    '#${widget.fashion.musinsaGender}',
                    style: TextStyle(
                        fontSize: 13,
                        color: Color.fromARGB(255, 127, 127, 127)),
                  ),
                  color: Color.fromRGBO(240, 240, 240, 1)),
            ],
          ),
          Container(
            margin: EdgeInsets.only(left: 20),
            child: TextButton(
              onPressed: () {
                launchUrl(Uri.parse(
                    'https://www.musinsa.com/app/styles/views/${widget.fashion.musinsaNumber}'));
              },
              child: Text(
                '해당 코디 자세히 보기 >',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _imageBuild(String id) {
  return Container(
    width: 50,
    height: 50,
    decoration: BoxDecoration(
        image: DecorationImage(
          alignment: Alignment.topCenter,
          fit: BoxFit.fitWidth,
          image:
              NetworkImage("https://drive.google.com/thumbnail?id=$id&sz=w300"),
        ),
        borderRadius: BorderRadius.circular(100)),
  );
}
