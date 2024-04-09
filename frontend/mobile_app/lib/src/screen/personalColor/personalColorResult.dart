import 'package:flutter/material.dart';
import 'package:perst/src/model/color_radio_model.dart';

class PersonalColorResult extends StatefulWidget {
  final PersonalColorModel PCM;
  final String season;
  final int personalCnt;

  const PersonalColorResult(
      {required this.PCM,
      required this.season,
      required this.personalCnt,
      Key? key})
      : super(key: key);

  @override
  State<PersonalColorResult> createState() => _PersonalColorResultState();
}

class _PersonalColorResultState extends State<PersonalColorResult> {
  @override
  void initState() {
    super.initState();
    List<int> values = [
      widget.PCM.SpringRight,
      widget.PCM.SpringBright,
      widget.PCM.SummerBright,
      widget.PCM.SummerMute,
      widget.PCM.SummerRight,
      widget.PCM.FallMute,
      widget.PCM.FallDeep,
      widget.PCM.FallStrong,
      widget.PCM.WinterDeep,
      widget.PCM.WinterBright,
    ];

    values.sort((a, b) => b.compareTo(a));

    for (int i = 0; i < 3 && i < values.length; i++) {
      print(values[i]);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text(widget.season),
        ],
      ),
    );
  }
}
