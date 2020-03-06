class TenderModel {
  String bid_number;
  String bid_passwd;
  String id_number;
  String order_idx;
  String phone;
  String validDate;

  TenderModel.fromJson(Map<String, dynamic> json)
      : bid_number = json["bid_number"],
        bid_passwd = json["bid_passwd"],
        id_number = json["id_number"],
        order_idx = json["order_idx"],
        phone = json["phone"],
        validDate = json["validDate"];

  Map<String, dynamic> toJson() => {
        'bid_number': bid_number,
        'bid_passwd': bid_passwd,
        'id_number': id_number,
        'order_idx': order_idx,
        'phone': phone,
        'validDate': validDate,
      };
}
