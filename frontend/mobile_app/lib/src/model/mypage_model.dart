class MystyleModel {
  int? styleNumber;
  String? styleFileID;
  String? styleName;
  String? styleDate;

  MystyleModel.fromJson(Map m) {
    styleNumber = m['styleNumber'];
    styleFileID = m['styleFileID'];
    styleName = m['styleName'];
    styleDate = m['styleDate'];
  }
}
