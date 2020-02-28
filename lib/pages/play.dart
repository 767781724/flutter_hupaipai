import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:hupaipai/utils/screen_util.dart';
import 'package:hupaipai/utils/log_util.dart';

class PlayPage extends StatefulWidget {
  @override
  _PlayPageState createState() => _PlayPageState();
}

class _PlayPageState extends State<PlayPage> with ScreenUtil , TickerProviderStateMixin{
  List dataList = [1,2,3,1,2,3,1,2,3];
  ScrollController _listController = ScrollController();
  TextEditingController _controller = TextEditingController();
  AnimationController _anicontroller;
  Animation _animation;


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

  }

  @override
  Widget _ColBox(int type) {
    TextStyle _style = TextStyle(fontSize: setSp(14), color: Color(0xff999999));
    switch (type) {
      case 1:
        return Container(
          margin: EdgeInsets.only(bottom: setWidth(15)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '王二 11:30:43',
                style: _style,
              ),
              Container(
                margin: EdgeInsets.only(top: setWidth(5)),
                child: CachedNetworkImage(
                  fit: BoxFit.fitWidth,
                  width: setWidth(180),
                  imageUrl: "http://cdn.duitang.com/uploads/blog/201404/22/20140422142715_8GtUk.thumb.600_0.jpeg",
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ],
          ),
        );
        break;
      case 2:
        return Container(
          margin: EdgeInsets.only(bottom: setWidth(15)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                '王二 11:30:43',
                style: _style,
              ),
              Container(
                padding: EdgeInsets.all(setWidth(8)),
                margin: EdgeInsets.only(top: setWidth(5)),
                decoration: BoxDecoration(color: Color(0xFF1CCAD6), borderRadius: BorderRadius.all(Radius.circular(4))),
                child: Text(
                  '80233',
                  style: TextStyle(fontSize: setSp(18), color: Colors.white),
                ),
              )
            ],
          ),
        );
        break;
      case 3:
        return Container(
          margin: EdgeInsets.only(bottom: setWidth(15)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '王二 11:30:43',
                style: _style,
              ),
              Container(
                padding: EdgeInsets.all(setWidth(8)),
                margin: EdgeInsets.only(top: setWidth(5)),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(4))),
                child: Text(
                  '80233',
                  style: TextStyle(fontSize: setSp(18), color: Colors.black87),
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
    _anicontroller =AnimationController(duration: const Duration(seconds: 2),vsync: this);
    _animation = Tween(
      begin: 0.0,
      end: 0.8,
    ).animate(_anicontroller);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _listController.dispose();
    _anicontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _anicontroller.forward();
    return Scaffold(
      appBar: AppBar(
          title: Text.rich(TextSpan(children: [
        TextSpan(text: "拍牌打码·", style: TextStyle(fontSize: setSp(18), color: Color(0xff333333))),
        TextSpan(
          text: "Ping38",
          style: TextStyle(color: Color(0xFF1CCAD6), fontSize: setSp(12)),
        ),
      ]))),
      backgroundColor: Color(0xFFF6F6F6),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Stack(
          children:<Widget>[ SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(setWidth(15)),
                  color: Color(0xFFEDEDED),
                  height: screenHeightDp - statusBarHeight - bottomBarHeight - 100,
                  child: ListView.builder(
                      controller: _listController,
                      itemCount: dataList.length,
                      reverse: true,
                      itemBuilder: (BuildContext context, int index) {
                        return _ColBox(dataList[index]);
                      }),
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
                        decoration:
                            BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(4))),
                        child: TextField(
                          controller: _controller,
                          autofocus: false,
                          keyboardType: TextInputType.numberWithOptions(signed: true),
                          textInputAction: TextInputAction.done,
                          textAlign: TextAlign.start,
                          onSubmitted: (value) {
                            LogUtil.i(value);
                          },
                          decoration: InputDecoration(
                            hintStyle:
                                TextStyle(fontSize: setSp(15), color: Color(0xFFCCCCCC), fontWeight: FontWeight.bold),
                            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white30)),
                            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white30)),
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
                      IconButton(icon: Icon(Icons.reply), onPressed: null)
                    ],
                  ),
                )
              ],
            ),
          ),
            Positioned(
                top: 0,
                left: 0,
                child: FadeTransition(
                    opacity: _animation,
                    child: Container(
                      width: setWidth(375),
                      height: setWidth(52),
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('第三次拍牌5秒后开始，请准备18:20:30',style: TextStyle(fontSize: setSp(12),color: Color(0xff999999)),),
                          Text('投标公示阶段11:30:00',style: TextStyle(fontSize: setSp(12),color: Color(0xff999999)),)
                        ],
                      ),
                    )
                )
            )
          ]
        ),
      ),
    );
  }
}
