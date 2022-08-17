import 'package:ccvc_mobile/ho_tro_ky_thuat_module/utils/constants/app_constants.dart';
import 'package:intl/intl.dart';

extension DateFormatString on DateTime {
  String get toStringWithListFormat {
    final dateString =
        DateFormat(DateTimeFormat.DATE_TIME_FORMAT_8).format(this);
    return dateString;
  }

  String get formatApiLichSu {
    return DateFormat(DateTimeFormat.DATE_BE_RESPONSE_FORMAT).format(this);
  }
}
