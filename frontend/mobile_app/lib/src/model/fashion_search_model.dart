/*
      "musinsaNumber": 30077,
            "musinsaGender": "man",
            "musinsaHeight": 184,
            "musinsaWeight": 58,
            "musinsaSeason": "winter",
            "musinsaStyle": "casual",
            "musinsaFileid": "1sFTcuUvAjvFfmr0vYHNM4FjjNIT9MdEX",
            "musinsaType": "codishop",
            "musinsaPersonal": "겨울 딥 ",
            "musinsaRed": 22.0,
            "musinsaGreen": 35.0,
            "musinsaBlue": 29.0,
            "musinsaHue": 152,
            "musinsaSaturation": 37,
            "musinsaValue": 14
 */

class FashionSearchModel {
  FashionSearchModel() {}

  int? musinsaNumber;
  String? musinsaGender;
  int? musinsaHeight;
  int? musinsaWeight;
  String? musinsaSeason;
  String? musinsaStyle;
  String? musinsaFileid;
  String? musinsaType;
  String? musinsaPersonal;
  double? musinsaRed;
  double? musinsaGreen;
  double? musinsaBlue;
  int? musinsaHue;
  int? musinsaSaturation;
  int? musinsaValue;

  FashionSearchModel.fromJson(Map m) {
    musinsaNumber = m['musinsaNumber'];
    musinsaGender = m['musinsaGender'];
    musinsaHeight = m['musinsaHeight'];
    musinsaWeight = m['musinsaWeight'];
    musinsaSeason = m['musinsaSeason'];
    musinsaStyle = m['musinsaStyle'];
    musinsaFileid = m['musinsaFileid'];
    musinsaType = m['musinsaType'];
    musinsaPersonal = m['musinsaPersonal'];
    musinsaRed = m['musinsaRed'];
    musinsaGreen = m['musinsaGreen'];
    musinsaBlue = m['musinsaBlue'];
    musinsaHue = m['musinsaHue'];
    musinsaSaturation = m['musinsaSaturation'];
    musinsaValue = m['musinsaValue'];
  }
}
