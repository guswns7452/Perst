import 'package:flutter/material.dart';

class StyleColor {
  final int styleColorNumber;
  final int styleNumber;
  final int styleRed;
  final int styleGreen;
  final int styleBlue;
  final double styleRatio;

  StyleColor({
    required this.styleColorNumber,
    required this.styleNumber,
    required this.styleRed,
    required this.styleGreen,
    required this.styleBlue,
    required this.styleRatio,
  });

  factory StyleColor.fromJson(Map<String, dynamic> json) {
    return StyleColor(
      styleColorNumber: json['styleColorNumber'],
      styleNumber: json['styleNumber'],
      styleRed: json['styleRed'],
      styleGreen: json['styleGreen'],
      styleBlue: json['styleBlue'],
      styleRatio: json['styleRatio'],
    );
  }
}

class ResultColorList {
  final int red;
  final int green;
  final int blue;

  ResultColorList(this.red, this.green, this.blue);
}

class PieModel {
  final int count;
  final Color color;

  PieModel({
    required this.count,
    required this.color,
  });
}
