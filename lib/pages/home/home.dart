import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:hupaipai/http/web_socket.dart';
import 'package:hupaipai/models/base_socket_resp.dart';
import 'package:hupaipai/provides/ws_provide.dart';
import 'package:hupaipai/route/app_router.dart';
import 'package:hupaipai/utils/screen_util.dart';
import 'package:hupaipai/widgets/my_card.dart';
import 'package:provider/provider.dart';
import 'my_dialog.dart';

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
      Provider.of<Socket>(context).connect();
      _socket = Provider.of<Socket>(context, listen: false);

      _socket?.on(WebSocketCmd.wsAll, infoListListener);
    });

  }
  infoListListener(data){
    WsBloc ws=Provider.of<WsBloc>(context);
    ws.pushInfo(data);
  }
  @override
  Widget _tabBox(String path, String name, GestureTapCallback _onTap, [Color colors]) {
    final _style = TextStyle(color: Colors.white, fontSize: setSp(15));
    return InkWell(
      onTap: _onTap,
      child: Container(
        width: setW(80),
        height: setW(60),
        child: Column(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(bottom: setW(12)),
                child: Image.asset(
                  'assets/images/${path}.png',
                  width: setW(30),
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
    return Scaffold(
        appBar: AppBar(title: Text('首页')),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: setW(16), right: setW(16)),
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: setW(16)),
                  child: ListTile(
                    onTap: (){
                      AppRouter.navigateTo(context, Routes.accountPage);
                    },
                    contentPadding: EdgeInsets.all(0),
                    leading:  SizedBox(
                      width: setW(48),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(setW(24))),
                        child: CachedNetworkImage(
                          width: setW(48),
                          fit: BoxFit.fitWidth,
                          imageUrl: "http://cdn.duitang.com/uploads/blog/201404/22/20140422142715_8GtUk.thumb.600_0.jpeg",
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
                        Text('刘明星', style: TextStyle(fontSize: setSp(22), fontWeight: FontWeight.bold)),
                        Text(
                          '5月27日，星期一',
                          style: TextStyle(color: Color(0xff999999)),
                        )
                      ],
                    ),
                    trailing: Image.asset('assets/images/home-icon0.png',width: setW(25),fit: BoxFit.fitWidth,),
                  ),
                ),
                MyCard(
                  password: '99888',
                  status: '待拍/中标',
                  tactics: '比较激进策略',
                  id: '320182028948048411',
                  btn: SizedBox(
                    width: setW(90),
                    height: setW(34),
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
                  margin: EdgeInsets.only(top: setW(25)),
                  child: Wrap(
                    spacing: setW(5), // 主轴(水平)方向间距
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
                    margin: EdgeInsets.only(top: setW(30)),
                    alignment: Alignment.centerLeft,
                    child: Text('快报', style: TextStyle(fontSize: setSp(22), fontWeight: FontWeight.bold))),
                Container(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: SizedBox(
                        height: setW(58),
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
                        width: setW(94),
                        height: setW(68),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(setW(8)),
                          child: CachedNetworkImage(
                            fit: BoxFit.fitWidth,
                            imageUrl:
                                "http://cdn.duitang.com/uploads/blog/201404/22/20140422142715_8GtUk.thumb.600_0.jpeg",
                            placeholder: (context, url) => Image.asset(
                            'assets/images/img_loading.png',
                            width: setW(94),
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
                    margin: EdgeInsets.only(top: setW(30)),
                    alignment: Alignment.centerLeft,
                    child: Text('功能', style: TextStyle(fontSize: setSp(22), fontWeight: FontWeight.bold))),
                Container(
                  margin: EdgeInsets.only(top: setW(25),bottom: setW(30)),
                  child: Wrap(
                    spacing: setW(5), // 主轴(水平)方向间距
                    runSpacing: setW(8),
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
