import 'package:hupaipai/utils/log_util.dart';
import 'net_utils.dart';

class ServiceApi{
  static final ServiceApi instance = ServiceApi._internal();

  factory ServiceApi() => instance;

  ServiceApi._internal();

  Future getWxLogin(String code) async {
    var request = await NetUtils().request("auth/wechat", data: {"code": code});
    LogUtil.i('${request}');
    return request;
  }
}