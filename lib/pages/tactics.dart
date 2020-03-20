import 'package:flutter/material.dart';
import 'package:hupaipai/route/app_router.dart';
import 'package:hupaipai/route/route.dart';
import 'package:hupaipai/utils/screen_util.dart';

class TacticsPage extends StatefulWidget {
  @override
  _TacticsPageState createState() => _TacticsPageState();
}

class _TacticsPageState extends State<TacticsPage> with ScreenUtil {
  Widget _ListBox() {
    final fontStyle = TextStyle(fontSize: setSp(12), color: Color(0xff333333));
    return Container(
      padding: EdgeInsets.all(setWidth(15)),
      child: Column(children: <Widget>[
        Padding(
          padding: EdgeInsets.only(bottom: setWidth(14)),
          child: Row(
            children: <Widget>[
              Container(
                width: setWidth(85),
                height: setWidth(85),
                margin: EdgeInsets.only(right: setWidth(20)),
                child: Image.asset(
                  'assets/images/tatics-icon1.png',
                  fit: BoxFit.fitWidth,
                ),
              ),
              Expanded(
                  child: SizedBox(
                height: setWidth(85),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '比较激进的策略',
                      style: TextStyle(
                          fontSize: setSp(18),
                          color: Color(0xff333333),
                          fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('方式A：+1200', style: fontStyle),
                        Text('定时：35秒', style: fontStyle),
                        Text('定时：45秒', style: fontStyle),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('方式B：+1200', style: fontStyle),
                        Text('定时：35秒', style: fontStyle),
                        Text('定时：45秒', style: fontStyle),
                      ],
                    )
                  ],
                ),
              ))
            ],
          ),
        ),
        Divider(),
        Padding(
          padding: EdgeInsets.only(top: setWidth(14)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                width: setWidth(80),
                height: setWidth(30),
                margin: EdgeInsets.only(right: setWidth(30)),
                child: OutlineButton(
                  onPressed: () {},
                  padding: EdgeInsets.all(0),
                  highlightedBorderColor: Color(0xFF666666),
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                  borderSide: BorderSide(color: Color(0xFF666666)),
                  child: Text(
                    '编辑',
                    style: TextStyle(
                        fontSize: setSp(12), color: Color(0xff333333)),
                  ),
                ),
              ),
              SizedBox(
                width: setWidth(80),
                height: setWidth(30),
                child: OutlineButton(
                  onPressed: () {},
                  padding: EdgeInsets.all(0),
                  highlightedBorderColor: Color(0xFF666666),
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                  borderSide: BorderSide(color: Color(0xFF666666)),
                  child: Text('删除',
                      style: TextStyle(
                          fontSize: setSp(12), color: Color(0xff333333))),
                ),
              )
            ],
          ),
        )
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('全部策略'),
      ),
      body: SafeArea(
        child: ListView.builder(
            itemCount: 2,
            itemBuilder: (BuildContext context, int index) {
              return _ListBox();
            }),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF1CCAD6),
        onPressed: () {
          AppRouter.navigateTo(context, Routes.tacticsSettingPage);
        },
        child: Icon(
          Icons.add,
          size: setWidth(30),
        ),
      ),
    );
  }
}
