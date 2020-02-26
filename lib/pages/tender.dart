import 'package:flutter/material.dart';
import 'package:hupaipai/route/app_router.dart';
import 'package:hupaipai/utils/screen_util.dart';
import 'package:hupaipai/widgets/my_card.dart';

class TenderPage extends StatefulWidget {
  @override
  _TenderPageState createState() => _TenderPageState();
}

class _TenderPageState extends State<TenderPage> with ScreenUtil{
  Widget _ListBox(){
    return InkWell(
      onTap: (){
        AppRouter.navigateTo(context, Routes.tenderSettingPage);
      },
      child: Padding(
        padding:  EdgeInsets.only(left: setWidth(15),right: setWidth(15)),
        child: Column(
          children: <Widget>[
            MyCard(
              password: '7787',
              status: '待拍/中标',
              tactics: '比较激进策略',
              id:'3020203802811918',
              btn: SizedBox(
                width: setWidth(90),
                height: setWidth(34),
                child: FlatButton(
                  child: Text('设为默认',
                      style: TextStyle(color: Color(0xff1CCAD6), fontWeight: FontWeight.w400, fontSize: setSp(13))),
                  color: Colors.white,
                  highlightColor: Colors.white,
                  colorBrightness: Brightness.dark,
                  splashColor: Colors.grey,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                  onPressed: () {
                  },
                ),
              )),
            Padding(
              padding: EdgeInsets.only(top: setWidth(15)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    width: setWidth(80),
                    height: setWidth(30),
                    margin: EdgeInsets.only(right: setWidth(30)),
                    child: OutlineButton(
                      onPressed: (){},
                      padding: EdgeInsets.all(0),
                      highlightedBorderColor: Color(0xFF666666),
                      splashColor: Colors.transparent,
                      highlightColor:Colors.transparent,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                      borderSide: BorderSide(color: Color(0xFF666666)),
                      child: Text('设为过期',style: TextStyle(fontSize: setSp(12),color: Color(0xff333333)),),
                    ),
                  ),
                  SizedBox(
                    width: setWidth(80),
                    height: setWidth(30),
                    child: OutlineButton(
                      onPressed: (){},
                      padding: EdgeInsets.all(0),
                      highlightedBorderColor: Color(0xFF666666),
                      splashColor: Colors.transparent,
                      highlightColor:Colors.transparent,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                      borderSide: BorderSide(color: Color(0xFF666666)),
                      child: Text('删除',style: TextStyle(fontSize: setSp(12),color: Color(0xff333333))),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('全部标书'),
      ),
      body: ListView.builder(
          itemCount: 2,
          itemBuilder: (BuildContext context, int index) {
            return _ListBox();
          }),
    );
  }
}
