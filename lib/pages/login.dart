import 'package:flutter/material.dart';
import 'package:hupaipai/http/service_api.dart';
import 'package:hupaipai/models/user_model.dart';
import 'package:hupaipai/route/app_router.dart';
import 'package:hupaipai/utils/screen_util.dart';
import 'package:fluwx/fluwx.dart' as fluwx;
import 'package:hupaipai/utils/log_util.dart';
import 'package:provider/provider.dart';
import 'package:hupaipai/provides/application_provide.dart';
import 'package:hupaipai/utils/toast_util.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with ScreenUtil {


  @override
  void initState() {
    super.initState();
    fluwx.responseFromAuth.listen((data) {
      ServiceApi().wxLogin(context, data.code).then((UserModel userModel){
        Provider.of<Application>(context).saveUserModel(userModel).then((_) {
          AppRouter.navigateTo(context, Routes.homePage,replace: true);
        });
      }).catchError((err){
        LogUtil.i(err);
        ToastUtil.show(err.toString());
      });
    });
  }

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
          width: setWidth(327),
          height: setWidth(42),
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
                Image.asset('assets/images/login-weixin.png',width: setWidth(30),fit: BoxFit.fitWidth,),
                Text('微信登录',style: TextStyle(color: Color(0xff0AC161),fontSize: setSp(18),fontWeight: FontWeight.w400))
              ],
            ),
            onPressed: (){
              fluwx.sendWeChatAuth(scope: "snsapi_userinfo",state: "wx_login_hupaipai").then((val){
                if(!val){
                  LogUtil.i(val);
                }

              });

            },
          ),
        )
      ),
    );
  }
}
