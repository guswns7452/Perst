// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:perst/src/screen/style/styleAnalysisImage.dart';

class StyleAnalysis extends StatelessWidget {
  const StyleAnalysis({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            'Perst',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(0, 0, 0, 1),
            ),
          ),
          centerTitle: false,
          // 기본적인 목록, 알림, 검색 버튼 사용할지 말지 미지수
          /* actions: const [
            IconButton(
              onPressed: null,
              icon: Icon(Icons.menu),
            ),
            IconButton(
              onPressed: null,
              icon: Icon(Icons.search),
            ),
            IconButton(
                onPressed: null, icon: Icon(Icons.notifications_outlined)),
          ], */
        ),
        bottomNavigationBar: const SafeArea(
          child: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.home), text: 'styleTour'),
              Tab(icon: Icon(Icons.feed), text: 'styleAnalysis'),
              Tab(icon: Icon(Icons.location_on_outlined), text: 'myStyle'),
              Tab(
                  icon: Icon(Icons.chat_bubble_outline_rounded),
                  text: 'myPage'),
            ],
          ),
        ),
        body: const TabBarView(children: [
          Center(child: Text('page1')),
          StyleAnalysisImage(),
          Center(child: Text('page3')),
          Center(child: Text('page4')),
        ]),
      ),
    );
  }
}
