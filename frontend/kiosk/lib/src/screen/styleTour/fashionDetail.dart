import 'package:flutter/material.dart';
import 'package:kiosk/src/widget/google_drive_image.dart';

class FashionDetail extends StatefulWidget {
  const FashionDetail({super.key});

  @override
  State<FashionDetail> createState() => _FashionDetailState();
}

// TODO: musinsaNumber를 받아와서 번호에 해당하는 내용 띄워주기
class _FashionDetailState extends State<FashionDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // TODO: fileId를 넘겨서 사진 띄우기
          Container(
              // margin: EdgeInsets.fromLTRB(130, 20, 0, 0),
              child:
                  google_drive_image(id: '1ePHl_Wt1bZKgiCQ6PF8OAwABq7fTmLV5')),
          SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(7, 3, 7, 3),
                // TODO: musinsaSeason 태그 넣기
                child: Text(
                  '#겨울',
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  // TODO: 여름, 봄, 가을, 겨울 별로 색 다르게 하기
                  // color: Color.fromRGBO(96, 206, 100, 1), // 여름
                  // color: Color.fromRGBO(249, 171, 245, 1), // 봄
                  // color: Color.fromRGBO(170, 7, 7, 1), // 가을
                  color: Color.fromRGBO(6, 66, 184, 1), // 겨울
                ),
              ),
              SizedBox(width: 10),
              Container(
                padding: EdgeInsets.fromLTRB(7, 3, 7, 3),
                // TODO: musinsaStyle 태그 넣기
                child: Text(
                  '#고프코어',
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
                // TODO: musinsaGender 태그 넣기
                child: Text(
                  '#women',
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  // TODO: 남자, 여자 색 다르게 하기
                  // color: Color.fromRGBO(59, 130, 246, 1), // 남자
                  color: Color.fromRGBO(236, 72, 153, 1), // 여자
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
                // TODO: musinsaHeight넣기
                Text(
                  '   키: 188',
                  style: TextStyle(fontSize: 20),
                ),
                // TODO: musinsaWeight 넣기
                Text(
                  '   체중: 70',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
