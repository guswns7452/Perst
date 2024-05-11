import 'package:flutter/material.dart';
import 'package:perst/src/widget/google_drive_image.dart';
import 'package:url_launcher/url_launcher.dart';

class FashionDetail extends StatefulWidget {
  final fashion;

  const FashionDetail({required this.fashion, Key? key}) : super(key: key);

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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              height: 550,
              width: 350,
              child: google_drive_image(id: widget.fashion.musinsaFileid),
            ),
          ),
          SizedBox(height: 20),
          Row(
            children: [
              SizedBox(width: 30),
              Container(
                  padding: EdgeInsets.fromLTRB(7, 7, 7, 7),
                  child: Text(
                    '#${widget.fashion.musinsaSeason}',
                    style: TextStyle(
                        fontSize: 15,
                        color: Color.fromARGB(255, 127, 127, 127)),
                  ),
                  color: Color.fromRGBO(224, 224, 224, 1)),
              SizedBox(width: 10),
              Container(
                padding: EdgeInsets.fromLTRB(7, 7, 7, 7),
                child: Text(
                  '#${widget.fashion.musinsaStyle}',
                  style: TextStyle(
                      fontSize: 15, color: Color.fromARGB(255, 127, 127, 127)),
                ),
                color: Color.fromRGBO(224, 224, 224, 1),
              ),
              SizedBox(width: 10),
              Container(
                  padding: EdgeInsets.fromLTRB(7, 7, 7, 7),
                  child: Text(
                    '#${widget.fashion.musinsaGender}',
                    style: TextStyle(
                        fontSize: 15,
                        color: Color.fromARGB(255, 127, 127, 127)),
                  ),
                  color: Color.fromRGBO(224, 224, 224, 1)),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              SizedBox(width: 30),
              Text(
                widget.fashion.musinsaGender == "woman" ? "여성" : "남성",
                style: TextStyle(fontSize: 15),
              ),
              Image.asset('assets/dot.png', height: 15),
              Text(
                '${widget.fashion.musinsaHeight}cm',
                style: TextStyle(fontSize: 15),
              ),
              Image.asset('assets/dot.png', height: 15),
              Text(
                '${widget.fashion.musinsaWeight}kg',
                style: TextStyle(fontSize: 15),
              ),
            ],
          ),
          Center(
            child: TextButton(
              onPressed: () {
                launchUrl(Uri.parse(
                    'https://www.musinsa.com/app/styles/views/${widget.fashion.musinsaNumber}'));
              },
              child: Text('패션 링크로 이동하기'),
            ),
          )
        ],
      ),
    );
  }
}
