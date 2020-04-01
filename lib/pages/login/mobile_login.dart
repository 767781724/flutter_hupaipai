import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hupaipai/net/net_utils.dart';
import 'package:hupaipai/net/service_api.dart';
import 'package:hupaipai/models/user_model.dart';
import 'package:hupaipai/store/login_notifier.dart';
import 'package:hupaipai/utils/sp_util.dart';
import 'package:hupaipai/route/app_router.dart';
import 'package:hupaipai/utils/screen_util.dart';
import 'package:hupaipai/widgets/loading_widget.dart';
import 'package:provider/provider.dart';
import 'package:hupaipai/store/user_notifier.dart';
import 'package:hupaipai/utils/toast_util.dart';
import 'package:rxdart/rxdart.dart';

class MobileLoginPage extends StatefulWidget {
  @override
  _MobileLoginPageState createState() => _MobileLoginPageState();
}

class _MobileLoginPageState extends State<MobileLoginPage> with ScreenUtil {
  TextEditingController _mobileController, _passwdController;
  FocusNode _mobileFocusNode, _passwdFocusNode;
  LoginNotifier loginNotifier;

  @override
  void initState() {
    super.initState();
    _mobileController = TextEditingController();
    _passwdController = TextEditingController();
    _mobileFocusNode = FocusNode();
    _passwdFocusNode = FocusNode();
  }

  Widget buildMobileTextField() {
    return Stack(
      children: <Widget>[
        TextField(
          maxLines: 1,
          maxLength: 14,
          style: TextStyle(fontSize: setSp(18), fontWeight: FontWeight.w500),
          focusNode: _mobileFocusNode,
          keyboardType: TextInputType.text,
          controller: _mobileController,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            counterText: "",
            contentPadding: EdgeInsets.symmetric(vertical: setWidth(12)),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xffF1F1F1), width: 1)),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xffF1F1F1), width: 1)),
            hintText: "请输入登录手机",
            hintStyle: TextStyle(
                color: Color(0xffcccccc), fontWeight: FontWeight.w500),
          ),
          onChanged: (text) {
            validation();
          },
          onEditingComplete: () =>
              FocusScope.of(context).requestFocus(_passwdFocusNode),
        ),
      ],
    );
  }

  Widget buildPasswdTextField() {
    return Stack(
      children: <Widget>[
        TextField(
          maxLines: 1,
          maxLength: 20,
          style: TextStyle(fontSize: setSp(18), fontWeight: FontWeight.w500),
          keyboardType: TextInputType.text,
          obscureText: true,
          controller: _passwdController,
          focusNode: _passwdFocusNode,
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xffF1F1F1), width: 1)),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xffF1F1F1), width: 1)),
            counterText: "",
            contentPadding: EdgeInsets.symmetric(vertical: setWidth(12)),
            disabledBorder: InputBorder.none,
            hintStyle: TextStyle(
                color: Color(0xffcccccc), fontWeight: FontWeight.w500),
            hintText: "请输入登录密码",
          ),
          onChanged: (text) {
            validation();
          },
        ),
      ],
    );
  }

  void validation() {
    var mobileLengh = _mobileController.value.text.length;
    var passwdLength = _passwdController.value.text.length;
    loginNotifier.changeButtonIsDisabled(mobileLengh == 11 && passwdLength > 0);
  }

  Widget buildLoginButton([text = "登录"]) {
    return Container(
      width: double.infinity,
      height: setWidth(42),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            offset: Offset(0.0, 1.0),
            color: LoginNotifier.buttonIsDisabled
                ? Theme.of(context).buttonColor
                : Color(0xffdddddd),
            blurRadius: setWidth(30),
            spreadRadius: setWidth(-16))
      ]),
      margin: EdgeInsets.only(top: setWidth(50)),
      child: FlatButton(
        onPressed: !LoginNotifier.buttonIsDisabled ? null : () => _doLogin(),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
        color: Theme.of(context).buttonColor,
        textColor: Colors.white,
        disabledTextColor: Color(0xffcccccc),
        disabledColor: Colors.white,
        child: Text(
          text,
          style: TextStyle(fontSize: setSp(18)),
        ),
      ),
    );
  }

  void _doLogin() {
    var applicationNotifier =
        Provider.of<UserNotifier>(context, listen: false);
    var mobile = _mobileController.text;
    var passwd = _passwdController.text;
    loginNotifier
        .login(context, mobile, passwd)
        .transform(loading(context))
        .listen((tokenModel) async {
      SpUtil.setTokenData(tokenModel).then((_) {
        NetUtils.instance.tokens = tokenModel.token;
        ServiceApi().getUser(context).then((UserModel userModel) {
          applicationNotifier.changeUserModel(userModel).then((_) {
            AppRouter.navigateTo(context, Routes.homePage, replace: true);
          });
        });
      });
    });
  }

  DoStreamTransformer<T> loading<T>(context) {
    return DoStreamTransformer<T>(onListen: () {
      showLoading(context);
    }, onData: (data) {
      AppRouter.pop(context);
    }, onError: (error, _) {
      AppRouter.pop(context);
      doError(error);
    });
  }

  doError(error, {bool isShowToast = true, bool isJumpPage = true}) {
    var e = error as DioError;
    if (e.response.statusCode == 403) {
      //未登录
      if (isJumpPage) {
        WidgetsBinding.instance.addPostFrameCallback((_) =>
            AppRouter.navigateTo(context, Routes.mobileLoginPage,
                replace: true));
      }
    } else {
      if (isShowToast) ToastUtil.show(error?.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    loginNotifier = Provider.of<LoginNotifier>(context);
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
            child: Container(
              alignment: Alignment.center,
              height: screenHeightDp,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: setWidth(24)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: setWidth(120),
                          ),
                          Text(
                            "手机密码登录",
                            style: TextStyle(
                              fontSize: setSp(24),
                            ),
                          ),
                          SizedBox(
                            height: setWidth(45),
                          ),
                          buildMobileTextField(),
                          buildPasswdTextField(),
                          buildLoginButton(),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    child: FlatButton(
                      child: Text("微信登录"),
                      onPressed: () {
                        AppRouter.navigateTo(context, Routes.wechatLoginPage,
                            replace: true);
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
