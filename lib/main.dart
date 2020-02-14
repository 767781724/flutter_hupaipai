import 'package:flutter/material.dart';
import 'package:hupaipai/http/web_socket.dart';
import 'package:hupaipai/provides/ws_provide.dart';
import 'package:hupaipai/route/app_router.dart';
import 'package:provider/provider.dart';
import 'package:fluro/fluro.dart';
import 'package:fluwx/fluwx.dart' as fluwx;
import 'provides/application_provide.dart';

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
    await fluwx.registerWxApi(appId:"wx435f85136f4a8422",universalLink:'https://hupaipai.hupaigx.com/');
    var result = await fluwx.isWeChatInstalled();
    print("wechat is installed: $result");
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Application()),
        ChangeNotifierProvider.value(value: WsBloc()),
        Provider.value(value: Socket()),
      ],
      child: MaterialApp(
        title: "沪拍牌",
        theme: ThemeData(
            appBarTheme: AppBarTheme(
                color: Colors.white,
                textTheme: TextTheme(
                    title: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black)),
                iconTheme: IconThemeData(size: 28, color: Color(0xff999999)))
        ),
        onGenerateRoute: AppRouter.router.generator,
      ),
    );
  }
}

