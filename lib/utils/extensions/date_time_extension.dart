import 'dart:developer';

import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:intl/intl.dart';


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

  String get formatDateTime {
    final dateString =
        (DateFormat('HH:mm ,dd-MM').format(this)).replaceAll('-', ' tháng ');

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
    DateTime now = DateTime.now();
    final firstDayThisMonth = DateTime(now.year, now.month, now.day);
    final firstDayNextMonth = DateTime(
      firstDayThisMonth.year,
      firstDayThisMonth.month + 1,
      firstDayThisMonth.day,
    );
    final int c = firstDayNextMonth.difference(firstDayThisMonth).inDays;
    int b = now.millisecondsSinceEpoch;
    b = b - (c * 24 * 60 * 60 * 1000);
    now = DateTime.fromMillisecondsSinceEpoch(b);

    final startDate = DateTime.fromMillisecondsSinceEpoch(
      DateTime.utc(
        now.year,
        now.month,
      ).millisecondsSinceEpoch,
    );
    final endDate = DateTime.fromMillisecondsSinceEpoch(
      DateTime.utc(
        now.year,
        now.month + 1,
      ).subtract(const Duration(days: 1)).millisecondsSinceEpoch,
    );
    return [startDate, endDate];
  }

  List<DateTime> _namNay() {
    DateTime now = DateTime.now();
    final startDate = DateTime(now.year, 1, 1);

    return [startDate, DateTime(DateTime.now().year, 12, 31)];
  }

  DateTime _getDate(DateTime d) => DateTime(d.year, d.month, d.day);
}
