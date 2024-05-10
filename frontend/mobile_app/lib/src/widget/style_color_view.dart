import 'package:flutter/material.dart';
import 'package:perst/src/model/color_model.dart';

class StyleColorView extends StatelessWidget {
  final Map<String, dynamic>? result;

  const StyleColorView({Key? key, required this.result}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<dynamic>? styleColorData = result!['styleColor'];
    List<StyleColor> styleColors = [];

    if (styleColorData != null) {
      styleColorData!.forEach((json) {
        styleColors.add(StyleColor.fromJson(json));
      });
    }

    return Container(
      height: 160,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: styleColors.length,
        itemBuilder: (context, index) {
          final styleColor = styleColors[index];
          final color = Color.fromRGBO(
            styleColor.styleRed,
            styleColor.styleGreen,
            styleColor.styleBlue,
            1,
          );

          // RGB 값을 사용하여 색상 코드 생성
          String colorCode =
              '#${styleColor.styleRed.toRadixString(16).padLeft(2, '0')}'
              '${styleColor.styleGreen.toRadixString(16).padLeft(2, '0')}'
              '${styleColor.styleBlue.toRadixString(16).padLeft(2, '0')}';

          return Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      backgroundColor: color,
                      radius: 70, // 원의 반지름을 조정하여 크기 조절
                    ),
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          '${colorCode}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15, // 텍스트 크기 조정
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
