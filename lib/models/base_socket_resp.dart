import 'dart:convert';

class BaseSocketResp {
  dynamic data;

  BaseSocketResp({this.data});

  BaseSocketResp.fromJson(Map<String, dynamic> _json) {
    this.data = _json['data'] != null ? json.decode(_json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data'] = this.data;
    return data;
  }
}
