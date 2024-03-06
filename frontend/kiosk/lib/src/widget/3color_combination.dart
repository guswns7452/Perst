import 'package:flutter/material.dart';
import 'package:kiosk/src/model/color_model.dart';

class YourPage extends StatelessWidget {
  final Map<String, dynamic> result;

  YourPage(this.result);

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> jsonData = [
      result['styleColor']
    ]; // API에서 받은 데이터

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Page'),
      ),
      body: StyleColorView(jsonData),
    );
  }
}

class StyleColorView extends StatelessWidget {
  final List<Map<String, dynamic>> jsonData; // API에서 가져온 JSON 데이터가 들어감

  StyleColorView(this.jsonData);

  @override
  Widget build(BuildContext context) {
    List<StyleColor> styleColors = []; // StyleColor 객체들을 담을 리스트

    // JSON 데이터를 StyleColor 객체로 변환하여 리스트에 추가
    jsonData.forEach((json) {
      json.forEach((key, value) {
        if (key == 'styleColor') {
          List<dynamic> colors = value;
          colors.forEach((color) {
            styleColors.add(StyleColor.fromJson(color));
          });
        }
      });
    });

    // 화면에 StyleColor를 표시하는 ListView를 반환
    return ListView.builder(
      itemCount: styleColors.length,
      itemBuilder: (context, index) {
        final styleColor = styleColors[index];
        final color = Color.fromRGBO(
          styleColor.styleRed,
          styleColor.styleGreen,
          styleColor.styleBlue,
          1,
        );
        return ListTile(
          title: Text('Color ${styleColor.styleColorNumber}'),
          subtitle: Text('Ratio: ${styleColor.styleRatio.toStringAsFixed(2)}'),
          leading: CircleAvatar(
            backgroundColor: color,
            radius: 20,
          ),
        );
      },
    );
  }
}
