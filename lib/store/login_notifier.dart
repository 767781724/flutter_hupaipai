import 'package:flutter/material.dart';
import 'package:hupaipai/net/service_api.dart';
import 'package:hupaipai/models/token_model.dart';

class LoginNotifier with ChangeNotifier {
  static bool buttonIsDisabled = true;

  changeButtonIsDisabled(bool value) {
    buttonIsDisabled = value;
    notifyListeners();
  }

  Stream<TokenModel> login(context, mobile, passwd) {
    return Stream.fromFuture(ServiceApi().mobileLogin(context, mobile, passwd));
  }
}
