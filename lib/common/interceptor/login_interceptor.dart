import 'package:dio/dio.dart';
import 'package:flutter_jellow/common/api/api.dart';
import 'package:flutter_jellow/common/entity/entity.dart';
import 'package:flutter_jellow/common/util/http.dart';
import 'package:flutter_jellow/common/value/http_header.dart';
import 'package:flutter_jellow/global.dart';
import 'package:uuid/uuid.dart';

/// 登录拦截器
class LoginInterceptor extends InterceptorsWrapper {
  @override
  Future onError(DioError err) async {
    if (err.response?.statusCode == 401) {
      // dio instance to request token
      // update token and repeat

      Dio dio = HttpUtil().dio;
      dio.lock();
      dio.interceptors.responseLock.lock();
      dio.interceptors.errorLock.lock();

      var clientRequestId = Uuid().v1().toUpperCase();
      final Response resp =
          await UserAPI.refreshToken(clientRequestId).whenComplete(() {
        dio.unlock();
        dio.interceptors.responseLock.unlock();
        dio.interceptors.errorLock.unlock();
      });

      if (resp.statusCode == 200) {
        final accessToken = resp?.data['x-jike-access-token'];
        final refreshToken = resp?.data['x-jike-refresh-token'];

        Global.saveProfile(UserProfile(
            accessToken: accessToken,
            refreshToken: refreshToken,
            clientRequestId: clientRequestId));

        /// 设置请求头，重新请求
        RequestOptions options = err.response.request;
        _setHeader(options);
        return dio.request(options.path, options: options);
      }
      super.onError(err);
    }
  }

  @override
  Future onRequest(RequestOptions options) async {
    // 设置请求头
    _setHeader(options);
    return super.onRequest(options);
  }

  _setHeader(RequestOptions options) {
    options.headers[ACCESS_TOKEN] = Global.profile.accessToken;
    options.headers[CLIENT_REQUEST_ID] = Global.profile.clientRequestId;
  }
}
