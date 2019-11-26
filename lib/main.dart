import 'package:flutter/material.dart';
import 'package:hupaipai/route/app_router.dart';
import 'package:provider/provider.dart';
import 'package:fluro/fluro.dart';

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
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [],
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

