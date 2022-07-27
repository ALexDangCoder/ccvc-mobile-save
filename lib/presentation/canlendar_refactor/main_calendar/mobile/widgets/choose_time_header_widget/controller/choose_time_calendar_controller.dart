import 'package:ccvc_mobile/presentation/canlendar_refactor/main_calendar/mobile/widgets/choose_time_header_widget/choose_time_item.dart';
import 'package:ccvc_mobile/widgets/calendar/table_calendar/src/shared/utils_phone.dart';
import 'package:flutter/cupertino.dart';

class ChooseTimeController {
  ValueNotifier<DateTime> selectDate = ValueNotifier(DateTime.now());
  ValueNotifier<bool> isShowCalendarType = ValueNotifier(false);
  ValueNotifier<CalendarType> calendarType = ValueNotifier(CalendarType.DAY);
  DateTime pageTableCalendar = DateTime.now();
  int page = 0;
  ValueNotifier<CalendarFormat> calendarFormat =
      ValueNotifier(CalendarFormat.week);
  void onExpandCalendar() {
    if (calendarFormat.value == CalendarFormat.week) {
      calendarFormat.value = CalendarFormat.month;
    } else {
      calendarFormat.value = CalendarFormat.week;
    }
  }

  void onCloseCalendar() {
    if (calendarFormat.value == CalendarFormat.week) {
      return;
    } else {
      calendarFormat.value = CalendarFormat.week;
    }
  }

  void calendarTypeDefault() {
    if (calendarType.value == CalendarType.YEAR) {
      calendarType.value = CalendarType.DAY;
    }
  }

  void nextTime() {
    try {
      switch (calendarType.value) {
        case CalendarType.DAY:
          _nextDay();
          break;
        case CalendarType.WEEK:
          _nextWeek();
          break;
        case CalendarType.MONTH:
          _nextMonth();
          break;
        case CalendarType.YEAR:
          _nextYear();
      }
    } catch (_) {}
  }

  void backTime() {
    try {
      switch (calendarType.value) {
        case CalendarType.DAY:
          _nextDay(isBack: true);
          break;
        case CalendarType.WEEK:
          _nextWeek(isBack: true);
          break;
        case CalendarType.MONTH:
          _nextMonth(isBack: true);
          break;
        case CalendarType.YEAR:
          _nextYear(isBack: true);
          break;
      }
    } catch (_) {}
  }

  void _nextDay({bool isBack = false}) {
    int day = 0;
    if (isBack) {
      day = selectDate.value.millisecondsSinceEpoch - (24 * 60 * 60 * 1000);
    } else {
      day = selectDate.value.millisecondsSinceEpoch + (24 * 60 * 60 * 1000);
    }
    pageTableCalendar = DateTime.fromMillisecondsSinceEpoch(day);

    /// cộng thêm 24 giờ dạng millisecond;
    selectDate.value = pageTableCalendar;
  }

  void _nextWeek({bool isBack = false}) {
    int day = 0;
    if (isBack) {
      day = selectDate.value.millisecondsSinceEpoch - (7 * 24 * 60 * 60 * 1000);
    } else {
      day = selectDate.value.millisecondsSinceEpoch + (7 * 24 * 60 * 60 * 1000);
    }

    /// cộng thêm 7 ngày dạng millisecond;
    pageTableCalendar = DateTime.fromMillisecondsSinceEpoch(day);
    selectDate.value = pageTableCalendar;
  }

  void _nextMonth({bool isBack = false}) {
    int day = 0;
    if (isBack) {
      day =
          selectDate.value.millisecondsSinceEpoch - (30 * 24 * 60 * 60 * 1000);
    } else {
      day =
          selectDate.value.millisecondsSinceEpoch + (30 * 24 * 60 * 60 * 1000);
    }

    /// cộng thêm 30 ngày dạng millisecond;
    pageTableCalendar = DateTime.fromMillisecondsSinceEpoch(day);
    selectDate.value = pageTableCalendar;
  }

  void _nextYear({bool isBack = false}) {
    DateTime day = DateTime.now();
    final date = selectDate.value;
    if (isBack) {
      day = DateTime(date.year - 1, date.month, date.day);
    } else {
      day = DateTime(date.year + 1, date.month, date.day);
    }

    selectDate.value = day;
  }
}
