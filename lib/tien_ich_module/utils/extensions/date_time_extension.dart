import 'package:ccvc_mobile/tien_ich_module/utils/constants/app_constants.dart';
import 'package:intl/intl.dart';

enum TimeRange { HOM_NAY, TUAN_NAY, THANG_NAY, NAM_NAY }

extension DateFormatString on DateTime {
  String get toStringWithListFormat {
    final dateString = DateFormat(DateTimeFormat.DAY_MONTH_YEAR).format(this);
    return dateString;
  }

  String get toStringDay {
    final dateString = DateFormat('dd').format(this);
    return dateString;
  }

  String get toStringMonthYear {
    final dateString =
        'Tháng ${DateFormat('MM').format(this)} Năm ${DateFormat('yyyy').format(this)}';
    return dateString;
  }

  String get toStringMonth_Year {
    final dateString =
        'Tháng ${DateFormat('MM').format(this)} - ${DateFormat('yyyy').format(this)}';
    return dateString;
  }

  String get formatApiLichSu {
    return DateFormat(DateTimeFormat.DATE_BE_RESPONSE_FORMAT).format(this);
  }

  String get formatApiDanhBa {
    return DateFormat(DateTimeFormat.DATE_TIME_RECEIVE).format(this);
  }

  String get formatApiDDMMYYYY {
    return DateFormat(DateTimeFormat.DAY_MONTH_YEAR_BETWEEN).format(this);
  }

  String get formatApiMMYYYY {
    return DateFormat('MM-yyyy').format(this);
  }
}
