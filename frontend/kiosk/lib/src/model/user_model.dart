class UserModel {
  int? memberPhone;
  String? memberPassword;

  UserModel.fromJason(Map m) {
    /* 
    이름이 있는 생성자
    {
      "memberPhone" : "01051234567",
      "memberPassword": "passwd"
    }
    */

    memberPhone = m['memberPhone'];
    memberPassword = m['memberPassword'];
  }
}
