import 'package:flutter/material.dart' show Colors;
import 'package:fluttertoast/fluttertoast.dart';

export 'package:fluttertoast/fluttertoast.dart' show ToastGravity;

class ToastUtil {
  static Future<bool> show(String msg,
      {gravity: ToastGravity.CENTER,
      backgroundColor: Colors.black26,
      toastLength}) async {
    return Fluttertoast.showToast(
      msg: msg,
      gravity: gravity,
      backgroundColor: backgroundColor,
      toastLength: toastLength,
    );
  }
}
