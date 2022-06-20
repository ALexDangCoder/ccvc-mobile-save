import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/widgets/timer/time_date_widget.dart';
import 'package:intl/intl.dart';

enum TimeRange { HOM_NAY, TUAN_NAY, THANG_NAY, NAM_NAY }

extension DateFormatString on DateTime {
  String get toStringWithAMPM {
    var dateString = '';
    try {
      dateString = DateFormat.jm('en').format(this);
    }
     catch(e){
      return '';
     }
    return dateString;
  }

  String get toStringWithAMPMJMS {
    final dateString = DateFormat.jms('en').format(this);
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

  String get formatApiTaoBieuQuyet {
    return DateFormat('yyyy-MM-ddTHH:mm').format(this);
  }
String get formatBE {
    return DateFormat('yyyy-MM-ddTHH:mm:ss').format(this);
  }

  String get formatApiSuaPhienHop {
    return DateFormat('yyyy-MM-dd HH:mm').format(this);
  }

  String get formatHourMinute {
    return DateFormat('HH:mm').format(this);
  }

  String get formatApiListBieuQuyet {
    return DateFormat('yyyy/MM/dd HH:mm').format(this);
  }

  String get formatApiListBieuQuyetMobile {
    return DateFormat('dd/MM/yyyy HH:mm').format(this);
  }

  String get formatApiSSAM {
    return DateFormat('dd/MM/yyyy ').format(this) + toStringWithAMPMJMS;
  }

  String get formatApiDetailSSAM {
    return DateFormat('HH:ss').format(this);
  }

  String get formatApiFixMeet {
    return DateFormat('HH:mm').format(this);
  }

  String get formatApiHH {
    return DateFormat('HH:mm:ss').format(this);
  }

  String get formatApiStartDay {
    return DateFormat('yyyy/MM/dd 00:00:00').format(this);
  }

  String get formatApiFix {
    return DateFormat('yyyy-MM-dd 00:00:00').format(this);
  }

  String get formatApiEndDay {
    return DateFormat('yyyy/MM/dd 23:59:59').format(this);
  }

  String get formatApiDDMMYYYY {
    return DateFormat('dd-MM-yyyy').format(this);
  }

  String get formatApiPut {
    return DateFormat('yyyy-MM-ddTHH:mm:ss').format(this);
  }

  String get formatApiDDMMYYYYSlash {
    return DateFormat('dd/MM/yyyy').format(this);
  }

  String get formatApiTung {
    return DateFormat('yyyy/MM/dd HH:mm').format(this);
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

  String dateTimeFormatter({required String pattern}) {
    return DateFormat(pattern).format(this);
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

extension TimeFormatString on TimerData {
  String get timerToString {
    String hour = this.hour.toString();
    String minute = minutes.toString();
    if (this.hour < 10) {
      hour = '0${this.hour}';
    }
    if (minutes < 10) {
      minute = '0$minutes';
    }
    return '$hour:$minute';
  }

}
