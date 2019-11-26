import 'package:flutter/material.dart';
import 'package:hupaipai/route/app_router.dart';
import 'package:hupaipai/utils/screen_util.dart';
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with ScreenUtil {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
//        title: Text('登录'),
//      ),
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        child:SizedBox(
          width: setW(327),
          height: setW(42),
          child: OutlineButton(
            disabledBorderColor: Color(0xff0AC161),
            highlightedBorderColor:Color(0xff0AC161),
            splashColor: Colors.transparent,
            highlightColor:Color(0x100AC161),
            borderSide: BorderSide(color: Color(0xff0AC161)),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset('assets/images/login-weixin.png',width: setW(30),fit: BoxFit.fitWidth,),
                Text('微信登录',style: TextStyle(color: Color(0xff0AC161),fontSize: setSp(18),fontWeight: FontWeight.w400))
              ],
            ),
            onPressed: (){
              AppRouter.navigateTo(context, Routes.homePage,replace: true);
            },
          ),
        )
      ),
    );
  }
}