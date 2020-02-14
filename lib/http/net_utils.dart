import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:hupaipai/http/constans.dart';
import 'dart:convert';

import 'package:hupaipai/models/base_resp.dart';

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

class NetUtils {
  static final NetUtils instance = NetUtils._internal();
  String tokens;

  factory NetUtils() => instance;

  final bool isDebug = !bool.fromEnvironment("dart.vm.product");

  Dio _dio;

  NetUtils._internal() {
    initDio();
  }

  void initDio() {
    // 配置dio实例
    BaseOptions options = BaseOptions(
      baseUrl: Constants.baseUrl,
      connectTimeout: 10000,
      receiveTimeout: 10000,
      contentType: ContentType.json,
    );
    _dio = new Dio(options);
    _dio.interceptors.add(InterceptorsWrapper(onError: (DioError e) {
      if (e.response == null) e.response = Response();
      if (e.message.startsWith("SocketException")) {
        e.message = "网络连接异常，请检查您的网络状态";
      } else if (e.message.startsWith("Http status error [404]")) {
        e.message = "没有找到服务器";
      } else if (e.message.startsWith("Connecting timeout")) {
        e.message = "网络不稳定，请求超时";
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
    if (tokens != null) return options..headers = {"Authorization": tokens};
    return options;
  }

  Future<BaseResp<T>> request<T>(String path,
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
      log('${baseResp}');
      if (HttpStatus.ok == baseResp.code) {
        return baseResp;
      }
      throw DioError(response: Response(statusCode: baseResp.code), message: baseResp.msg, type: DioErrorType.RESPONSE);
    }
    throw DioError(response: Response(statusCode: -1), message: "未知错误", type: DioErrorType.RESPONSE);
  }

  printLog() {
    _dio.interceptors.add(InterceptorsWrapper(onRequest: (RequestOptions options) {
      log("\n================== 请求数据 ==========================");
      log("url = ${options.uri.toString()}");
      log("headers = ${options.headers}");
      log("params = ${options.data}");
    }, onResponse: (Response response) {
      log("\n================== 响应数据 ==========================");
      log("code = ${response.statusCode}");
      log("data = ${json.encode(response.data)}");
      log("\n");
    }, onError: (DioError e) {
      log("\n================== 错误响应数据 ======================");
      log("type = ${e.type}");
      log("message = ${e.message}");
      log("stackTrace = ${e.stackTrace}");
      log("\n");
    }));
  }
}
