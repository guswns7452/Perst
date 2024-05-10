class ColorRadioModel {
  final int Red;
  final int Green;
  final int Blue;
  final double O;
  final String PersonalColor;

  ColorRadioModel(this.Red, this.Green, this.Blue, this.O, this.PersonalColor);
}

class PersonalColorModel {
  int SpringRight;
  String SSpringRight;
  int SpringBright;
  String SSpringBright;
  int SummerRight;
  String SSummerRight;
  int SummerBright;
  String SSummerBright;
  int SummerMute;
  String SSummerMute;
  int FallMute;
  String SFallMute;
  int FallStrong;
  String SFallStrong;
  int FallDeep;
  String SFallDeep;
  int WinterBright;
  String SWinterBright;
  int WinterDeep;
  String SWinterDeep;

  PersonalColorModel(
      this.SpringRight,
      this.SSpringRight,
      this.SpringBright,
      this.SSpringBright,
      this.SummerRight,
      this.SSummerRight,
      this.SummerBright,
      this.SSummerBright,
      this.SummerMute,
      this.SSummerMute,
      this.FallMute,
      this.SFallMute,
      this.FallStrong,
      this.SFallStrong,
      this.FallDeep,
      this.SFallDeep,
      this.WinterBright,
      this.SWinterBright,
      this.WinterDeep,
      this.SWinterDeep);

  toMap() {}
}

final List<ColorRadioModel> warmCool = [
  ColorRadioModel(223, 167, 177, 1, 'SpR'),
  ColorRadioModel(177, 167, 223, 1, 'SuR'),
  ColorRadioModel(128, 96, 101, 1, 'FM'),
  ColorRadioModel(58, 45, 128, 1, 'WB'),
  ColorRadioModel(116, 204, 71, 1, 'SpB'),
  ColorRadioModel(26, 64, 57, 1, 'WD'),
  ColorRadioModel(104, 128, 57, 1, 'FS'),
  ColorRadioModel(82, 204, 204, 1, 'SuB'),
  // 웜, 쿨 판단
];

final List<ColorRadioModel> fallspring = [
  ColorRadioModel(77, 31, 34, 1, 'FD'), // 가을 딥
  ColorRadioModel(204, 122, 129, 1, 'SpR'), // 봄 라이트
  ColorRadioModel(128, 77, 102, 1, 'FM'), // 가을 뮤트
  ColorRadioModel(204, 61, 133, 1, 'SpB'), // 봄 브라이트
  ColorRadioModel(128, 98, 38, 1, 'FS'), // 가을 스트롱
  ColorRadioModel(204, 184, 143, 1, 'SpR'), // 봄 라이트
  ColorRadioModel(89, 128, 102, 1, 'FM'), // 가을 뮤트
  ColorRadioModel(143, 204, 163, 1, 'SpR'), // 봄 라이트
  // 웜 -> 가을, 봄 판단
];

final List<ColorRadioModel> summerWinter = [
  ColorRadioModel(153, 204, 179, 1, 'SuR'), // 여름 라이트
  ColorRadioModel(51, 128, 89, 1, 'WB'), // 겨울 브라이트
  ColorRadioModel(82, 163, 204, 1, 'SuB'), // 여름 브라이트
  ColorRadioModel(31, 61, 77, 1, 'WD'), // 겨울 딥
  ColorRadioModel(101, 96, 128, 1, 'SuM'), // 여름 뮤트
  ColorRadioModel(43, 25, 128, 1, 'WB'), // 겨울 브라이트
  ColorRadioModel(153, 115, 153, 1, 'SuM'), // 여름 뮤트
  ColorRadioModel(77, 31, 77, 1, 'WD'), // 겨울 딥
  // 쿨 -> 여름, 겨울 판단
];

final List<ColorRadioModel> spring = [
  ColorRadioModel(217, 163, 172, 1, 'SpR'), // 라이트
  ColorRadioModel(204, 71, 94, 1, 'SpB'), // 브라이트
  // 봄 -> 라이트, 브라이트 판단
];
final List<ColorRadioModel> summer = [
  ColorRadioModel(163, 199, 217, 1, 'SuR'), // 라이트
  ColorRadioModel(82, 163, 204, 1, 'SuB'), // 브라이트
  ColorRadioModel(115, 140, 153, 1, 'SuM'), // 뮤트
  // 여름 -> 라이트, 브라이트 판단
];
final List<ColorRadioModel> fall = [
  ColorRadioModel(153, 115, 121, 1, 'FM'), // 뮤트
  ColorRadioModel(128, 38, 53, 1, 'FS'), // 스트롱
  ColorRadioModel(64, 22, 29, 1, 'FD'), // 딥
  // 가을 -> 뮤트, 스트롱, 딥 판단
];
final List<ColorRadioModel> winter = [
  ColorRadioModel(58, 45, 128, 1, 'WB'), // 브라이트
  ColorRadioModel(38, 31, 77, 1, 'WD'), // 딥
  // 겨울 -> 브라이트, 딥 판단
];
