import 'package:dio/dio.dart';
import 'package:flutter_jellow/constant/prefs.dart';
import 'package:flutter_jellow/request/requests.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class LoginInterceptor extends InterceptorsWrapper {
  @override
  Future onError(DioError err) async {
    if (err.response?.statusCode == 401) {
      // dio instance to request token
      Dio tokenDio = Dio();
      tokenDio.options = dio.options;

      // update token and repeat
      RequestOptions options = err.response.request;

      dio.lock();
      dio.interceptors.responseLock.lock();
      dio.interceptors.errorLock.lock();

      // generate client request id
      var clientRequestId = Uuid().v1().toUpperCase();
      final prefs = await SharedPreferences.getInstance();
      final resp = await tokenDio.post('/app_auth_tokens.refresh',
          options: Options(headers: {
            jikeRefreshToken: prefs.getString(jikeRefreshToken) ??
                'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRhIjoiTVIrYktMY1QxazF6djZwQVp6VG1NZVwvM2JYdXpvWEJCZ0R6RVpoamZjWFBKVEMxbDRPM1p1K0w1NjNYXC9ydklhdjEwd0xsN3hvZmdZMkVidnY2NHlnWkJDc3lBSG9aYzNXemxsTEpPVmI5QmxSVzlrWHp2eWlDVjgwbU5YY3JjdnVYWnI4Q2J0VU92ZzlYZUw0Y3ZJK0JneU8xbWNtcDROcEJoSFRFQ2wzVnJTRXE3dXIrT1ZpYkFzQ3RIaWJJM2xDNUhcL3lRYlJObkloTGV0Sngwa05RXC8wZ2NlQXp0Y1FDQVhlRXhPRkZrN0U9IiwidiI6MywiaXYiOiJlWGtUZ0cxcDJOUWhrdmJ2S3NSVm9RPT0iLCJpYXQiOjE1ODc2MDYxMjUuOTA2fQ.vkydrZKqvZI3eBbddveFUfOl2F8wJHAzO6swgmZimhI',
            jikeClientRequestId: clientRequestId
          }),
          data: {}).whenComplete(() {
        dio.unlock();
        dio.interceptors.responseLock.unlock();
        dio.interceptors.errorLock.unlock();
      });

      final accessToken = resp?.data['x-jike-access-token'];
      final refreshToken = resp?.data['x-jike-refresh-token'];
      prefs.setString(jikeAccessToken, accessToken);
      prefs.setString(jikeRefreshToken, refreshToken);
      prefs.setString(jikeClientRequestId, clientRequestId);

      // update token
      dio.options.headers[jikeClientRequestId] = clientRequestId;
      dio.options.headers[jikeAccessToken] = accessToken;
      dio.options.headers.remove(jikeRefreshToken);

      options.headers[jikeClientRequestId] = clientRequestId;
      options.headers[jikeAccessToken] = accessToken;

      return dio.request(options.path, options: options);
    }
  }

  @override
  Future onRequest(RequestOptions options) async {
    // 设置请求头
    final prefs = await SharedPreferences.getInstance();
    options.headers[jikeAccessToken] = prefs.getString(jikeAccessToken);
    options.headers[jikeClientRequestId] = prefs.getString(jikeClientRequestId);
    return super.onRequest(options);
  }
}
