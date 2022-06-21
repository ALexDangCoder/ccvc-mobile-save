import 'package:ccvc_mobile/presentation/canlendar_refactor/main_calendar/widgets/choose_time_header_widget/choose_time_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:ccvc_mobile/widgets/calendar/table_calendar/src/shared/utils_phone.dart';

class ChooseTimeController {
  ValueNotifier<DateTime> selectDate = ValueNotifier(DateTime.now());
  ValueNotifier<bool> isShowCalendarType = ValueNotifier(false);
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

  CalendarType calendarType = CalendarType.DAY;
  void nextTime() {
    switch (calendarType) {
      case CalendarType.DAY:
        _nextDay();
        break;
      case CalendarType.WEEK:
        _nextWeek();
        break;
      case CalendarType.MONTH:
        _nextMonth();
        break;
    }
  }

  void backTime() {
    switch (calendarType) {
      case CalendarType.DAY:
        _nextDay(isBack: true);
        break;
      case CalendarType.WEEK:
        _nextWeek(isBack: true);
        break;
      case CalendarType.MONTH:
        _nextMonth(isBack: true);
        break;
    }
  }

  void _nextDay({bool isBack = false}) {
    int day = 0;
    if (isBack) {
      day = selectDate.value.millisecondsSinceEpoch - (24 * 60 * 60 * 1000);
    } else {
      day = selectDate.value.millisecondsSinceEpoch + (24 * 60 * 60 * 1000);
    }

    /// cộng thêm 24 giờ dạng millisecond;
    selectDate.value = DateTime.fromMillisecondsSinceEpoch(day);
  }

  void _nextWeek({bool isBack = false}) {
    int day = 0;
    if (isBack) {
      day = selectDate.value.millisecondsSinceEpoch - (7 * 24 * 60 * 60 * 1000);
    } else {
      day = selectDate.value.millisecondsSinceEpoch + (7 * 24 * 60 * 60 * 1000);
    }

    /// cộng thêm 7 ngày dạng millisecond;
    selectDate.value = DateTime.fromMillisecondsSinceEpoch(day);
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
    selectDate.value = DateTime.fromMillisecondsSinceEpoch(day);
  }
}
