import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hupaipai/http/constans.dart';
import 'dart:convert';

import 'package:hupaipai/models/base_resp.dart';
import 'package:hupaipai/utils/log_util.dart';

/// 请求方法.
class Method {
  Method._();

  static const String GET = "GET";
  static const String POST = "POST";
  static const String PUT = "PUT";
  static const String HEAD = "HEAD";
  static const String DELETE = "DELETE";
  static const String PATCH = "PATCH";
}

typedef BaseResp Interceptor(BuildContext context, BaseResp baseResp);

class NetUtils {
  static final NetUtils instance = NetUtils._internal();
  String tokens;

  factory NetUtils() => instance;

  final bool isDebug = !bool.fromEnvironment("dart.vm.product");

  Dio _dio;
  List<Interceptor> interceptors = [];
  String tokenMark = "Authorization";

  NetUtils._internal() {
    initDio();
  }

  void addInterceptor(Interceptor interceptor) {
    interceptors.add(interceptor);
  }
 
  void setTokenMark(String mark) {
    tokenMark = mark;
  }

  void initDio() {
    // 配置dio实例
    BaseOptions options = BaseOptions(
        baseUrl: Constants.baseUrl,
        connectTimeout: 10000,
        receiveTimeout: 10000,
        contentType: Headers.jsonContentType);
    _dio = new Dio(options);
    _dio.interceptors.add(InterceptorsWrapper(onError: (DioError e) {
      if (e.response == null) e.response = Response();
      if (e.message.startsWith("SocketException")) {
        e.error = "网络连接异常，请检查您的网络状态";
      } else if (e.message.startsWith("Http status error [404]")) {
        e.error = "没有找到服务器";
      } else if (e.message.startsWith("Connecting timeout")) {
        e.error = "网络不稳定，请求超时";
      }
      return e; //continue
    }));

    //debug状态打印response
    if (isDebug) printLog();
  }

  Options getOptions(Options options) {
    if (options == null) {
      options = Options();
    }
    if (tokens != null) return options..headers = {tokenMark: tokens};
    return options;
  }

  Future<BaseResp<T>> request<T>(BuildContext context, String path,
      {String method: "POST",
      data,
      Map<String, dynamic> queryParameters,
      Options options,
      CancelToken cancelToken}) async {
    Response response = await _dio.request(path,
        data: data,
        queryParameters: queryParameters,
        options: getOptions(options)..method = method,
        cancelToken: cancelToken);
    if (response.data is Map) {
      BaseResp<T> baseResp = BaseResp.fromJson(response.data);
      for (var interceptor in interceptors) {
        var result = interceptor(context, baseResp);
        if (result != null) {
          return result;
        }
      }
      throw DioError(
          response: Response(statusCode: baseResp.code),
          error: baseResp.message,
          type: DioErrorType.RESPONSE);
    }
    throw DioError(
        response: Response(statusCode: -1),
        error: "未知错误",
        type: DioErrorType.RESPONSE);
  }

  printLog() {
    _dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
      LogUtil.i('================== 请求数据 ==========================\n'
          'url = ${options.uri.toString()}\n'
          'headers = ${options.headers}\n'
          'params = ${options.data}');
    }, onResponse: (Response response) {
      LogUtil.i('================== 响应数据 ==========================\n'
          'code = ${response.statusCode}\n'
          'data = ${json.encode(response.data)}');
    }, onError: (DioError e) {
      LogUtil.i('================== 错误响应数据 ======================\n'
          '${e.toString()}');
    }));
  }
}
