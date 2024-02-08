import 'package:flutter/material.dart';

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
          // 키워드에 맞는 이미지 100개 정도?
          Image.asset(
            'assets/fashion1.jpg',
            height: 300,
          ),
          // 브랜드명
          Text(
            'HAZZYS',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
          )
        ],
      ),
    );
  }
}
