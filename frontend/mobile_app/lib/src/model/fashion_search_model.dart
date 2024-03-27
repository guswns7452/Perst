/*
      "musinsaNumber": 34376,
      "musinsaGender": "man",
      "musinsaHeight": 188,
      "musinsaWeight": 70,
      "musinsaSeason": "여름",
      "musinsaStyle": "고프코어",
      "musinsaFileid": "id"
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

  FashionSearchModel.fromJson(Map m) {
    musinsaNumber = m['musinsaNumber'];
    musinsaGender = m['musinsaGender'];
    musinsaHeight = m['musinsaHeight'];
    musinsaWeight = m['musinsaWeight'];
    musinsaSeason = m['musinsaSeason'];
    musinsaStyle = m['musinsaStyle'];
    musinsaFileid = m['musinsaFileid'];
  }
}
