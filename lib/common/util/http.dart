import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter_jellow/common/interceptor/login_interceptor.dart';
import 'package:flutter_jellow/common/value/value.dart';
import 'package:flutter_jellow/global.dart';

/// http 操作类
/// 手册
/// https://github.com/flutterchina/dio/blob/master/README-ZH.md#formdata
class HttpUtil {
  static HttpUtil _instance = HttpUtil._internal();

  factory HttpUtil() => _instance;

  get dio => _dio;

  static Dio _dio;

  /// 用于获取 token
  static Dio _anotherDio;

  HttpUtil._internal() {
    BaseOptions options = new BaseOptions(
      headers: {
        'king-card-status': 'unknown',
        'user-agent': 'YellowStar/117 CFNetwork/1125.1 Darwin/19.4.0',
        'x-jike-device-id': '2B16E6AE-11A2-49DD-AE06-EC9D597A6AF9',
        'app-buildno': '117',
        'os': 'ios',
        'manufacturer': 'Apple',
        'bundleid': 'io.iftech.jellow2',
        'accept-language': 'zh-cn',
        'support-h265': 'true',
        'model': 'iPad8,1',
        'app-permissions': '4',
        'accept': '*/*',
      },
      baseUrl: SERVER_API_URL,
      connectTimeout: 10000,
    );

    _dio = Dio(options);
    _anotherDio = Dio(options);

    _dio.interceptors..add(LoginInterceptor());

    // 抓包代理
    if (!Global.isRelease && PROXY_ENABLE) {
      (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        client.findProxy = (uri) {
          return 'PROXY $PROXY_IP:$PROXY_PORT';
        };
        client.badCertificateCallback = (cert, host, port) => true;
      };

      (_anotherDio.httpClientAdapter as DefaultHttpClientAdapter)
          .onHttpClientCreate = (client) {
        client.findProxy = (uri) {
          return 'PROXY $PROXY_IP:$PROXY_PORT';
        };
        client.badCertificateCallback = (cert, host, port) => true;
      };
    }
  }

  Future<dynamic> request(
    String path, {
    String method = 'get',
    data,
    Map<String, dynamic> queryParameters,
    Options options,
  }) {
    options = options ?? Options();
    options.method = method;
    return _dio.request(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  Future<dynamic> anotherRequest(
    String path, {
    String method = 'get',
    data,
    Map<String, dynamic> queryParameters,
    Options options,
  }) {
    options = options ?? Options();
    options.method = method;
    return _anotherDio.request(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }
}
