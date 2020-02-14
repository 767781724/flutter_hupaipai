import 'dart:convert';

class BaseSocketResp {
  String cmd;
  int resCode;
  dynamic data;

  BaseSocketResp({this.cmd, this.resCode, this.data});

  BaseSocketResp.fromJson(Map<String, dynamic> _json) {
    this.cmd = _json['cmd']??'all';
    this.resCode = _json['resCode']??200;
    this.data = _json['data'] != null ? json.decode(_json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
//    data['cmd'] = this.cmd;
    data['resCode'] = this.resCode;
    data['data'] = this.data;
    return data;
  }

}
