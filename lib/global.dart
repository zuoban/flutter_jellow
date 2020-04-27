import 'package:flutter/cupertino.dart';
import 'package:flutter_jellow/common/entity/entity.dart';
import 'package:flutter_jellow/common/util/storage.dart';
import 'package:flutter_jellow/common/value/value.dart';

class Global {
  /// 用户配置
  static UserProfile profile = UserProfile(accessToken: null);

  static bool get isRelease => bool.fromEnvironment('dart.vm.product');

  static bool isOfflineLogin = false;

  /// init
  static Future init() async {
    /// 运行初始
    WidgetsFlutterBinding.ensureInitialized();

    ///  StorageUtil
    await StorageUtil.init();

    var _profileJSON = StorageUtil().getJSON(STORAGE_USER_PROFILE_KEY);
    if (_profileJSON != null) {
      profile = UserProfile.fromJson(_profileJSON);
      isOfflineLogin = true;
    }
  }

  static Future<bool> saveProfile(UserProfile userProfile) {
    profile = userProfile;
    return StorageUtil()
        .setJSON(STORAGE_USER_PROFILE_KEY, userProfile.toJson());
  }
}
