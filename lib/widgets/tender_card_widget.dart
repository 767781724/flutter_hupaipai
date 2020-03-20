import 'package:flutter/material.dart';
import 'package:hupaipai/utils/screen_util.dart';

class TenderCardWidget extends StatelessWidget with ScreenUtil {
  final String bidNumber, password, status, tactics, id;
  final int is_default;
  final Widget btn; //右边按钮自定义
  final bool payment; //是否显示缴费按钮

  TenderCardWidget(
      {Key key,
      this.bidNumber,
      this.password,
      this.status,
      this.tactics,
      this.id,
      this.is_default,
      this.btn,
      this.payment: false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _style = TextStyle(color: Colors.white, fontSize: setSp(14));
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: setWidth(27)),
      padding: EdgeInsets.all(setWidth(16)),
      decoration: BoxDecoration(
          color: Color(0xff1CCAD6),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                bidNumber,
                style: TextStyle(
                    fontSize: setSp(22),
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              this.btn ?? Container()
            ],
          ),
          Table(
            children: <TableRow>[
              TableRow(children: [
                TableCell(
                  child: Padding(
                      padding: EdgeInsets.only(
                          top: setWidth(20), bottom: setWidth(5)),
                      child: Text('标书密码', style: _style)),
                ),
                TableCell(
                  child: Padding(
                      padding: EdgeInsets.only(
                          top: setWidth(20), bottom: setWidth(5)),
                      child: Text('标书状态', style: _style)),
                ),
              ]),
              TableRow(children: [
                TableCell(
                  child: Text(this.password, style: _style),
                ),
                TableCell(
                  child: Row(
                    children: <Widget>[
                      Text(this.status, style: _style),
                      !this.payment
                          ? Container()
                          : Container(
                              width: setWidth(40),
                              height: setWidth(18),
                              margin: EdgeInsets.only(left: setWidth(20)),
                              child: OutlineButton(
                                padding: EdgeInsets.all(0),
                                disabledBorderColor: Colors.white,
                                highlightedBorderColor: Colors.white,
                                splashColor: Colors.transparent,
                                highlightColor: Colors.white,
                                borderSide: BorderSide(color: Colors.white),
                                child: Text(
                                  '缴费',
                                  style: TextStyle(
                                      fontSize: setSp(11), color: Colors.white),
                                ),
                              ),
                            )
                    ],
                  ),
                ),
              ]),
              TableRow(children: [
                Container(
                  child: TableCell(
                    child: Padding(
                        padding: EdgeInsets.only(
                            top: setWidth(20), bottom: setWidth(5)),
                        child: Text('策略', style: _style)),
                  ),
                ),
                TableCell(
                  child: Padding(
                      padding: EdgeInsets.only(
                          top: setWidth(20), bottom: setWidth(5)),
                      child: Text('身份证号码', style: _style)),
                ),
              ]),
              TableRow(children: [
                TableCell(
                  child: Text(this.tactics, style: _style),
                ),
                TableCell(
                  child: Text(this.id, style: _style),
                ),
              ]),
            ],
          ),
        ],
      ),
    );
  }
}
