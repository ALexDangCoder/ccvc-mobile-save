import 'package:ccvc_mobile/home_module/utils/constants/app_constants.dart';
import 'package:intl/intl.dart';

import '/generated/l10n.dart';

enum TimeRange { HOM_NAY, TUAN_NAY, THANG_NAY, NAM_NAY }

extension DateFormatString on DateTime {
  String get toStringWithAMPM {
    final dateString = DateFormat.jm('en').format(this);
    return dateString;
  }

  String get formatDdMMYYYY {
    final dateString =
        DateFormat('dd/MM/yyyy ').format(this) + toStringWithAMPM;
    return dateString;
  }

  String get toStringWithListFormat {
    final dateString = DateFormat('dd/MM/yyyy').format(this);
    return dateString;
  }

  String get formatDayCalendar {
    final dateString =
        (DateFormat(' dd-MM, yyyy').format(this)).replaceAll('-', ' tháng ');

    return dateString;
  }

  String get formatApi {
    return DateFormat('yyyy-MM-dd').format(this);
  }

  String get formatApiSS {
    return DateFormat('yyyy/MM/dd HH:mm:ss').format(this);
  }

  String get formatApiStartDay {
    return DateFormat('yyyy/MM/dd 00:00:00').format(this);
  }

  String get formatApiEndDay {
    return DateFormat('yyyy/MM/dd 23:59:59').format(this);
  }

  String get formatApiDDMMYYYY {
    return DateFormat(DATE_FORMAT_DDMMYYYY).format(this);
  }
  String get formatApiDDMMYYYYHHMM {
    return DateFormat(DATE_FORMAT_THIEP_SINH_NHAT).format(this);
  }
  String get formatApiDDMMYYYYHHSS {
    return DateFormat('dd/mm/yyyy HH:ss').format(this);
  }

  String get startEndWeek {
    final day = DateTime(year, month, this.day);

    final startDate = day.subtract(Duration(days: day.weekday - 1));
    final endDate = day.add(Duration(days: DateTime.daysPerWeek - day.weekday));

    return '${startDate.formatMonth} - ${endDate.formatDayCalendar}';
  }

  String get formatDateTime {
    final dateString =
        (DateFormat('HH:mm ,dd-MM').format(this)).replaceAll('-', ' tháng ');

    return dateString;
  }

  String get formatMonth {
    final dateString =
        (DateFormat('dd-MM').format(this)).replaceAll('-', ' tháng ');

    return dateString;
  }

  String getDayofWeekTxt() {
    switch (weekday) {
      case 1:
        return S.current.thu_hai;
      case 2:
        return S.current.thu_ba;
      case 3:
        return S.current.thu_tu;
      case 4:
        return S.current.thu_nam;
      case 5:
        return S.current.thu_sau;
      case 6:
        return S.current.thu_bay;
      case 7:
        return S.current.chu_nhat;
    }
    return '';
  }

  List<DateTime> dateTimeFormRange({TimeRange timeRange = TimeRange.HOM_NAY}) {
    switch (timeRange) {
      case TimeRange.HOM_NAY:
        return [this, this];

      case TimeRange.TUAN_NAY:
        return _tuanNay();
      case TimeRange.THANG_NAY:
        return _thangNay();
      case TimeRange.NAM_NAY:
        return _namNay();
    }
  }

  List<DateTime> _tuanNay() {
    final startDate = _getDate(subtract(Duration(days: weekday - 1)));
    final endDate =
        _getDate(add(Duration(days: DateTime.daysPerWeek - weekday)));
    return [startDate, endDate];
  }

  List<DateTime> _thangNay() {
    final startDate = DateTime(
      year,
      month,
    );
    final endDate = DateTime.fromMillisecondsSinceEpoch(
      DateTime.utc(
        year,
        month + 1,
      ).subtract(const Duration(days: 1)).millisecondsSinceEpoch,
    );
    return [startDate, endDate];
  }

  List<DateTime> _namNay() {
    final startDate = DateTime(year, 1, 1);

    return [startDate, DateTime(year, 12, 31)];
  }

  DateTime _getDate(DateTime d) => DateTime(d.year, d.month, d.day);
}
