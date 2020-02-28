import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:hupaipai/http/constans.dart';
import 'package:hupaipai/http/net_utils.dart';
import 'package:hupaipai/models/base_socket_resp.dart';
import 'package:hupaipai/utils/log_util.dart';

typedef void SocketEventListener(dynamic data);

class WebSocketCmd {
  WebSocketCmd._();

  static final String wsAll = 'all';

}

class Socket {
  WebSocket _webSocket;
  bool _isReconnect;
  Map<String, List<Function>> _listeners = {};

  void connect() {
    close(true);
    LogUtil.i(Constants.wsUrl);
    var connect = WebSocket.connect(Constants.wsUrl);
    connect.then((socket) {
      LogUtil.i("Socket：连接成功");
      socket.pingInterval = Duration(seconds: 4);
      _webSocket = socket;
      bindToken();
      socket.listen((data) {
        LogUtil.i("Socket：data:${data}");
        var decode = json.decode(data);
        if (decode is Map) parseJson(decode);
      }, onDone: () {
        _reconnect();
        LogUtil.i("Socket：done_closeCode:${socket.closeCode}");
      });
    }, onError: (e) {
      LogUtil.i("Socket：onError:${e}");
    //  Toast.show(msg: "网络信号不稳定");
      _reconnect();
    });
  }

  void bindToken([tokens]) {
    send({"uuid":"oT9M-5dwh15Cpgudjq1KNQowkbrQ","username":"灿昌信息技术","openid":"oT9M-5dwh15Cpgudjq1KNQowkbrQ","type":"codelogin","action":"codelogin","invite":"0002"});
    //登录时，由于SharedPreferences保存的慢，NetUtils.instance.tokens可能为空
    if (tokens != null) {
      send({"uuid":"oT9M-5dwh15Cpgudjq1KNQowkbrQ","username":"灿昌信息技术","openid":"oT9M-5dwh15Cpgudjq1KNQowkbrQ","type":"codelogin","action":"codelogin","invite":"0002"});
    } else if (NetUtils.instance.tokens != null) {
      send({"token": NetUtils.instance.tokens});
    }
  }

  void send(dynamic params) {
    if (_webSocket != null && _webSocket.readyState == WebSocket.open) {
      try {
        if (params == null) params = {};

        _webSocket.add(json.encode({'data':JsonEncoder().convert(params)}));
      } catch (e) {
        LogUtil.i('Socket：send_e:${e}');
      }
    }
  }

  void _reconnect() {
    if (_isReconnect) {
      Timer(Duration(seconds: 3), () {
        LogUtil.i("Socket：开始重连");
        connect();
      });
    }
  }

  void close([bool reconn = false]) {
    _isReconnect = reconn;
    if (_webSocket != null) {
      LogUtil.i('Socket：close_readyState:${_webSocket.readyState}');
      _webSocket.close();
    }
  }

  void parseJson(Map data) {
    var socketResp = BaseSocketResp.fromJson(data);
    if (socketResp.resCode == 200) {
      List funcs = _listeners[socketResp.cmd];
      funcs?.removeWhere((func) => func == null);
      funcs?.forEach((func) => func(socketResp.data));
    }
  }

  on(String eventName, SocketEventListener listener) {
    if (_listeners[eventName] == null) {
      _listeners[eventName] = [];
    }
    _listeners[eventName].add(listener);
  }

  off(String eventName, [SocketEventListener listener]) async {
    if (listener == null) {
      _listeners.remove(eventName);
    } else {
      _listeners[eventName]?.remove(listener);
    }
  }
}
