import 'package:flutter/material.dart';

import '../model/color_model.dart';
import 'dart:math';

class FlChart extends StatefulWidget {
  final int myStyleLength;
  final Map<String, dynamic> styleResult;

  const FlChart(
      {Key? key, required this.myStyleLength, required this.styleResult})
      : super(key: key);

  @override
  State<FlChart> createState() => _FlChartState();
}

class _FlChartState extends State<FlChart> {
  @override
  Widget build(BuildContext context) {
    List<PieModel> model = [];
    List<String> dataDescriptions = [];
    int i = 0;
    final List<Color> _colors = [
      const Color.fromRGBO(255, 176, 170, 1),
      const Color.fromRGBO(162, 213, 255, 1),
      const Color.fromRGBO(212, 212, 212, 1),
      const Color.fromRGBO(255, 227, 144, 1),
      const Color.fromRGBO(145, 244, 148, 1),
      const Color.fromRGBO(140, 242, 255, 1),
      const Color.fromRGBO(233, 141, 249, 1),
      Color.fromARGB(255, 227, 249, 141),
      Color.fromARGB(255, 141, 153, 249),
    ];

    // styleResult가 null이 아니고 비어있지 않은 경우에만 데이터를 추출합니다.
    if (widget.styleResult != null && widget.styleResult.isNotEmpty) {
      Map<String, dynamic> styleResults = Map<String, dynamic>.fromEntries(
          widget.styleResult.entries.toList()
            ..sort((a, b) => b.value.compareTo(a.value)));
      // styleResult를 value를 기준으로 내림차순 정렬

      if (widget.styleResult.isNotEmpty) {
        styleResults.forEach((key, value) {
          dataDescriptions.add("$key");
          model.add(PieModel(count: value, color: _colors[i]));
          i++;
        });
        // widget으로 출력해주기
      }
    }

    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            height: MediaQuery.of(context).size.width * 0.7,
            child: CustomPaint(
              size: Size(
                MediaQuery.of(context).size.width * 0.7,
                MediaQuery.of(context).size.width * 0.7,
              ),
              painter: _PieChart(model),
            ),
          ),
          // 원형 그래프
          SizedBox(height: 20),
          ListView.builder(
            shrinkWrap: true,
            itemCount: model.length,
            itemBuilder: (context, index) {
              final entry = model.asMap().entries.elementAt(index);
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      color: entry.value.color,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        dataDescriptions[entry.key],
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _PieChart extends CustomPainter {
  final List<PieModel> data;

  _PieChart(this.data);

  @override
  void paint(Canvas canvas, Size size) {
    double total = 0;
    data.forEach((item) => total += item.count);

    Paint circlePaint = Paint();
    double _startPoint = -pi / 2;
    for (int i = 0; i < data.length; i++) {
      double _sweepAngle = 2 * pi * (data[i].count / total);
      circlePaint.color = data[i].color;

      canvas.drawArc(
        Rect.fromCircle(
          center: Offset(size.width / 2, size.width / 2),
          radius: (size.width / 2) * 0.8,
        ),
        _startPoint,
        _sweepAngle,
        true,
        circlePaint,
      );
      _startPoint += _sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
