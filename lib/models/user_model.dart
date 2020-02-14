class UserModel {
  String name;
  String profilePhoto;
  String userTel;
  String inviteCode;
  String userCode;
  String token;
  int id;
  double redPackage;
  double dsc; //直购币
  String aliUserId; //支付宝提现授权id
  String wcUserId; //微信授权id
  int ticketNum; //我的优惠券数量
  int isNovice; //是否是新人
  bool deliver; //发货
  bool rush; //抢购
  bool receive; //收货

  UserModel.fromJson(Map<String, dynamic> json)
      : name = json["name"],
        profilePhoto = json["profilePhoto"],
        userTel = json["userTel"],
        inviteCode = json["inviteCode"],
        userCode = json["userCode"],
        token = json["token"],
        id = json["id"],
        redPackage = json["redPackage"],
        dsc = json["dsc"] ?? 0,
        aliUserId = json["aliUserId"],
        wcUserId = json["wcUserId"],
        ticketNum = json["ticketNum"],
        isNovice = json["isNovice"],
        deliver = json["deliver"],
        rush = json["rush"],
        receive = json["receive"];

  Map<String, dynamic> toJson() => {
        'name': name,
        'profilePhoto': profilePhoto,
        'userTel': userTel,
        'inviteCode': inviteCode,
        'userCode': userCode,
        'token': token,
        'id': id,
        'redPackage': redPackage,
        'dsc': dsc,
        'aliUserId': aliUserId,
        'wcUserId': wcUserId,
        'ticketNum': ticketNum,
        'isNovice': isNovice,
        'deliver': deliver,
        'rush': rush,
        'receive': receive,
      };
}
