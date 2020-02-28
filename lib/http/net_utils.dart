import 'dart:io';
import 'package:dio/dio.dart';
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
      contentType: Headers.jsonContentType
    );
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
      LogUtil.i('${baseResp}');
      if (HttpStatus.ok == baseResp.code) {
        return baseResp;
      }
      throw DioError(response: Response(statusCode: baseResp.code), error: baseResp.message, type: DioErrorType.RESPONSE);
    }
    throw DioError(response: Response(statusCode: -1), error: "未知错误", type: DioErrorType.RESPONSE);
  }

  printLog() {
    _dio.interceptors.add(InterceptorsWrapper(onRequest: (RequestOptions options) {
      LogUtil.i("\n================== 请求数据 ==========================");
      LogUtil.i("url = ${options.uri.toString()}");
      LogUtil.i("headers = ${options.headers}");
      LogUtil.i("params = ${options.data}");
    }, onResponse: (Response response) {
      LogUtil.i("\n================== 响应数据 ==========================");
      LogUtil.i("code = ${response.statusCode}");
      LogUtil.i("data = ${json.encode(response.data)}");
      LogUtil.i("\n");
    }, onError: (DioError e) {
      LogUtil.i("\n================== 错误响应数据 ======================");
      LogUtil.i("type = ${e.type}");
      LogUtil.i("message = ${e.message}");
      LogUtil.i("stackTrace = ${e.toString()}");
      LogUtil.i("\n");
    }));
  }
}
