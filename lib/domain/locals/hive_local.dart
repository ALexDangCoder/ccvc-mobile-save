import 'package:ccvc_mobile/domain/model/account/data_user.dart';
import 'package:ccvc_mobile/domain/model/account/user_infomation.dart';
import 'package:ccvc_mobile/domain/model/select_key/select_key_model.dart';
import 'package:hive/hive.dart';

class HiveLocal {
  static const USER_INFO = 'USER_INFO';
  static const SELECT_KEY = 'SELECT_KEY';
  static late Box<DataUser> _userBox;
  static late Box<SelectkeyModel> _selectKey;
  static Future<void> init() async {
    Hive.registerAdapter(DataUserAdapter());
    Hive.registerAdapter(UserInformationAdapter());
    Hive.registerAdapter(DonViGocAdapter());
    Hive.registerAdapter(DonViTrucThuocAdapter());
    Hive.registerAdapter(SelectkeyModelAdapter());
    _userBox = await Hive.openBox(USER_INFO);
    _selectKey = await Hive.openBox(SELECT_KEY);
  }

  static void saveDataUser(DataUser dataUser) {
    _userBox.add(dataUser);
  }

  static void clearData() {
    _userBox.clear();
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
}
