import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class FlChart extends StatelessWidget {
  final int myStyleLength;
  final Map<String, dynamic> styleResult;

  const FlChart(
      {Key? key, required this.myStyleLength, required this.styleResult})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<PieChartSectionData> sections = [];
    List<String> dataDescriptions = [];
    int i = 0;
    final List<Color> _colors = [
      const Color.fromRGBO(255, 176, 170, 1),
      const Color.fromRGBO(162, 213, 255, 1),
      const Color.fromRGBO(212, 212, 212, 1),
      const Color.fromRGBO(255, 227, 144, 1),
      const Color.fromRGBO(145, 244, 148, 1),
      const Color.fromRGBO(140, 242, 255, 1),
      Color.fromARGB(255, 253, 167, 246),
      Color.fromARGB(255, 227, 249, 141),
      Color.fromARGB(255, 141, 153, 249),
      Color.fromARGB(255, 219, 111, 255),
    ];

    List<String> stylePercent = [];

    // styleResult가 null이 아니고 비어있지 않은 경우에만 데이터를 추출합니다.
    if (styleResult != null && styleResult.isNotEmpty) {
      Map<String, dynamic> styleResults = Map<String, dynamic>.fromEntries(
          styleResult.entries.toList()
            ..sort((a, b) => b.value.compareTo(a.value)));
      // styleResult를 value를 기준으로 내림차순 정렬

      if (styleResult.isNotEmpty) {
        for (int style in styleResult.values) {
          stylePercent
              .add((style / myStyleLength * 100).toDouble().toStringAsFixed(1));
        }
        styleResults.forEach((key, value) {
          dataDescriptions.add("$key");
          sections.add(PieChartSectionData(
            color: _colors[i],
            value: value.toDouble(),
            title: i < 2 ? stylePercent[i] + '%' : '',
          ));
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
            child: PieChart(
              PieChartData(
                sections: sections,
                borderData: FlBorderData(show: false),
                centerSpaceRadius: 50,
                sectionsSpace: 0,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: dataDescriptions.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Container(
                        width: 15,
                        height: 15,
                        decoration: BoxDecoration(
                            color: _colors[index],
                            borderRadius: BorderRadius.circular(50)),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          dataDescriptions[index],
                          style: TextStyle(fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
