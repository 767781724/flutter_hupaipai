import 'package:flutter/material.dart';
import 'package:hupaipai/models/token_model.dart';
import 'package:hupaipai/models/user_model.dart';
import 'package:hupaipai/net/net_utils.dart';
import 'package:hupaipai/utils/sp_util.dart';

class UserNotifier with ChangeNotifier {
  static UserModel userModel;
  static TokenModel tokenModel;

  static isLogin() => tokenModel != null;

  UserNotifier() {
    initUserModel();
  }

  //初始化用户信息
  Future initUserModel() async {
    tokenModel = await SpUtil.getTokenData();
    userModel = await SpUtil.getUserData();
    notifyListeners();
  }

  //保存有户信息
  Future changeUserModel(UserModel um) async {
    userModel = um;
    if (um != null) {
      await SpUtil.setUserData(um);
    } else {
      await SpUtil.delUserData();
    }
    notifyListeners();
  }

  Future changeTokenModel(TokenModel tm) async {
    tokenModel = tm;
    if (tm != null) {
      await SpUtil.setTokenData(tm);
      NetUtils.instance.tokens = tokenModel.token;
    } else {
      await SpUtil.delTokenData();
      NetUtils.instance.tokens = null;
    }
    notifyListeners();
  }
}
