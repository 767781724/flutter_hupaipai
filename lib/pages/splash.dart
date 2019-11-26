import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hupaipai/route/app_router.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Timer _timer;
  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(milliseconds: 500), (timer) {
      AppRouter.navigateTo(context, Routes.loginPage,replace: true,transition: TransitionType.fadeIn);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
    _timer=null;
  }
  @override
  Widget build(BuildContext context) {

    ScreenUtil.instance = ScreenUtil(width: 375, height: 812)..init(context);
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.white,
      alignment: Alignment.center,
      child: Text('启动页',style: TextStyle(color: Colors.black,decoration: TextDecoration.none),),
    );
  }
}
