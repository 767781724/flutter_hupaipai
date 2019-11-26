import 'dart:io';
import 'package:dio/dio.dart';
import 'package:hupaipai/models/base_resp.dart';
import 'dart:convert';

import 'package:hupaipai/utils/constants.dart';

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
  static String tokens='';
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
    );
    _dio = new Dio(options);
    _dio.interceptors.add(InterceptorsWrapper(onError: (DioError e) {
      if (e.response == null) e.response = Response();
      if (e.message.startsWith("SocketException")) e.message = "网络连接异常，请检查您的网络状态";
      else if(e.message.startsWith("Http status error [404]"))e.message = "没有找到服务器";
      return e; //continue
    }));
    //debug状态打印response
    if (isDebug) printLog();
//    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client) {
//      client.findProxy = (uri) {
//        return "PROXY localhost:8001";
//      };
//    };
  }
  Options getOptions(Options options){
    if(options==null){
      options=Options();
    }
   return options..headers={"Authorization":tokens};
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
      if (HttpStatus.ok == baseResp.code) {
        return baseResp;
      }
      throw DioError(
          response: Response(statusCode: baseResp.code),
          message: baseResp.msg,
          type: DioErrorType.RESPONSE);
      }
      throw DioError(
          response: Response(statusCode: -1), message: "未知错误", type: DioErrorType.RESPONSE);
  }

  printLog() {
    _dio.interceptors.add(InterceptorsWrapper(onRequest: (RequestOptions options) {
      print("\n================== 请求数据 ==========================");
      print("url = ${options.uri.toString()}");
      print("headers = ${options.headers}");
      print("params = ${options.data}");
    }, onResponse: (Response response) {
      print("\n================== 响应数据 ==========================");
      print("code = ${response.statusCode}");
      print("data = ${json.encode(response.data)}");
      print("\n");
    }, onError: (DioError e) {
      print("\n================== 错误响应数据 ======================");
      print("type = ${e.type}");
      print("message = ${e.message}");
      print("stackTrace = ${e.stackTrace}");
      print("\n");
    }));
  }
}
