import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:hupaipai/http/constans.dart';
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
  Map<String, List<SocketEventListener>> _listeners = {};
  Map<String, String> bindCommand;

  void setBindCommand(Map<String, String> bindCommand) {
    bindCommand = bindCommand;
  }

  void connect() {
    close(true);
    LogUtil.i(Constants.wsUrl);
    WebSocket.connect(Constants.wsUrl).then((socket) {
      LogUtil.i("Socket：连接成功");
      _isReconnect = true;
      socket.pingInterval = Duration(seconds: 10);
      bindToken();
      socket.listen((data) {
        LogUtil.i("Socket：data:$data");
        var decode = json.decode(data);
        if (decode is Map) {
          parseJson(decode);
        } else {
          LogUtil.i("Socket data is not json");
        }
      }, onDone: () {
        LogUtil.i("Socket：onClose");
        _webSocket = null;
        _reconnect();
      }, onError: () {
        LogUtil.i("Socket：onError");
      });
      _webSocket = socket;
    }, onError: (e) {
      _reconnect();
      LogUtil.i("Socket connect error: $e");
    });
  }

  void bindToken([tokens]) {
    if (bindCommand != null) {
      send(bindCommand);
    }
  }

  void send(dynamic params) {
    if (_webSocket != null && _webSocket.readyState == WebSocket.open) {
      try {
        if (params != null) {
          _webSocket.add(json.encode({'data': JsonEncoder().convert(params)}));
        }
      } catch (e) {
        LogUtil.i('Socket：send_e:$e');
      }
    }
  }

  void _reconnect() {
    if (_isReconnect) {
      Timer.periodic(Duration(seconds: 3), (_) {
        LogUtil.i("Socket：开始重连");
        connect();
      });
    }
  }

  void close([bool reconn = false]) {
    _isReconnect = reconn;
    if (_webSocket != null) {
      LogUtil.i('Socket：close_readyState: ${_webSocket.readyState}');
      _webSocket.close();
      _webSocket = null;
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
