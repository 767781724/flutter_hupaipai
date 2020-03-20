import 'package:hupaipai/models/token_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hupaipai/models/user_model.dart';
import 'package:hupaipai/net/net_utils.dart';
import 'dart:convert';

const String _userData = "userData";
const String _tokenData = "tokenData";

class SpUtil {
  static Future<UserModel> getUserData() async {
    var sp = await SharedPreferences.getInstance();
    String userData = sp.getString(_userData);
    if (userData != null) {
      var userModel = UserModel.fromJson(json.decode(userData));
      return userModel;
    }
    return null;
  }

  static Future<void> setUserData(UserModel userModel) async {
    var sp = await SharedPreferences.getInstance();
    sp.setString(_userData, json.encode(userModel.toJson()));
  }

  static delUserData() async {
    var sp = await SharedPreferences.getInstance();
    sp.remove(_userData);
  }

  static Future<TokenModel> getTokenData() async {
    var sp = await SharedPreferences.getInstance();
    String tokenData = sp.getString(_tokenData);
    if (tokenData != null) {
      var tokenModel = TokenModel.fromJson(json.decode(tokenData));
      NetUtils.instance.tokens = tokenModel.token;
      return tokenModel;
    }
    return null;
  }

  static Future<void> setTokenData(TokenModel tokenModel) async {
    var sp = await SharedPreferences.getInstance();
    sp.setString(_tokenData, json.encode(tokenModel.toJson()));
  }

  static delTokenData() async {
    var sp = await SharedPreferences.getInstance();
    sp.remove(_tokenData);
  }
}
