import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:hupaipai/route/route_handlers.dart';

class Routes{
  Routes._();
  static String root="/";
  static String loginPage="/loginPage";
  static String homePage="/homePage";
  static String monitorPage="/monitorPage";
  static String tacticsPage="/tacticspage";
  static String tenderPage="/tenderPage";
  static String tacticsSettingPage='/tacticsSettingpage';
  static String tenderSettingPage='/tenderSettingPage';
  static String playPage='/playPage';
  static String accountPage='/accountPage';

  static void configureRoutes(Router router) {
    router.notFoundHandler =new Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {});
    router.define(root, handler: splashHandler);
    router.define(homePage, handler: homeHandler);
    router.define(loginPage, handler: loginHandler);
    router.define(monitorPage, handler: monitorHandler);
    router.define(tacticsPage, handler: tacticsHandler);
    router.define(tenderPage, handler: tenderHandler);
    router.define(tacticsSettingPage, handler: tacticsSettingHandler);
    router.define(tenderSettingPage, handler: tenderSettingHandler);
    router.define(playPage, handler: playHandler);
    router.define(accountPage, handler: accountHandler);
  }
}