import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:hupaipai/route/app_router.dart';
import 'package:hupaipai/utils/screen_util.dart';
import 'package:hupaipai/store/user_notifier.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with ScreenUtil {
  Timer _timer;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Timer(Duration(milliseconds: 1500), () {
        bool isLogin = UserNotifier.isLogin();
        if (isLogin) {
          AppRouter.navigateTo(context, Routes.homePage,
              replace: true, transition: TransitionType.fadeIn);
        } else {
          AppRouter.navigateTo(context, Routes.wechatLoginPage,
              replace: true, transition: TransitionType.fadeIn);
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
    _timer = null;
  }

  @override
  Widget build(BuildContext context) {
    initScreenUtil(context, width: 375, height: 812);
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        alignment: Alignment.bottomCenter,
        padding: EdgeInsets.only(bottom: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Image.asset(
              'assets/images/logo.png',
              width: 50,
              fit: BoxFit.fitWidth,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '智慧云拍牌',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Text(
              '一个专业高效便捷的沪牌拍牌平台',
              style: TextStyle(fontSize: 12, color: Colors.black38),
            )
          ],
        ),
      ),
    );
  }
}
