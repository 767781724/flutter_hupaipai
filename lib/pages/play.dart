import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:hupaipai/net/web_socket.dart';
import 'package:hupaipai/store/user_notifier.dart';
import 'package:hupaipai/store/ws_notifier.dart';
import 'package:hupaipai/utils/screen_util.dart';
import 'package:hupaipai/utils/log_util.dart';
import 'package:provider/provider.dart';
import 'package:common_utils/common_utils.dart' as common_utils;

class PlayPage extends StatefulWidget {
  @override
  _PlayPageState createState() => _PlayPageState();
}

class _PlayPageState extends State<PlayPage>
    with ScreenUtil, TickerProviderStateMixin {
  ScrollController _listController = ScrollController();
  TextEditingController _controller = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
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
//
//  const obj = {
////    type: 'code',
  ///   msgtime: "1584705766720"
////    uuid: this.props.store.openid,
////    openid: this.props.store.openid,
////    username: this.props.store.username,
////    bsh: this.props.store.bsh,
////    action: {
////      msg: message,
////      bsh: this.props.store.bsh,
////      msgid: this.props.store.msgid
////    }
////  };

  @override
  Widget _ColBox(Map data) {
    LogUtil.i('msgtime====>${data['type']}: ${data['msgtime']}');
    var timestamp = data['msgtime'];
    var time = common_utils.DateUtil.formatDate(DateTime.fromMillisecondsSinceEpoch(timestamp), format: 'HH:mm:ss');
    TextStyle _style = TextStyle(fontSize: setSp(14), color: Color(0xff999999));
    switch (data['type']) {
      case 'verify':
        var action = data['action'];
        return Container(
          margin: EdgeInsets.only(bottom: setWidth(15)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '${action['bsh']}@$time',
                style: _style,
              ),
              Text(
                action['msg'],
                style: _style,
              ),
              Container(
                margin: EdgeInsets.only(top: setWidth(5)),
                child: CachedNetworkImage(
                  fit: BoxFit.fitWidth,
                  width: setWidth(180),
                  imageUrl: action['pic'],
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ],
          ),
        );
        break;
      case 'code':
        var action = data['action'];
        return Container(
          margin: EdgeInsets.only(bottom: setWidth(15)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                '${data['username']}@$time',
                style: _style,
              ),
              Container(
                padding: EdgeInsets.all(setWidth(8)),
                margin: EdgeInsets.only(top: setWidth(5)),
                decoration: BoxDecoration(
                    color: Color(0xFF1CCAD6),
                    borderRadius: BorderRadius.all(Radius.circular(4))),
                child: Text(
                  action['msg'],
                  style: TextStyle(fontSize: setSp(18), color: Colors.white),
                ),
              )
            ],
          ),
        );
        break;
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _listController.dispose();
  }

//  const obj = {
//    type: 'code',
//    uuid: this.props.store.openid,
//    openid: this.props.store.openid,
//    username: this.props.store.username,
//    bsh: this.props.store.bsh,
//    action: {
//      msg: message,
//      bsh: this.props.store.bsh,
//      msgid: this.props.store.msgid
//    }
//  };
  void _sendMessage(String value) {
    var userModel = UserNotifier.userModel;
    var m = {
      "type": 'code',
      "uuid": userModel.unionid,
      "openid": userModel.unionid,
      "username": userModel.nickName,
      "bsh": WsNotifier().defaultTenderModel.bid_number,
      "action" : {
        "msg": value,
        "bsh": WsNotifier().defaultTenderModel.bid_number,
        "msgid": WsNotifier().VerifyMsgId,
      }
    };
    AppSocket.send(m);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text.rich(TextSpan(children: [
        TextSpan(
            text: "拍牌打码·",
            style: TextStyle(fontSize: setSp(18), color: Color(0xff333333))),
        TextSpan(
          text: "Ping38",
          style: TextStyle(color: Color(0xFF1CCAD6), fontSize: setSp(12)),
        ),
      ]))),
      backgroundColor: Color(0xFFF6F6F6),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.all(setWidth(15)),
                color: Color(0xFFEDEDED),
                child: Consumer<WsNotifier>(
                  builder: (conext, ws, child) {
                    if (ws.VerifyData.length > 0)
                      Timer(Duration(milliseconds: 500),
                              () => _listController.jumpTo(_listController.position.maxScrollExtent));
                    return ListView.builder(
                        controller: _listController,
                        itemCount: ws.VerifyData.length,
//                      reverse: true,
                        itemBuilder: (BuildContext context, int index) {
                          return _ColBox(ws.VerifyData[index]);
                        });
                  },
                ),
              ),
            ),
            Container(
              color: Color(0xFFF6F6F6),
              height: setWidth(52),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: setWidth(260),
                    height: setWidth(36),
                    margin: EdgeInsets.only(right: setWidth(10)),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    child: TextField(
                      controller: _controller,
                      autofocus: false,
                      keyboardType:
                      TextInputType.numberWithOptions(signed: true),
                      textInputAction: TextInputAction.done,
                      textAlign: TextAlign.start,
                      onSubmitted: (value) {
                        LogUtil.i(value);
                        _sendMessage(value);
                        value = '';
                      },
                      decoration: InputDecoration(
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
                  Container(
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.perm_identity),
                        Text('3'),
                      ],
                    ),
                  ),
                  IconButton(icon: Icon(Icons.reply), onPressed: () {
                    LogUtil.i(_controller.text);
                    _sendMessage(_controller.text);
                    _controller.text = "";
                  })
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
