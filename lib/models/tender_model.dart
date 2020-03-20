enum BidState { none, reserved, notreserved, successful }

const List<String> BidStateDisplay = [
  "",
  "待拍牌",
  "未预约",
  "中标",
];

class TenderModel {
  int id;
  int account_id;
  String bid_number;
  String bid_passwd;
  String id_number;
  String order_idx;
  String phone;
  String validDate;
  int state;
  int times;
  int is_default;
  String invite_code;

  TenderModel();

  TenderModel.of(
      this.account_id, this.bid_number, this.bid_passwd, this.id_number);

  TenderModel.id(this.id, this.bid_number, this.bid_passwd, this.id_number);

  TenderModel.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        account_id = json["account_id"],
        bid_number = json["bid_number"],
        bid_passwd = json["bid_passwd"],
        id_number = json["id_number"],
        order_idx = json["order_idx"],
        phone = json["phone"],
        validDate = json["validDate"],
        state = json["state"],
        times = json["times"],
        is_default = json["is_default"],
        invite_code = json["invite_code"];

  Map<String, dynamic> toJson() => {
        'id': id,
        'account_id': account_id,
        'bid_number': bid_number,
        'bid_passwd': bid_passwd,
        'id_number': id_number,
        'order_idx': order_idx,
        'phone': phone,
        'validDate': validDate,
        'state': state,
        'times': times,
        'is_default': is_default,
        'invite_code': invite_code,
      };
}
