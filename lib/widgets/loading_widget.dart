import 'package:flutter/material.dart';
import 'package:hupaipai/utils/screen_util.dart';

showLoading(BuildContext context, {text = "加载中..."}) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return LoadingWidget(text: text);
      });
}

class LoadingWidget extends StatelessWidget with ScreenUtil {
  String text;

  LoadingWidget({@required this.text});

  @override
  Widget build(BuildContext context) {
    return new Material(
      //创建透明层
      type: MaterialType.transparency, //透明类型
      child: Center(
          //保证控件居中效果
          child: SizedBox(
              width: setWidth(180),
              height: setWidth(180),
              child: Container(
                  decoration: ShapeDecoration(
                      color: Color(0xffffffff),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                        Radius.circular(setWidth(8)),
                      ))),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        CircularProgressIndicator(),
                        Padding(
                            padding: EdgeInsets.only(
                              top: setWidth(20),
                            ),
                            child: Text(
                              text,
                              style: TextStyle(fontSize: setSp(22)),
                            ))
                      ])))),
    );
  }
}
