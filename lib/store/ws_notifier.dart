import 'package:flutter/material.dart';
import 'package:hupaipai/utils/log_util.dart';
import 'package:overlay_support/overlay_support.dart';

class WsBloc with ChangeNotifier {
  static List<Map> _infoList = [];

  //插入信息
  static pushInfo(data) {
    LogUtil.i('action ====> ${data['action']}');
    LogUtil.i('type ====> ${data['type']}');
    switch (data['type']) {
      case 'verify':
        _infoList.add({'url': data['action']['pic'], 'mask': 0});
        break;
      case 'codelogin':
        showSimpleNotification(Text("登录成功， 开不开心"), background: Colors.green);
        LogUtil.i('登录成功');
        break;
      case 'status': //
        showSimpleNotification(Text("状态改变， 开不开心"), background: Colors.green);
        break;
      case 'readybid': //
        break;
      default:
        break;
    }
  }
}
