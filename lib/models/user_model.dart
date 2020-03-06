class UserModel {
  String accountId;
  String unionid;
  String name;
  String nickname;
  String headimgurl;
  String idNumber;
  String phone;
  String token;

  UserModel.fromJson(Map<String, dynamic> json)
      : accountId = json["accountId"],
        name = json["name"],
        unionid = json["unionid"],
        nickname = json["nickname"],
        headimgurl = json["headimgurl"],
        idNumber = json["idNumber"],
        phone = json["phone"],
        token = json["token"];

  Map<String, dynamic> toJson() => {
        'accountId': accountId,
        'name': name,
        'unionid': unionid,
        'nickname': nickname,
        'headimgurl': headimgurl,
        'idNumber': idNumber,
        'phone': phone,
        'token': token,
      };
}
