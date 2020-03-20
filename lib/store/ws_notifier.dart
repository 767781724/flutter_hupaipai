import 'package:flutter/material.dart';
import 'package:hupaipai/models/tender_model.dart';
import 'package:hupaipai/utils/log_util.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:common_utils/common_utils.dart' as common_utils;

class WsNotifier with ChangeNotifier {
  static final WsNotifier instance = WsNotifier._internal();
  factory WsNotifier() => instance;
  WsNotifier._internal();

  List<Map> _superviseData = [];
  List<Map> _verifyData = [];
  String _verifyMsgId;
  TenderModel _defaultTenderModel;

  List<Map> get VerifyData => _verifyData;
  List<Map> get SuperviseData => _superviseData;
  String get VerifyMsgId => _verifyMsgId;

  TenderModel get defaultTenderModel => _defaultTenderModel;
  void set defaultTenderModel(TenderModel tenderModel) {
    _defaultTenderModel = tenderModel;
  }

//  data_dict = {
//  "type": 'supervise',
//  "bsh": bid_number,
//  "msgid": str(uuid.uuid4()),
//  "msgtime": int(round(time.time() * 1000)),
//  "action": {
//  "msg": msg,
//  "bsh": bid_number,
//  "pic": ppconst.OSS_IMAGE_SHOT_URL % (bid_number, time_str)
//  }
//  }

  void _onSupervise(data) {
    _superviseData.add(data);
    notifyListeners();
  }
  //  data_dict = {
//  "type": 'verify',
//  "uuid": bid_number,
//  "username": id_number,
//  "wait": wait,
//  "action": {
//  "msgid": msgid,
//  "msg": mword,
//  "pic": ppconst.OSS_IMAGE_CODE_URL % (bid_number, msgid),
//  "bsh": bid_number
//  }
//  }
  void _onVerify(data, type) {
    if (type == 1) {
      _verifyMsgId = data['action']['msgid'];
    }
    _verifyData.add(data);
    notifyListeners();
  }

  //插入信息
  void pushInfo(data) {
    LogUtil.i('type ====> ${data['type']}');
    switch (data['type']) {
      case 'verify':
        _onVerify(data, 1);
        break;
      case 'code':
        _onVerify(data, 2);
        break;
      case 'supervise':
        _onSupervise(data);
        break;
      case 'codelogin':
        showSimpleNotification(Text("登录成功， 开不开心"), background: Colors.orange);
        LogUtil.i('登录成功');
        break;
      case 'status': //
        String title;
        switch (data['name']) {
          case 'wait':
            title = '初始化标书阶段';
            break;
          case 'first':
            title = '首次出价阶段';
            break;
          case 'next':
            title = '竞争出价阶段';
            break;
          case 'result':
            title = '投标公示阶段';
            break;
          default:
            break;
        }
        var time = common_utils.DateUtil.formatDate(DateTime.now(), format: 'HH:mm:ss');
        showSimpleNotification(Text('$time - $title'), background: Colors.blue);
        break;
      case 'readybid':
        var time = common_utils.DateUtil.formatDate(DateTime.now(), format: 'HH:mm:ss');
        showSimpleNotification(Text('$time - ${data['name']}'), background: Colors.red);
        break;
      case 'bid':
        var time = common_utils.DateUtil.formatDate(DateTime.now(), format: 'HH:mm:ss');
        showSimpleNotification(Text('$time - 第${data['round']}轮出价${data['price']}元'), background: Colors.pinkAccent);
        break;
      case 'result':
        String title = '没有中标';
        if (data['name'] == 'success') {
          title = '成功中标';
        }
        var time = common_utils.DateUtil.formatDate(DateTime.now(), format: 'HH:mm:ss');
        showSimpleNotification(Text('$time - 标书${data['uuid']}$title'), background: Colors.green);
        break;
      default:
        break;
    }
  }
}
