import 'dart:async';
import 'dart:convert';
import 'package:hupaipai/net/constans.dart';
import 'package:hupaipai/models/base_socket_resp.dart';
import 'package:hupaipai/utils/log_util.dart';
import 'package:rxdart/rxdart.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

typedef void SocketEventListener(dynamic data);

class AppSocket {
  static IOWebSocketChannel _webSocket;
  static bool _isReconnect;
  static List<SocketEventListener> _listeners = [];
  static Map<String, String> bindCommand;

  static void startBindSocket(Map<String, String> bc) {
    bindCommand = bc;
    if (_webSocket != null) {
      send(bindCommand);
    }
  }

  static void connect() {
    LogUtil.i('Constants.wsUrl ======> ${Constants.wsUrl}');
    _isReconnect = true;
    _webSocket = IOWebSocketChannel.connect(Constants.wsUrl,
        pingInterval: Duration(seconds: 10));
    _webSocket.stream.listen((message) {
      LogUtil.i("====> Socket message:$message");
      var decode = json.decode(message);
      if (decode is Map) {
        parseJson(decode);
      } else {
        LogUtil.i("Socket data is not json");
      }
    }, onDone: () {
      LogUtil.i("Socket onDone");
      _webSocket = null;
      _reconnect();
    }, onError: (error) {
      LogUtil.i("Socket onError: $error");
    });
    bindToken();
  }

  static void bindToken() {
    if (bindCommand != null) {
      send(bindCommand);
    }
  }

  static void send(dynamic params) {
    if (_webSocket != null) {
      try {
        if (params != null) {
          var d = json.encode({'data': JsonEncoder().convert(params)});
          _webSocket.sink.add(d);
        }
      } catch (e) {
        LogUtil.i('Socket：send_e:$e');
      }
    }
  }

  static void _reconnect() {
    if (_isReconnect) {
      Timer(Duration(milliseconds: 5000), () {
        LogUtil.i("Socket：开始重连");
        connect();
      });
    }
  }

  static void close([bool reconn = false]) {
    _isReconnect = reconn;
    if (_webSocket != null) {
//      LogUtil.i('Socket：close_readyState: ${_webSocket.readyState}');
      _webSocket.sink.close(status.goingAway);
      _webSocket = null;
    }
  }

  static void parseJson(Map data) {
    LogUtil.i('=========> msg: $data');
    var socketResp = BaseSocketResp.fromJson(data);
    if (socketResp.data != null) {
      List funcs = _listeners;
      funcs?.forEach((func) => func(socketResp.data));
    }
  }

  static void on(SocketEventListener listener) {
    _listeners.add(listener);
  }

  static void off([SocketEventListener listener]) async {
    _listeners.remove(listener);
  }
}
