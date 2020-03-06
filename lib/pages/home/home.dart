import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:hupaipai/http/web_socket.dart';
import 'package:hupaipai/models/user_model.dart';
import 'package:hupaipai/provides/application_provide.dart';
import 'package:hupaipai/provides/ws_provide.dart';
import 'package:hupaipai/route/app_router.dart';
import 'package:hupaipai/utils/screen_util.dart';
import 'package:hupaipai/widgets/my_card.dart';
import 'package:provider/provider.dart';
import 'package:hupaipai/pages/home/my_dialog.dart';
import 'package:common_utils/common_utils.dart' as common_utils;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with ScreenUtil {
  Socket _socket;
  @override
  void initState() {
    super.initState();
    //页面初始化完成 链接socket
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var userModel = Provider.of<Application>(context, listen: false).userModel;
      _socket = Provider.of<Socket>(context, listen: false);
      _socket.setBindCommand(
        {
          "uuid": userModel.token,
          "username": userModel.nickname,
          "openid": userModel.unionid,
          "type": "codelogin",
          "action": "codelogin"
        }
      );
      _socket.connect();
      _socket?.on(WebSocketCmd.wsAll, infoListListener);
    });

  }

  infoListListener(data){
    WsBloc ws=Provider.of<WsBloc>(context, listen: false);
    ws.pushInfo(data);
  }

  Widget _tabBox(String path, String name, GestureTapCallback _onTap, [Color colors]) {
    final _style = TextStyle(color: Colors.white, fontSize: setSp(15));
    return InkWell(
      onTap: _onTap,
      child: Container(
        width: setWidth(80),
        height: setWidth(60),
        child: Column(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(bottom: setWidth(12)),
                child: Image.asset(
                  'assets/images/${path}.png',
                  width: setWidth(30),
                  fit: BoxFit.fitWidth,
                )),
            Text(name, style: TextStyle(color: Color(0xff333333), fontSize: setSp(12)))
          ],
        ),
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    var userModel = Provider.of<Application>(context, listen: false).userModel;
    var now = DateTime.now();
    return Scaffold(
        appBar: AppBar(title: Text('智慧云拍牌')),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: setWidth(16), right: setWidth(16)),
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: setWidth(16)),
                  child: ListTile(
                    onTap: (){
                      AppRouter.navigateTo(context, Routes.accountPage);
                    },
                    contentPadding: EdgeInsets.all(0),
                    leading:  SizedBox(
                      width: setWidth(48),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(setWidth(24))),
                        child: CachedNetworkImage(
                          width: setWidth(48),
                          fit: BoxFit.fitWidth,
                          imageUrl: userModel.headimgurl,
                          placeholder: (context, url) => Image.asset(
                            'assets/images/img_loading.png',
                            fit: BoxFit.fitWidth,
                          ),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                        ),
                      ),
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(userModel.nickname, style: TextStyle(fontSize: setSp(22), fontWeight: FontWeight.bold)),
                        Text('${common_utils.DateUtil.formatDate(now, format: 'MM月dd日')}, ${common_utils.DateUtil.getZHWeekDay(now)}',
                          style: TextStyle(color: Color(0xff999999)),
                        )
                      ],
                    ),
                    trailing: Image.asset('assets/images/home-icon0.png',width: setWidth(25),fit: BoxFit.fitWidth,),
                  ),
                ),
                MyCard(
                  password: '99888',
                  status: '待拍/中标',
                  tactics: '比较激进策略',
                  id: '320182028948048411',
                  btn: SizedBox(
                    width: setWidth(90),
                    height: setWidth(34),
                    child: FlatButton(
                      child: Text('预约拍牌',
                          style: TextStyle(color: Color(0xff1CCAD6), fontWeight: FontWeight.w400, fontSize: setSp(13))),
                      color: Colors.white,
                      highlightColor: Colors.white,
                      colorBrightness: Brightness.dark,
                      splashColor: Colors.grey,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                      onPressed: () {
                        showDialog<Null>(
                            context: context, //BuildContext对象
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return MyDialog(//调用对话框
                                  );
                            });
                      },
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: setWidth(25)),
                  child: Wrap(
                    spacing: setWidth(5), // 主轴(水平)方向间距
                    runSpacing: 0,
                    children: <Widget>[
                      _tabBox('home-icon1', '实时监控', () {
                        AppRouter.navigateTo(context, Routes.monitorPage);
                      }, Color(0xff1CCAD6)),
                      _tabBox('home-icon2', '开始拍牌', () {
                        AppRouter.navigateTo(context, Routes.playPage);
                      }, Color(0xff1CCAD6)),
                      _tabBox('home-icon3', '拍牌策略', () {
                        AppRouter.navigateTo(context, Routes.tacticsPage);
                      }, Color(0xff1CCAD6)),
                      _tabBox('home-icon4', '全部标书', () {
                        AppRouter.navigateTo(context, Routes.tenderPage);
                      }, Color(0xff1CCAD6)),
                    ],
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(top: setWidth(30)),
                    alignment: Alignment.centerLeft,
                    child: Text('快报', style: TextStyle(fontSize: setSp(22), fontWeight: FontWeight.bold))),
                Container(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: SizedBox(
                        height: setWidth(58),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('2019年9月21日拍牌实况分析',
                                softWrap: false,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Color(0xff333333), fontSize: setSp(16), fontWeight: FontWeight.bold)),
                            Text(
                              '点赞 2999     浏览 8888',
                              style: TextStyle(color: Color(0xff333333), fontSize: setSp(14)),
                            )
                          ],
                        ),
                      )),
                      Container(
                        width: setWidth(94),
                        height: setWidth(68),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(setWidth(8)),
                          child: CachedNetworkImage(
                            fit: BoxFit.fitWidth,
                            imageUrl:
                                "http://cdn.duitang.com/uploads/blog/201404/22/20140422142715_8GtUk.thumb.600_0.jpeg",
                            placeholder: (context, url) => Image.asset(
                            'assets/images/img_loading.png',
                            width: setWidth(94),
                            fit: BoxFit.fitWidth,
                            ),
                            errorWidget: (context, url, error) => Icon(Icons.error),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(top: setWidth(30)),
                    alignment: Alignment.centerLeft,
                    child: Text('功能', style: TextStyle(fontSize: setSp(22), fontWeight: FontWeight.bold))),
                Container(
                  margin: EdgeInsets.only(top: setWidth(25),bottom: setWidth(30)),
                  child: Wrap(
                    spacing: setWidth(5), // 主轴(水平)方向间距
                    runSpacing: setWidth(8),
                    alignment: WrapAlignment.center,
                    children: <Widget>[
                      _tabBox('home-icon12', '分享邀请', () {}, Color(0xff333333)),
                      _tabBox('home-icon11', '拍牌历史', () {}),
                      _tabBox('home-icon5', '数据分析', () {}),
                      _tabBox('home-icon6', '拍牌联系', () {}),
                      _tabBox('home-icon10', '意见反馈', () {}),
                      _tabBox('home-icon9', '使用教程', () {}),
                      _tabBox('home-icon8', '常见问题', () {}),
                      _tabBox('home-icon7', '关于我们', () {}),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
