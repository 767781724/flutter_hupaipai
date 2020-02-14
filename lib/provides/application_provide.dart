import 'package:flutter/material.dart';
import 'package:hupaipai/http/net_utils.dart';
import 'package:hupaipai/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Application with ChangeNotifier {
  final String _userData = "userData";

  UserModel _userModel;

  UserModel get userModel => _userModel;

  bool get isLogin => _userModel != null;

  Application(){
    initUserModel();
  }

  //初始化用户信息
  void initUserModel() {
    SharedPreferences.getInstance().then((sp) {
      String userData = sp.getString(_userData);
      if (userData != null) {
        _userModel = UserModel.fromJson(json.decode(userData));
        NetUtils.instance.tokens = _userModel.token;
        notifyListeners();
      }
    });
  }

  //保存有户信息
  void saveUserModel(UserModel userData) {
    _userModel = userData; //赋值
    //保存本地
    _saveNative(_userModel.toJson());
  }

  //修改用户信息
  void changeUserModel(String key, data) {
    //转成map赋值，再重新转对象
    var jsonUserModel = _userModel.toJson();
    jsonUserModel[key] = data;
    _userModel = UserModel.fromJson(jsonUserModel);
    //保存本地
    _saveNative(jsonUserModel);
  }

  void _saveNative(Object obj) {
    SharedPreferences.getInstance().then((sp) {
      NetUtils.instance.tokens = _userModel.token;
      sp.setString(_userData, json.encode(obj));
      notifyListeners();
    });
  }

  //清除
  void clearUserModel() {
    SharedPreferences.getInstance().then((sp) {
      sp.remove(_userData);
      _userModel = null;
      NetUtils.instance.tokens = null;
      notifyListeners();
    });
  }
}
