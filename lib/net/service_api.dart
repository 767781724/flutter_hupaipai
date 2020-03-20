import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hupaipai/models/tender_model.dart';
import 'package:hupaipai/models/user_model.dart';
import 'package:hupaipai/models/token_model.dart';
import 'package:hupaipai/store/user_notifier.dart';
import 'package:hupaipai/utils/error_toast_util.dart';
import 'net_utils.dart';

class ServiceApi {
  static final ServiceApi instance = ServiceApi._internal();

  factory ServiceApi() => instance;

  ServiceApi._internal() {
    netUtils = NetUtils();
  }

  NetUtils netUtils;

  Future<TokenModel> wxLogin(BuildContext context, String code) async {
    try {
      var params = {"code": code};
      var baseResp = await NetUtils().request(
          context, "/v1/account/weChatLogin",
          data: params, method: Method.POST);
      return TokenModel.fromJson(baseResp.data);
    } catch (e) {
      ErrorToastUtil.show(e, context);
    }
  }

  Future<TokenModel> mobileLogin(
      BuildContext context, String mobile, String passwd) async {
    try {
      var params = {"mobile": mobile, "passwd": passwd};
      var baseResp = await NetUtils().request(
          context, "/v1/account/mobileLogin",
          data: params, method: Method.POST);
      return TokenModel.fromJson(baseResp.data);
    } catch (e) {
      ErrorToastUtil.show(e, context);
    }
  }

  Future<UserModel> getUser(BuildContext context) async {
    try {
      var params = {};
      var baseResp = await NetUtils()
          .request(context, "/v1/account", data: params, method: Method.GET);
      return UserModel.fromJson(baseResp.data);
    } catch (e) {
      ErrorToastUtil.show(e, context);
    }
  }

  Future<void> updateUser(BuildContext context, UserModel userModel) async {
    try {
      var params = userModel;
      await NetUtils().request(context, "/v1/account/${userModel.id}",
          data: params, method: Method.PUT);
    } catch (e) {
      ErrorToastUtil.show(e, context);
    }
  }

  Future<void> addTender(BuildContext context, TenderModel tenderModel) async {
    var params = {
      "account_id": UserNotifier.userModel.id,
      "bid_number": tenderModel.bid_number,
      "bid_passwd": tenderModel.bid_passwd,
      "id_number": tenderModel.id_number,
    };
    try {
      await NetUtils()
          .request(context, "/v1/tender", data: params, method: Method.POST);
    } catch (e) {
      ErrorToastUtil.show(e, context);
    }
  }

  Future<TenderModel> getDefaultTender(
      BuildContext context, UserModel userModel) async {
    var params = {};
    try {
      var baseResp = await NetUtils().request(
          context, "/v1/tender/account/${userModel.id}/default",
          data: params, method: Method.GET);
      List<TenderModel> result = baseResp.data
          .map((v) => TenderModel.fromJson(v))
          .toList()
          .cast<TenderModel>();
      if (result.length > 0) {
        return result[0];
      }
      return null;
    } catch (e) {
      ErrorToastUtil.show(e, context);
    }
  }

  Future setDefaultTender(BuildContext context, int bidID) async {
    try {
      var params = {};
      await NetUtils().request(context, "/v1/tender/$bidID/actions/default",
          data: params, method: Method.PUT);
    } catch (e) {
      ErrorToastUtil.show(e, context);
    }
  }

  Future<List<TenderModel>> getTenders(BuildContext context, int id) async {
    var params = {};
    try {
      var baseResp = await NetUtils().request(context, "/v1/tender/account/$id",
          data: params, method: Method.GET);
      var result = baseResp.data
          .map((v) => TenderModel.fromJson(v))
          .toList()
          .cast<TenderModel>();
      return result;
    } catch (e) {
      ErrorToastUtil.show(e, context);
    }
  }

  Future<void> updateTender(
      BuildContext context, TenderModel tenderModel) async {
    try {
      var params = tenderModel;
      await NetUtils().request(context, "/v1/tender/${tenderModel.id}",
          data: params, method: Method.PUT);
    } catch (e) {
      ErrorToastUtil.show(e, context);
    }
  }

  Future<void> deleteTender(BuildContext context, int bidID) async {
    try {
      var params = {};
      await NetUtils().request(context, "/v1/tender/$bidID",
          data: params, method: Method.DELETE);
    } catch (e) {
      ErrorToastUtil.show(e, context);
    }
  }

  Future<void> appointTender(BuildContext context, int bidID) async {
    try {
      var params = {};
      await NetUtils().request(context, "/v1/tender/$bidID/actions/reserve",
          data: params, method: Method.PUT);
    } catch (e) {
      ErrorToastUtil.show(e, context);
    }
  }
}
