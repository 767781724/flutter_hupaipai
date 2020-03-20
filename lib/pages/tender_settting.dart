import 'package:flutter/material.dart';
import 'package:hupaipai/net/service_api.dart';
import 'package:hupaipai/models/tender_model.dart';
import 'package:hupaipai/store/user_notifier.dart';
import 'package:hupaipai/route/app_router.dart';
import 'package:hupaipai/utils/log_util.dart';
import 'package:hupaipai/utils/screen_util.dart';

class TenderSettingPage extends StatefulWidget {
  TenderModel tenderModel;

  TenderSettingPage(Map<String, List<String>> params) {
    var tenderJson = params["tenderModel"]?.first;
    if (tenderJson != null) {
      tenderModel = TenderModel.fromJson(AppRouter.jsonUtf8Decode(tenderJson));
    }
  }

  @override
  _TenderSettingPageState createState() => _TenderSettingPageState();
}

class _TenderSettingPageState extends State<TenderSettingPage> with ScreenUtil {
  TextEditingController _code = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _id = TextEditingController();

  Widget _Input(String lable, TextEditingController controller, String hint,
      String value, int maxLen) {
    controller.text = value;
    return Container(
      decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(width: 1, color: Color(0xFFEAEAEA)))),
      margin: EdgeInsets.only(bottom: setWidth(10)),
      child: Row(children: <Widget>[
        Text(lable,
            style: TextStyle(fontSize: setSp(15), color: Color(0xff333333))),
        Expanded(
          child: TextField(
            controller: controller,
            maxLength: maxLen,
            autofocus: false,
            textAlign: TextAlign.end,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                  fontSize: setSp(15),
                  color: Color(0xFFCCCCCC),
                  fontWeight: FontWeight.bold),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white30)),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white30)),
            ),
          ),
        ),
      ]),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _code.dispose();
    _password.dispose();
    _id.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            widget.tenderModel.bid_number == null ? Text('增加标书') : Text('标书编辑'),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(setWidth(15)),
          child: Column(
            children: <Widget>[
              _Input('标书编号', _code, '请输入标书编号',
                  widget.tenderModel.bid_number ?? '', 8),
              _Input('标书密码', _password, '请输入标书密码',
                  widget.tenderModel.bid_passwd ?? '', 4),
              _Input('身份证', _id, '请输入身份证号', widget.tenderModel.id_number ?? '',
                  18),
              Container(
                width: setWidth(327),
                height: setWidth(42),
                margin: EdgeInsets.only(top: setWidth(15)),
                child: FlatButton(
                    color: Color(0xFF1CCAD6),
                    highlightColor: Color(0xFF1CCAD6),
                    colorBrightness: Brightness.dark,
                    splashColor: Colors.grey,
                    onPressed: () {
                      if (widget.tenderModel.bid_number == null) {
                        var tenderModel = TenderModel.of(
                            UserNotifier.userModel.id,
                            _code.text,
                            _password.text,
                            _id.text);
                        ServiceApi().addTender(context, tenderModel).then((_) {
                          LogUtil.i("增加标书成功");
                          Navigator.pop(context);
                        });
                      } else {
                        var tenderModel = TenderModel.id(widget.tenderModel.id,
                            _code.text, _password.text, _id.text);
                        ServiceApi()
                            .updateTender(context, tenderModel)
                            .then((_) {
                          LogUtil.i("更新标书成功");
                          Navigator.pop(context);
                        });
                      }
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6)),
                    child: Text(
                      '确认',
                      style:
                          TextStyle(fontSize: setSp(15), color: Colors.white),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
