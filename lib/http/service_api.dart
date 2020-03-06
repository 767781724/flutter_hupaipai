import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hupaipai/models/base_resp.dart';
import 'package:hupaipai/models/tender_model.dart';
import 'package:hupaipai/models/user_model.dart';
import 'package:hupaipai/route/app_router.dart';
import 'package:hupaipai/provides/provide_util.dart';
import 'net_utils.dart';

class ServiceApi{
  static final ServiceApi instance = ServiceApi._internal();
  factory ServiceApi() => instance;

  ServiceApi._internal() {
    netUtils = NetUtils();
    netUtils.addInterceptor(httpOk);
    netUtils.addInterceptor(httpForbidden);
  }

  NetUtils netUtils;

  BaseResp httpOk(BuildContext context, BaseResp baseResp) {
    if (HttpStatus.ok == baseResp.code) {
        return baseResp;
    }
    return null;
  }

  BaseResp httpForbidden(BuildContext context, BaseResp baseResp) {
    if (HttpStatus.forbidden == baseResp.code) {
      ProvideUtil.delUserData().then((_) {
        WidgetsBinding.instance.addPostFrameCallback((_) =>
          AppRouter.navigateTo(context, Routes.loginPage, replace: true));
      });

    }
    return baseResp;
  }

  Future<UserModel> wxLogin(BuildContext context, String code) async {
    var params = {"code": code};
    var baseResp =
        await NetUtils().request(context, "/v1/account/weChatLogin", data: params, method: Method.POST);
    return UserModel.fromJson(baseResp.data);
  }

  Future<void> updateUser(BuildContext context, UserModel userModel) async {
    var params = userModel;
    await NetUtils().request(context, "/v1/account/${userModel.accountId}", data: params, method: Method.PUT);
  }

  Future<void> addTender(BuildContext context, TenderModel tenderModel) async {
    var params = tenderModel;
    await NetUtils().request(context, "/v1/tender", data: params, method: Method.POST);
  }

  Future<List<TenderModel>> getTenders(BuildContext context, String bidNumber) async {
    var params = {};
    var baseResp = await NetUtils().request(context, "/v1/tender/account/$bidNumber", data: params, method: Method.GET);
    var result = baseResp.data
        .map((v) => TenderModel.fromJson(v))
        .toList()
        .cast<TenderModel>();
    return result;
  }

  Future<void> updateTender(BuildContext context, TenderModel tenderModel) async {
    var params = tenderModel;
    await NetUtils().request(context, "/v1/tender/${tenderModel.bid_number}", data: params, method: Method.PUT);
  }

  Future<void> deleteTender(BuildContext context, String bidNumber) async {
    var params = {};
    await NetUtils().request(context, "/v1/tender/$bidNumber", data: params, method: Method.DELETE);
  }

  Future<void> appointTender(BuildContext context, String bidNumber) async {
    var params = {};
    await NetUtils().request(context, "/v1/tender/$bidNumber/actions/reserve", data: params, method: Method.PUT);
  }

}