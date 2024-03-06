import 'package:flutter/material.dart';
import 'package:kiosk/src/screen/styleTour/fashionDetail.dart';
import 'package:kiosk/src/widget/google_drive_image.dart';

class KeywordFashionWidget extends StatefulWidget {
  const KeywordFashionWidget({super.key});

  @override
  State<KeywordFashionWidget> createState() => _KeywordFashionWidgetState();
}

class _KeywordFashionWidgetState extends State<KeywordFashionWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          // Todo: fileId 가져와서 이미지 띄우기
          OutlinedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                // TODO: musinsaNumber을 넘겨주기.
                builder: (context) => const FashionDetail(),
              ));
            },
            child: google_drive_image(id: '1AcTmlxRrzr40lZqQqg1LyBEX-CC7xSOt'),
            style: OutlinedButton.styleFrom(
                backgroundColor: Colors.white,
                side: BorderSide(
                  width: 0,
                  color: Colors.transparent,
                )),
          ),
        ],
      ),
    );
  }
}
