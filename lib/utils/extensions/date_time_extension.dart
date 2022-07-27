import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/widgets/timer/time_date_widget.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:intl/intl.dart';

enum TimeRange { HOM_NAY, TUAN_NAY, THANG_NAY, NAM_NAY }

extension DateFormatString on DateTime {
  String get toStringWithAMPM {
    var dateString = '';
    try {
      dateString = DateFormat.jm('en').format(this);
    } catch (e) {
      return '';
    }
    return dateString;
  }

  String get toFormat24h {
    var dateString = '';
    try {
      dateString = DateFormat.Hm('en').format(this);
    } catch (e) {
      return '';
    }
    return dateString;
  }

  String get formatDdMMYYYY {
    final dateString =
        DateFormat(DateTimeFormat.DAY_MONTH_YEAR, 'en').add_jm().format(this);
    return dateString;
  }

  String get toStringWithListFormat {
    final dateString = DateFormat(DateTimeFormat.DAY_MONTH_YEAR).format(this);
    return dateString;
  }

  String get toStringDMYHHMM {
    final dateString = DateFormat(DateTimeFormat.DATE_DD_MM_HM).format(this);
    return dateString;
  }

  String get formatDayCalendar {
    final dateString =
        (DateFormat(' dd-MM, yyyy').format(this)).replaceAll('-', ' tháng ');

    return dateString;
  }

  String get formatApi {
    return DateFormat(DateTimeFormat.DOB_FORMAT).format(this);
  }

  String get formatTime {
    return DateFormat(DateTimeFormat.DATE_TIME_24).format(this);
  }

  String get formatApiSS {
    return DateFormat(DateTimeFormat.DATE_TIME_20).format(this);
  }

  String get formatApiTaoBieuQuyet {
    return DateFormat(DateTimeFormat.DATE_TIME_21).format(this);
  }

  String get formatBieuQuyetChooseTime {
    return DateFormat(DateTimeFormat.DEFAULT_FORMAT).format(this);
  }

  String get formatApiSuaPhienHop {
    return DateFormat(DateTimeFormat.DATE_TIME_PUT_EDIT).format(this);
  }

  String get formatYKienChiTietHop {
    return DateFormat(DateTimeFormat.DATE_TIME_PICKER).format(this);
  }

  String get formatApiListBieuQuyet {
    return DateFormat(DateTimeFormat.DATE_TIME_22).format(this);
  }
  String get formatStartTimeSuaBieuQuyet {
    return DateFormat(DateTimeFormat.DAY_MONTH_YEAR).format(this);
  }

  String get formatApiListBieuQuyetMobile {
    return DateFormat(DateTimeFormat.DATE_TIME_PICKER).format(this);
  }
  String get formatApiHHMM {
    return DateFormat(DateTimeFormat.DATE_TIME_24).format(this);
  }
  String get formatPAKN {
    return DateFormat(DateTimeFormat.DATE_TIME_23).format(this);
  }

  String get formatApiSSAM {
    return DateFormat(DateTimeFormat.DAY_MONTH_YEAR, 'en')
        .add_jms()
        .format(this);
  }

  String get formatApiDetailSSAM {
    return DateFormat('HH:ss').format(this);
  }

  String get formatApiFixMeet {
    return DateFormat(DateTimeFormat.DATE_TIME_24).format(this);
  }

  String get formatApiStartDay {
    return DateFormat(DateTimeFormat.DATE_TIME_26).format(this);
  }

  String get formatApiFix {
    return DateFormat(DateTimeFormat.DATE_TIME_27).format(this);
  }

  String get formatApiEndDay {
    return DateFormat(DateTimeFormat.DATE_TIME_28).format(this);
  }

  String get formatApiDDMMYYYY {
    return DateFormat(DateTimeFormat.DAY_MONTH_YEAR_BETWEEN).format(this);
  }

  String get formatApiDDMMYYYYSlash {
    return DateFormat(DateTimeFormat.DAY_MONTH_YEAR).format(this);
  }

  String get startEndWeek {
    final day = DateTime(year, month, this.day);

    final startDate = day.subtract(Duration(days: day.weekday - 1));
    final endDate = day.add(Duration(days: DateTime.daysPerWeek - day.weekday));

    return '${startDate.formatMonth} - ${endDate.formatDayCalendar}';
  }

  String get formatDateTime {
    final dateString = (DateFormat(
                '${DateTimeFormat.DATE_TIME_24} ,${DateTimeFormat.DATE_TIME_29}')
            .format(this))
        .replaceAll('-', ' tháng ');

    return dateString;
  }

  String get formatMonth {
    final dateString = (DateFormat(DateTimeFormat.DATE_TIME_29).format(this))
        .replaceAll('-', ' tháng ');
    return dateString;
  }

  String dateTimeFormatter({required String pattern}) {
    return DateFormat(pattern).format(this);
  }

  String tryDateTimeFormatter({required String pattern}) {
    try {
      return DateFormat(pattern).format(this);
    } catch (_) {
      return '';
    }
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
