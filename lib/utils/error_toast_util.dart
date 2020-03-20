import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hupaipai/net/net_utils.dart';
import 'package:hupaipai/utils/sp_util.dart';
import 'package:hupaipai/route/app_router.dart';

class ErrorToastUtil {
  static show(error, BuildContext context) {
    var e = error as DioError;
    if (e.response.statusCode == 403) {
      //未登录403
      SpUtil.delTokenData();
      SpUtil.delUserData();
      NetUtils.instance.tokens = null;
      WidgetsBinding.instance.addPostFrameCallback((_) =>
          AppRouter.navigateTo(context, Routes.wechatLoginPage, replace: true));
    }
  }
}
