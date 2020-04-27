import 'package:flutter_jellow/common/util/http.dart';
import 'package:flutter_jellow/model/moments_vo.dart';

class MomentsAPI {
  static Future<MomentsVo> recommendFeedList() async {
    var data = {"trigger": "user", "limit": 10};
    var resp = await HttpUtil()
        .request('/recommendFeed/list', method: 'post', data: data);
    return MomentsVo.fromJson(resp.data);
  }

  static Future<Map<String, dynamic>> mediaMeta(
      {String id, String type}) async {
    var resp = await HttpUtil().request(
      'https://api.jellow.club/1.0/mediaMeta/interactive',
      method: 'post',
      queryParameters: {'id': id, 'type': type, 'trigger': 'auto'},
    );
    var result = {'url': resp.data['url'], 'headers': resp.data['headers']};
    return result;
  }
}
