import 'package:flutter/material.dart';
import 'package:flutter_jellow/common/api/api.dart';
import 'package:flutter_jellow/common/util/storage.dart';
import 'package:flutter_jellow/common/value/storage.dart';
import 'package:flutter_jellow/model/moments_vo.dart';

class MomentProvider with ChangeNotifier {
  MomentList _momentList;
  List<Data> get moments => _momentList?.data ?? [];

  getMoments() async {
    print(_momentList);
    if (moments.isEmpty) {
      StorageUtil().remove(STORAGE_MOMENTS_KEY);
      final Map<String, dynamic> momentMap =
          StorageUtil().getJSON(STORAGE_MOMENTS_KEY) ?? {};
      _momentList = MomentList.fromJson(momentMap);
    }

    final result = await MomentsAPI.recommendFeedList();
    _momentList.data = _momentList.data ?? [];
    _momentList.data.insertAll(0, result.data);
    StorageUtil().setJSON(STORAGE_MOMENTS_KEY, _momentList);
    notifyListeners();
  }
}
