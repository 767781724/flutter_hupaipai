import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:hupaipai/pages/account.dart';
import 'package:hupaipai/pages/home.dart';
import 'package:hupaipai/pages/login/mobile_login.dart';
import 'package:hupaipai/pages/login/wechat_login.dart';
import 'package:hupaipai/pages/monitor.dart';
import 'package:hupaipai/pages/play.dart';
import 'package:hupaipai/pages/splash.dart';
import 'package:hupaipai/pages/tacitcs_setting.dart';
import 'package:hupaipai/pages/tactics.dart';
import 'package:hupaipai/pages/tender.dart';
import 'package:hupaipai/pages/tender_settting.dart';

var mobileLoginHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) =>
        MobileLoginPage());
var wechatLoginHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) =>
        WechatLoginPage());
var splashHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) =>
        SplashPage());
var homeHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) =>
        HomePage());
var monitorHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) =>
        MonitorPage());
var tacticsHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) =>
        TacticsPage());
var tenderHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) =>
        TenderPage());
var tacticsSettingHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) =>
        TacitcsSettingPage());
var tenderSettingHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) =>
        TenderSettingPage(params));
var playHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) =>
        PlayPage());
var accountHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) =>
        AccountPage());
