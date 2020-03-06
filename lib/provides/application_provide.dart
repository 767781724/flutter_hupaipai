import 'package:flutter/material.dart';
import 'package:hupaipai/http/net_utils.dart';
import 'package:hupaipai/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hupaipai/provides/provide_util.dart';

class Application with ChangeNotifier {
  UserModel _userModel;
  UserModel get userModel => _userModel;
  bool get isLogin => _userModel != null;

  Application() {
    initUserModel();
  }

  //初始化用户信息
  Future initUserModel() async {
    var userModel = await ProvideUtil.getUserData();
    _userModel = userModel; //赋值
    notifyListeners();
  }

  //保存有户信息
  Future saveUserModel(UserModel userData) async {
    _userModel = userData; //赋值
    //保存本地
    await ProvideUtil.setUserData(_userModel);
    notifyListeners();
  }

  //清除
  Future clearUserModel() async {
    await ProvideUtil.delUserData();
    notifyListeners();
  }
}
