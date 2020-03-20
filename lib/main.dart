import 'package:flutter/material.dart';
import 'package:hupaipai/store/login_notifier.dart';
import 'package:hupaipai/store/ws_notifier.dart';
import 'package:hupaipai/route/app_router.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:fluro/fluro.dart';
import 'package:fluwx/fluwx.dart' as fluwx;
import 'package:hupaipai/store/user_notifier.dart';
import 'package:hupaipai/utils/log_util.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  _MyAppState() {
    final router = Router();
    Routes.configureRoutes(router);
    AppRouter.router = router;
  }

  @override
  void initState() {
    super.initState();
    _initFluwx();
  }

  _initFluwx() async {
    await fluwx.registerWxApi(
        appId: "wx435f85136f4a8422",
        universalLink: 'https://hupaipai.hupaigx.com/');
    var result = await fluwx.isWeChatInstalled();
    LogUtil.i("wechat is installed: $result");
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: UserNotifier()),
        ChangeNotifierProvider.value(value: LoginNotifier()),
        ChangeNotifierProvider.value(value: WsBloc()),
      ],
      child: OverlaySupport(
          child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "沪拍牌",
        theme: ThemeData(
            buttonColor: Color(0xFF1CCAD6),
            appBarTheme: AppBarTheme(
                color: Colors.white,
                textTheme: TextTheme(
                    title: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                iconTheme: IconThemeData(size: 28, color: Color(0xff999999)))),
        onGenerateRoute: AppRouter.router.generator,
      )),
    );
  }
}
