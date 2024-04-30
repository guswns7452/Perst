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

class personalResultModel {
  final int count;
  final String personalColor;

  personalResultModel(this.count, this.personalColor);
}

class PersonalColor {
  final String personalColorType;
  final int personalColorAllTimes;
  final DateTime personalColorDate;
  final PersonalSelect personalSelectsFirst;
  final PersonalSelect personalSelectsSecond;
  final List<Color> personalColorRepresentative;
  final PersonalColorInfo personalColorInfo;

  PersonalColor({
    required this.personalColorType,
    required this.personalColorAllTimes,
    required this.personalColorDate,
    required this.personalSelectsFirst,
    required this.personalSelectsSecond,
    required this.personalColorRepresentative,
    required this.personalColorInfo,
  });

  factory PersonalColor.fromJson(Map<String, dynamic> json) {
    return PersonalColor(
      personalColorType: json['personalColorType'],
      personalColorAllTimes: json['personalColorAllTimes'],
      personalColorDate: DateTime.parse(json['personalColorDate']),
      personalSelectsFirst:
          PersonalSelect.fromJson(json['personalSelectsFirst']),
      personalSelectsSecond:
          PersonalSelect.fromJson(json['personalSelectsSecond']),
      personalColorRepresentative:
          (json['personalColorRepresentative'] as List<dynamic>)
              .map((colorJson) => Color.fromJson(colorJson))
              .toList(),
      personalColorInfo: PersonalColorInfo.fromJson(json['personalColorInfo']),
    );
  }
}

class PersonalSelect {
  final String personalSelectType;
  final int personalSelectRatio;

  PersonalSelect({
    required this.personalSelectType,
    required this.personalSelectRatio,
  });

  factory PersonalSelect.fromJson(Map<String, dynamic> json) {
    return PersonalSelect(
      personalSelectType: json['personalSelectType'],
      personalSelectRatio: json['personalSelectRatio'],
    );
  }
}

class Color {
  final int red;
  final int green;
  final int blue;

  Color({
    required this.red,
    required this.green,
    required this.blue,
  });

  factory Color.fromJson(Map<String, dynamic> json) {
    return Color(
      red: json['red'],
      green: json['green'],
      blue: json['blue'],
    );
  }

  static fromRGBO(int i, int j, int k, int l) {}
}

class PersonalColorInfo {
  final String hue;
  final String saturation;
  final String value;

  PersonalColorInfo({
    required this.hue,
    required this.saturation,
    required this.value,
  });

  factory PersonalColorInfo.fromJson(Map<String, dynamic> json) {
    return PersonalColorInfo(
      hue: json['hue'],
      saturation: json['saturation'],
      value: json['value'],
    );
  }
}
