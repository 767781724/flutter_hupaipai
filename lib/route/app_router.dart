import 'dart:convert';
import 'dart:io';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

export 'route.dart';

class AppRouter {
  AppRouter._();

  static Router router;

  static Future navigateTo(BuildContext context, String path,
      {bool replace = false,
      bool clearStack = false,
      TransitionType transition = TransitionType.native,
      Duration transitionDuration = const Duration(milliseconds: 250),
      RouteTransitionsBuilder transitionBuilder}) {
    if (Platform.isAndroid) transition = TransitionType.inFromRight;
    return router.navigateTo(context, path,
        transition: transition,
        replace: replace,
        clearStack: clearStack,
        transitionDuration: transitionDuration,
        transitionBuilder: transitionBuilder);
  }

  static pop(BuildContext context) {
    router.pop(context);
  }

  //string转utf8编码
  static String utf8Encode(String str) {
    return jsonEncode(Utf8Encoder().convert(str));
  }

  //json转utf8编码
  static String jsonUtf8Encode(j) {
    return utf8Encode(json.encode(j));
  }

  //json utf8解码
  static dynamic jsonUtf8Decode(utf8Json) {
    return json.decode(utf8Decode(utf8Json));
  }

  //string utf8解码
  static String utf8Decode(String utf8String) {
    var list = List<int>();
    jsonDecode(utf8String).forEach(list.add);
    return Utf8Decoder().convert(list);
  }
}
