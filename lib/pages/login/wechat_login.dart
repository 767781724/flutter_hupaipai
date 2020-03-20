import 'package:flutter/material.dart';
import 'package:hupaipai/net/net_utils.dart';
import 'package:hupaipai/net/service_api.dart';
import 'package:hupaipai/models/token_model.dart';
import 'package:hupaipai/models/user_model.dart';
import 'package:hupaipai/utils/sp_util.dart';
import 'package:hupaipai/route/app_router.dart';
import 'package:hupaipai/utils/screen_util.dart';
import 'package:fluwx/fluwx.dart' as fluwx;
import 'package:hupaipai/utils/log_util.dart';
import 'package:provider/provider.dart';
import 'package:hupaipai/store/user_notifier.dart';
import 'package:hupaipai/utils/toast_util.dart';

class WechatLoginPage extends StatefulWidget {
  @override
  _WechatLoginPageState createState() => _WechatLoginPageState();
}

class _WechatLoginPageState extends State<WechatLoginPage> with ScreenUtil {
  @override
  void initState() {
    super.initState();
    fluwx.responseFromAuth.listen((data) {
      ServiceApi().wxLogin(context, data.code).then((TokenModel tokenModel) {
        SpUtil.setTokenData(tokenModel).then((_) {
          NetUtils.instance.tokens = tokenModel.token;
          ServiceApi().getUser(context).then((UserModel userModel) {
            Provider.of<UserNotifier>(context, listen: false)
                .changeUserModel(userModel)
                .then((_) {
              AppRouter.navigateTo(context, Routes.homePage, replace: true);
            });
          });
        });
      }).catchError((err) {
        LogUtil.i(err);
        ToastUtil.show(err.toString());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: setWidth(24)),
                  height: setWidth(42),
                  child: OutlineButton(
                    disabledBorderColor: Color(0xff0AC161),
                    highlightedBorderColor: Color(0xff0AC161),
                    splashColor: Colors.transparent,
                    highlightColor: Color(0x100AC161),
                    borderSide: BorderSide(color: Color(0xff0AC161)),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          'assets/images/login-weixin.png',
                          width: setWidth(30),
                          fit: BoxFit.fitWidth,
                        ),
                        Text('微信登录',
                            style: TextStyle(
                                color: Color(0xff0AC161),
                                fontSize: setSp(18),
                                fontWeight: FontWeight.w400))
                      ],
                    ),
                    onPressed: () {
                      fluwx
                          .sendWeChatAuth(
                              scope: "snsapi_userinfo",
                              state: "wx_login_hupaipai")
                          .then((val) {
                        if (!val) {
                          LogUtil.i(val);
                        }
                      });
                    },
                  ),
                ),
              ),
              Container(
                child: FlatButton(
                  child: Text("密码登录"),
                  onPressed: () {
                    AppRouter.navigateTo(context, Routes.mobileLoginPage,
                        replace: true);
                  },
                ),
              )
            ],
          ),
        ));
  }
}
