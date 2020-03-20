class UserModel {
  int id;
  String unionid;
  String name;
  String nickName;
  String headimgurl;
  String idNumber;
  String phone;
  String passwd;

  UserModel.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"],
        unionid = json["unionid"],
        nickName = json["nickName"],
        headimgurl = json["headimgurl"],
        idNumber = json["idNumber"],
        phone = json["phone"],
        passwd = json["passwd"];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'unionid': unionid,
        'nickName': nickName,
        'headimgurl': headimgurl,
        'idNumber': idNumber,
        'phone': phone,
        'passwd': passwd,
      };
}
