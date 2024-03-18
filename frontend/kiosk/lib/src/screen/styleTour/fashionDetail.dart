import 'package:flutter/material.dart';
import 'package:kiosk/src/widget/google_drive_image.dart';
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
    String season = widget.fashion.musinsaSeason;

    if (season == "spring") {
      backgroundColor = Color.fromRGBO(249, 171, 245, 1);
    } else if (season == "summer") {
      backgroundColor = Color.fromRGBO(96, 206, 100, 1);
    } else if (season == "fall") {
      backgroundColor = Color.fromRGBO(170, 7, 7, 1);
    } else if (season == "winter") {
      backgroundColor = Color.fromRGBO(6, 66, 184, 1);
    } else {
      // 기본값 설정
      backgroundColor = Colors.black;
    }

    // launchURL() async {
    //   String url =
    //       "https://www.musinsa.com/app/styles/views/$widget.musinsaNumber";
    //   if (await canLaunchUrl(url)) {
    //     await launch(url);
    //   } else {
    //     throw Exception("url 연결 실패");
    //   }
    // }

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: google_drive_image(id: widget.fashion.musinsaFileid),
          ),
          SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(7, 3, 7, 3),
                child: Text(
                  '#${widget.fashion.musinsaSeason}',
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: backgroundColor,
                ),
              ),
              SizedBox(width: 10),
              Container(
                padding: EdgeInsets.fromLTRB(7, 3, 7, 3),
                child: Text(
                  '#${widget.fashion.musinsaStyle}',
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: Color.fromRGBO(54, 54, 54, 1),
                ),
              ),
              SizedBox(width: 10),
              Container(
                padding: EdgeInsets.fromLTRB(7, 3, 7, 3),
                child: Text(
                  '#${widget.fashion.musinsaGender}',
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: widget.fashion.musinsaGender == 'man'
                      ? Color.fromRGBO(59, 130, 246, 1) // 남자
                      : Color.fromRGBO(236, 72, 153, 1), // 여자
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.fromLTRB(20, 50, 0, 0),
            padding: EdgeInsets.only(bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '#모델 정보',
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  '   키: ${widget.fashion.musinsaHeight}',
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  '   체중: ${widget.fashion.musinsaWeight}',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
          TextButton(
              onPressed: () {
                // launchURL();
                launchUrl(Uri.parse('https://www.musinsa.com/app/styles/views/${widget.fashion.musinsaNumber}'));
              },
              child: Text('패션 링크로 이동하기'))
        ],
      ),
    );
  }
}