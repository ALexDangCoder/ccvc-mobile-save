import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:hive/hive.dart';
part 'select_key_model.g.dart';

@HiveType(typeId: 4)
class SelectkeyModel {
  @HiveField(0)
  final String key;
  @HiveField(1)
  final String startDate;
  @HiveField(2)
  final String endDate;
  SelectKey selectKey = SelectKey.HOM_NAY;
  SelectkeyModel({required this.key, this.startDate = '', this.endDate = ''}) {
    selectKey = fromEnum();
  }
  SelectKey fromEnum() {
    if (key == SelectKey.HOM_NAY.toString()) {
      return SelectKey.HOM_NAY;
    } else if (key == SelectKey.TUAN_NAY.toString()) {
      return SelectKey.TUAN_NAY;
    } else if (key == SelectKey.THANG_NAY.toString()) {
      return SelectKey.THANG_NAY;
    } else if (key == SelectKey.NAM_NAY.toString()) {
      return SelectKey.NAM_NAY;
    } else if (key == SelectKey.TUY_CHON.toString()) {
      return SelectKey.TUY_CHON;
    }
    return SelectKey.HOM_NAY;
  }
}
