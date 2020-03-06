import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:hupaipai/utils/screen_util.dart';
import 'package:common_utils/common_utils.dart' as common_utils;

class TacitcsSettingPage extends StatefulWidget {
  @override
  _TacitcsSettingPageState createState() => _TacitcsSettingPageState();
}

class _TacitcsSettingPageState extends State<TacitcsSettingPage> with ScreenUtil {
  TextEditingController _nameController;
  List<Map> datas = [
    {'stateTime': '11:11:12', 'endTime': '11:11:12', 'type': 0,'price':TextEditingController()},
    {'stateTime': '11:11:12', 'endTime': '11:11:12', 'type': 0,'price':TextEditingController()}
  ];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    datas[0]['price'].dispose();
    datas[1]['price'].dispose();
  }

  Widget name() {
    return Container(
      decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1, color: Color(0xFFEAEAEA)))),
      child: Row(children: <Widget>[
        Text('策略名称', style: TextStyle(fontSize: setSp(18), color: Color(0xff333333), fontWeight: FontWeight.bold)),
        Expanded(
          child: TextField(
            controller: _nameController,
            autofocus: false,
            textAlign: TextAlign.end,
            decoration: InputDecoration(
              hintText: '请输入名称',
              hintStyle: TextStyle(fontSize: setSp(15), color: Color(0xFFCCCCCC), fontWeight: FontWeight.bold),
              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white30)),
              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white30)),
            ),
          ),
        ),
      ]),
    );
  }
  _showTimePicker(String key,int index){
    DatePicker.showDateTimePicker(context, showTitleActions: true,currentTime: DateTime.now(),
        locale: LocaleType.zh,
        onConfirm: (date) {
          setState(() {
            datas[index][key]= common_utils.DateUtil.formatDate(date);
          });
        },theme: DatePickerTheme(
          doneStyle: TextStyle(color:  Color(0xFF1CCAD6)),
        ));
  }
  Widget _cardBox(int index){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: setWidth(15), bottom: setWidth(15)),
          child: Text(
            index==0?'方式A':'方式B',
            style: TextStyle(fontSize: setSp(16), color: Color(0xff333333), fontWeight: FontWeight.bold),
          ),
        ),
        ListTile(
          contentPadding: EdgeInsets.all(0),
          leading: Text(
            '触发时间',
            style: TextStyle(fontSize: setSp(15), color: Color(0xff333333)),
          ),
          title: Align(
            alignment: Alignment.centerRight,
            child:
            Text(datas[index]['stateTime'], style: TextStyle(fontSize: setSp(15), color: Color(0xff333333))),
          ),
          trailing: Icon(Icons.keyboard_arrow_down),
          onTap: () {
            _showTimePicker('stateTime',index);
          },
        ),
        Divider(),
        ListTile(
          contentPadding: EdgeInsets.all(0),
          leading: Text(
            '强制出价',
            style: TextStyle(fontSize: setSp(15), color: Color(0xff333333)),
          ),
          title: Align(
            alignment: Alignment.centerRight,
            child:
            Text(datas[index]['endTime'], style: TextStyle(fontSize: setSp(15), color: Color(0xff333333))),
          ),
          trailing: Icon(Icons.keyboard_arrow_down),
          onTap: () {
            _showTimePicker('endTime',index);
          },
        ),
        Divider(),
        ListTile(
          contentPadding: EdgeInsets.all(0),
          leading: Text(
            '增量价格',
            style: TextStyle(fontSize: setSp(15), color: Color(0xff333333)),
          ),
          title: Align(
            alignment: Alignment.centerRight,
            child:TextField(
              controller: datas[index]['price'],
              autofocus: false,
              textAlign: TextAlign.end,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: '请输入价格',
                hintStyle: TextStyle(fontSize: setSp(15), color: Color(0xFFCCCCCC), fontWeight: FontWeight.bold),
                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white30)),
                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white30)),
              ),
            ),
          ),
          onTap: (){
            setState(() {datas[index]['type']=0;});
          },
          trailing: CircleAvatar(
            radius: setWidth(10),
            backgroundColor: Color(0xFF1CCAD6),
            child: CircleAvatar(
              radius: setWidth(9),
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: setWidth(5),
                backgroundColor: datas[index]['type']==0?Color(0xFF1CCAD6):Colors.white,
              ),
            ),
          ),
        ),
        Divider(),
        ListTile(
          contentPadding: EdgeInsets.all(0),
          leading: Text(
            '固定价格',
            style: TextStyle(fontSize: setSp(15), color: Color(0xff333333)),
          ),
          title: Align(
            alignment: Alignment.centerRight,
            child:
            Text('8500', style: TextStyle(fontSize: setSp(15), color: Color(0xff333333))),
          ),
          onTap: (){
            setState(() {datas[index]['type']=1;});
          },
          trailing:  CircleAvatar(
            radius: setWidth(10),
            backgroundColor: Color(0xFF1CCAD6),
            child: CircleAvatar(
              radius: setWidth(9),
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: setWidth(5),
                backgroundColor: datas[index]['type']==1?Color(0xFF1CCAD6):Colors.white,
              ),
            ),
          ),
        ),
        Divider(),
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('策略设置'),
      ),
      body: SingleChildScrollView(
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: Padding(
            padding: EdgeInsets.all(setWidth(15)),
            child: Column(
              children: <Widget>[
                name(),
                _cardBox(0),
                _cardBox(1),
              ],
            ),
          ),
        ),
      ),
      persistentFooterButtons: <Widget>[
        Container(
          width: setWidth(327),
          height: setWidth(42),
          margin: EdgeInsets.only(right: setWidth(15)),
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
    );
  }
}
