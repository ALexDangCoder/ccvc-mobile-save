import 'dart:async';

import 'package:ccvc_mobile/domain/model/account/data_user.dart';
import 'package:ccvc_mobile/domain/model/account/permission_app_model.dart';
import 'package:ccvc_mobile/domain/model/account/user_infomation.dart';
import 'package:ccvc_mobile/domain/model/select_key/select_key_model.dart';
import 'package:hive/hive.dart';
import 'package:queue/queue.dart';

enum PermissionType { QLVB, PAKN, VPDT, QLNV, HTKT,HTCS }

class HiveLocal {
  static const USER_INFO = 'USER_INFO';
  static const SELECT_KEY = 'SELECT_KEY';
  static const LIST_PERMISSION = 'LIST_PERMISSION';
  static const _APP_THEME = 'APP_THEME';
  static late Box<DataUser> _userBox;
  static late Box<SelectkeyModel> _selectKey;
  static late Box<String> _tagKey;
  static late Box<PermissionApp> _listPermission;
  static const TAG_KEY = 'TAG_KEY';

  static Future<void> init() async {
    Hive.registerAdapter(DataUserAdapter());
    Hive.registerAdapter(UserInformationAdapter());
    Hive.registerAdapter(DonViGocAdapter());
    Hive.registerAdapter(DonViTrucThuocAdapter());
    Hive.registerAdapter(SelectkeyModelAdapter());
    Hive.registerAdapter(PermissionModelAdapter());
    Hive.registerAdapter(PermissionAppAdapter());
    final que = Queue(parallel: 5);
    unawaited(que.add(() async => _userBox = await Hive.openBox(USER_INFO)));
    unawaited(que.add(() async => _selectKey = await Hive.openBox(SELECT_KEY)));
    unawaited(que.add(() async => _tagKey = await Hive.openBox(TAG_KEY)));
    unawaited(que.add(
        () async => _listPermission = await Hive.openBox(LIST_PERMISSION)));
    await que.onComplete;
    que.cancel();
  }

  static Future<void> saveDataUser(DataUser dataUser) async {
    await _userBox.clear();
    await _userBox.add(dataUser);
  }

  static void clearData() {
    _userBox.clear();
    _selectKey.clear();
    _tagKey.clear();
    _listPermission.clear();
  }

  static Future<void> savePermission(PermissionApp permissionApp) async {
    await _listPermission.clear();
    await _listPermission.add(permissionApp);
  }

  static bool checkPermissionApp(
      {PermissionType permissionType = PermissionType.PAKN,
      String permissionTxt = ''}) {
    final values = _listPermission.values.toList();
    if (values.isNotEmpty) {
      final result = values.first;
      switch (permissionType) {
        case PermissionType.QLVB:
          return result.qLVB
                  .indexWhere((element) => element.name == permissionTxt) !=
              -1;
        case PermissionType.PAKN:
          return result.pAKN
                  .indexWhere((element) => element.name == permissionTxt) !=
              -1;
        case PermissionType.VPDT:
          return result.vPDT
                  .indexWhere((element) => element.name == permissionTxt) !=
              -1;
        case PermissionType.QLNV:
          return result.qLNV
                  .indexWhere((element) => element.name == permissionTxt) !=
              -1;
        case PermissionType.HTCS:
          return result.hTCS
              .indexWhere((element) => element.name == permissionTxt) !=
              -1;
        case PermissionType.HTKT:
          return result.hTKT
              .indexWhere((element) => element.name == permissionTxt) !=
              -1;
      }
    } else {
      return false;
    }
  }

  static DataUser? getDataUser() {
    final data = _userBox.values;
    if (data.isNotEmpty) {
      return data.first;
    }
  }

  static Future<void> setSelect(
      {required String path, required SelectkeyModel selectkeyModel}) async {
    await _selectKey.put(path, selectkeyModel);
  }

  static SelectkeyModel? getSelect(String path) {
    return _selectKey.get(path);
  }

  static Future<void> addTag(String tag) async {
    await _tagKey.add(tag);
  }

  static void removeTag(String tag) {
    final index =
        _tagKey.values.toList().indexWhere((element) => element == tag);
    if (index != -1) {
      _tagKey.deleteAt(index);
    }
  }

  static List<String> getTag() {
    return _tagKey.values.toList();
  }

  static Future<void> addTagList(List<String> tagList) async {
    await _tagKey.addAll(tagList);
  }
}
