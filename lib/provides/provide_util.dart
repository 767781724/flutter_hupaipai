import 'package:shared_preferences/shared_preferences.dart';
import 'package:hupaipai/models/user_model.dart';
import 'package:hupaipai/http/net_utils.dart';
import 'dart:convert';

class ProvideUtil {

  static final String _userData = "userData";

  static Future<UserModel> getUserData() async {
    var sp = await SharedPreferences.getInstance();
    String userData = sp.getString(_userData);
    if (userData != null) {
      var userModel = UserModel.fromJson(json.decode(userData));
      NetUtils.instance.tokens = userModel.token;
      return userModel;
    }
    return null;
  }

  static Future<void> setUserData(UserModel userModel) async {
    NetUtils.instance.tokens = userModel.token;
    var sp = await SharedPreferences.getInstance();
    sp.setString(_userData, json.encode(userModel.toJson()));
  }

  static delUserData() async {
    NetUtils.instance.tokens = null;
    var sp = await SharedPreferences.getInstance();
    sp.remove(_userData);
  }

}