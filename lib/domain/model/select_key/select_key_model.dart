import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:hive/hive.dart';

part 'select_key_model.g.dart';

@HiveType(typeId: 4)
class SelectkeyModel {
  @HiveField(0)
  String key;
  @HiveField(1)
  String startDate;
  @HiveField(2)
  String endDate;
  SelectKey selectKey = SelectKey.HOM_NAY;

  SelectkeyModel({required this.key, this.startDate = '', this.endDate = ''}) {
    startDate = DateTime.now().toString();
    endDate = DateTime.now().toString();
    selectKey = fromEnum();
  }

  SelectKey fromEnum() {
    if (key == SelectKey.HOM_NAY.toString()) {
      final data = DateTime.now().dateTimeFormRange();
      startDate = data[0].toString();
      endDate = data[1].toString();
      return SelectKey.HOM_NAY;
    } else if (key == SelectKey.TUAN_NAY.toString()) {
      final data =
          DateTime.now().dateTimeFormRange(timeRange: TimeRange.TUAN_NAY);
      startDate = data[0].toString();
      endDate = data[1].toString();
      return SelectKey.TUAN_NAY;
    } else if (key == SelectKey.THANG_NAY.toString()) {
      final data =
          DateTime.now().dateTimeFormRange(timeRange: TimeRange.THANG_NAY);
      startDate = data[0].toString();
      endDate = data[1].toString();
      return SelectKey.THANG_NAY;
    } else if (key == SelectKey.NAM_NAY.toString()) {
      final data =
          DateTime.now().dateTimeFormRange(timeRange: TimeRange.NAM_NAY);
      startDate = data[0].toString();
      endDate = data[1].toString();
      return SelectKey.NAM_NAY;
    } else if (key == SelectKey.TUY_CHON.toString()) {
      return SelectKey.TUY_CHON;
    } else if (key == SelectKey.DON_VI.toString()) {
      return SelectKey.DON_VI;
    } else if (key == SelectKey.CA_NHAN.toString()) {
      return SelectKey.CA_NHAN;
    }
    return SelectKey.HOM_NAY;
  }
}
