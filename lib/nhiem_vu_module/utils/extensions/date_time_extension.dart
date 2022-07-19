import 'package:ccvc_mobile/nhiem_vu_module/utils/constants/app_constants.dart';
import 'package:intl/intl.dart';

enum TimeRange { HOM_NAY, TUAN_NAY, THANG_NAY, NAM_NAY }

extension DateFormatString on DateTime {
  String get toStringWithAMPM {
    final dateString = DateFormat.jm('en').format(this);
    return dateString;
  }

  String get formatDdMMYYYY {
    final dateString =
        DateFormat(DateTimeFormat.DAY_MONTH_YEAR, 'en').add_jm().format(this);
    return dateString;
  }

  String get formatApi {
    return DateFormat(DateTimeFormat.DOB_FORMAT).format(this);
  }
}
