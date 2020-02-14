import 'package:flutter/material.dart';
import 'package:hupaipai/utils/screen_util.dart';

class MyDialog extends Dialog with ScreenUtil{
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          color: Colors.white,
          width: setW(330),
          height: setW(380),
          padding: EdgeInsets.all(setW(17)),
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                    child: Icon(Icons.close,color: Color(0xff666666),)
                )
              ),
              Container(
                width: setW(110),
                height: setW(110),
                decoration: BoxDecoration(
                  color: Color(0xFF1CCAD6),
                  borderRadius: BorderRadius.all(Radius.circular(setW(55))),
                ),
                child: Image.asset('assets/images/home-alert.png',width: setW(110),fit: BoxFit.fitWidth,),
              ),
              Padding(
                padding: EdgeInsets.only(top: setW(20)),
                child: Text('2019年9月21日, 拍牌预约',style: TextStyle(fontSize: setSp(18),color: Color(0xff333333))),
              ),
              Padding(
                padding: EdgeInsets.only(top: setW(16)),
                child: Text('支付10元',style: TextStyle(fontSize: setSp(18),color: Color(0xff333333))),
              ),
              Container(
                margin: EdgeInsets.only(top: setW(30)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(
                      width: setW(197),
                      height: setW(40),
                      child: FlatButton(
                          color: Color(0xFF1CCAD6),
                          highlightColor: Color(0xFF1CCAD6),
                          colorBrightness: Brightness.dark,
                          splashColor: Colors.grey,
                        onPressed: (){},
                        child: Text('分享立减7元',style: TextStyle(fontSize: setSp(15),color: Colors.white),)),
                    ),
                    SizedBox(
                      width: setW(84),
                      height: setW(40),
                      child: OutlineButton(
                        padding: EdgeInsets.all(0),
                        highlightedBorderColor: Color(0xFF1CCAD6),
                        splashColor: Colors.transparent,
                        highlightColor:Colors.transparent,
                          borderSide: BorderSide(color: Color(0xFF1CCAD6)),
                          onPressed: (){},
                        child: Text('立即支付',style: TextStyle(fontSize: setSp(15),color: Color(0xFF1CCAD6)),)
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: setW(28)),
                child: Text('预约服务费一经售出不支持退款',style: TextStyle(color: Color(0xff999999),fontSize: setSp(12)),),
              )
            ],
          ),
        ),
      ),
    );
  }
}