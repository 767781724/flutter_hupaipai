import 'package:flutter/material.dart';
import 'package:hupaipai/utils/screen_util.dart';

class TenderSettingPage extends StatefulWidget {
  @override
  _TenderSettingPageState createState() => _TenderSettingPageState();
}

class _TenderSettingPageState extends State<TenderSettingPage> with ScreenUtil{
  TextEditingController _code=TextEditingController();
  TextEditingController _password=TextEditingController();
  TextEditingController _id=TextEditingController();



  Widget _Input(String lable,TextEditingController controller,String hint) {
    return Container(
      decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1, color: Color(0xFFEAEAEA)))),
      margin: EdgeInsets.only(bottom: setW(10)),
      child: Row(children: <Widget>[
        Text(lable, style: TextStyle(fontSize: setSp(15), color: Color(0xff333333))),
        Expanded(
          child: TextField(
            controller: controller,
            autofocus: false,
            textAlign: TextAlign.end,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(fontSize: setSp(15), color: Color(0xFFCCCCCC), fontWeight: FontWeight.bold),
              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white30)),
              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white30)),
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
        title: Text('标书编辑'),
      ),
      body: Padding(
        padding: EdgeInsets.all(setW(15)),
        child: Column(
          children: <Widget>[
            _Input('标书编号', _code, '请输入标书编号'),
            _Input('标书密码', _password, '请输入标书密码'),
            _Input('身份证', _id, '请输入身份证号'),
            Container(
              width: setW(327),
              height: setW(42),
              margin: EdgeInsets.only(top: setW(15)),
              child: FlatButton(
                  color: Color(0xFF1CCAD6),
                  highlightColor: Color(0xFF1CCAD6),
                  colorBrightness: Brightness.dark,
                  splashColor: Colors.grey,
                  onPressed: () {},
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                  child: Text(
                    '确认',
                    style: TextStyle(fontSize: setSp(15), color: Colors.white),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
