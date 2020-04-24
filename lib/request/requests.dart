import 'package:dio/dio.dart';
import 'package:flutter_jellow/model/moments_vo.dart';

final Dio dio = Dio(
  BaseOptions(
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
    baseUrl: 'https://api.jellow.club/1.0',
    connectTimeout: 10000,
  ),
);

Future<MomentsVo> recommendFeedList() async {
  var data = {"trigger": "user", "limit": 10};
  var resp = await dio.post('/recommendFeed/list', data: data);
  return MomentsVo.fromJson(resp.data);
}

Future<String> mediaMeta({String id, String type}) async {
  var resp = await dio.post(
    'https://api.jellow.club/1.0/mediaMeta/interactive',
    queryParameters: {'id': id, 'type': type, 'trigger': 'auto'},
  );
  print('@@ >> ' + resp.data.toString());
  return resp.data['url'];
}
