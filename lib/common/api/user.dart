import 'package:dio/dio.dart';
import 'package:flutter_jellow/common/util/http.dart';
import 'package:flutter_jellow/common/value/http_header.dart';
import 'package:flutter_jellow/global.dart';

class UserAPI {
  static Future refreshToken(String clientRequestId) {
    return HttpUtil().anotherRequest('/app_auth_tokens.refresh',
        method: 'post',
        options: Options(headers: {
          REFRESH_TOKEN: Global.profile.refreshToken ??
              'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRhIjoiTVIrYktMY1QxazF6djZwQVp6VG1NZVwvM2JYdXpvWEJCZ0R6RVpoamZjWFBKVEMxbDRPM1p1K0w1NjNYXC9ydklhdjEwd0xsN3hvZmdZMkVidnY2NHlnWkJDc3lBSG9aYzNXemxsTEpPVmI5QmxSVzlrWHp2eWlDVjgwbU5YY3JjdnVYWnI4Q2J0VU92ZzlYZUw0Y3ZJK0JneU8xbWNtcDROcEJoSFRFQ2wzVnJTRXE3dXIrT1ZpYkFzQ3RIaWJJM2xDNUhcL3lRYlJObkloTGV0Sngwa05RXC8wZ2NlQXp0Y1FDQVhlRXhPRkZrN0U9IiwidiI6MywiaXYiOiJlWGtUZ0cxcDJOUWhrdmJ2S3NSVm9RPT0iLCJpYXQiOjE1ODc2MDYxMjUuOTA2fQ.vkydrZKqvZI3eBbddveFUfOl2F8wJHAzO6swgmZimhI',
          CLIENT_REQUEST_ID: clientRequestId
        }));
  }
}
